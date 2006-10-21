Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423251AbWJUANz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423251AbWJUANz (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 20:13:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423257AbWJUANz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 20:13:55 -0400
Received: from nf-out-0910.google.com ([64.233.182.187]:4240 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1423251AbWJUANy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 20:13:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:references:mime-version:content-type:content-disposition:in-reply-to:user-agent;
        b=jNTwdpFUvr/GNc8TPvqijE9ztftDaOcp5L6HCDqHIrzI9vSAfJ5G9ACOrmnknQ5fDvDbjaNbdQzoogirg+pe1MOIAbgMEOdaGzFJVHFw+FV9lxu8pVCeKpkqr7kQFoSoCy7cuXvMvqgiMLldLvJPwnjDf//NlrrC/PbbSf1kHoA=
Date: Sat, 21 Oct 2006 04:13:58 +0400
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] Enforce "unsigned long flags;" when spinlocking
Message-ID: <20061021001358.GB5344@martell.zuzino.mipt.ru>
References: <20061020131544.GC17199@martell.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061020131544.GC17199@martell.zuzino.mipt.ru>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define spin_trylock_irq(lock            ) \
                                   ???????
>  ({ \
> +	BUILD_BUG_ON(sizeof(flags) != sizeof(unsigned long));	\
> +	typecheck(unsigned long, flags);			\

And it's broken. :-\

