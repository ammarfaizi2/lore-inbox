Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932167AbWE3IHI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932167AbWE3IHI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 04:07:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932171AbWE3IHI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 04:07:08 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:64646 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S932167AbWE3IHH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 04:07:07 -0400
Date: Tue, 30 May 2006 10:07:00 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Martin Peschke <mp3@de.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [Patch] statistics infrastructure - update 1
Message-ID: <20060530080700.GA9419@osiris.boeblingen.de.ibm.com>
References: <1148474038.2934.18.camel@dyn-9-152-230-71.boeblingen.de.ibm.com> <20060524155735.04ed777a.akpm@osdl.org> <1148941055.3005.73.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1148941055.3005.73.camel@dyn-9-152-230-71.boeblingen.de.ibm.com>
User-Agent: mutt-ng/devel-r802 (Linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>  	case CPU_UP_PREPARE:
>  		stat->pdata->ptrs[cpu] = statistic_alloc_ptr(stat, GFP_ATOMIC,

Why not GFP_KERNEL?

> +		if (!stat->pdata->ptrs[cpu])
> +			return -ENOMEM;

NOTIFY_BAD instead of -ENOMEM, I guess.

>  		break;
>  	case CPU_UP_CANCELED:
>  	case CPU_DEAD:

I think your merge code (which gets called if CPU_UP_PREPARE fails) expects
stat->pdata->ptrs[cpu] to be non-zero, right?
