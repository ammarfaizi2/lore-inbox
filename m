Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750769AbWIFHsH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750769AbWIFHsH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 03:48:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751509AbWIFHsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 03:48:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:17869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750769AbWIFHsF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 03:48:05 -0400
Date: Wed, 6 Sep 2006 00:47:24 -0700
From: Andrew Morton <akpm@osdl.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Arjan van de Ven <arjan@infradead.org>,
       Daniel Walker <dwalker@mvista.com>, Hua Zhong <hzhong@gmail.com>
Subject: Re: lockdep oddity
Message-Id: <20060906004724.e52d45a2.akpm@osdl.org>
In-Reply-To: <20060906072043.GC6898@osiris.boeblingen.de.ibm.com>
References: <20060901015818.42767813.akpm@osdl.org>
	<20060905130356.GB6940@osiris.boeblingen.de.ibm.com>
	<20060905181241.GC16207@elte.hu>
	<20060906072043.GC6898@osiris.boeblingen.de.ibm.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Sep 2006 09:20:43 +0200
Heiko Carstens <heiko.carstens@de.ibm.com> wrote:

> I'm also wondering why the profile
> patch contains this:
> 
> +       if (ret)
> +               likeliness->count[1]++;
> +       else
> +               likeliness->count[0]++;
> 
> This isn't smp safe. Is that on purpose or a bug?

Purposeful.   This is called from all contexts, including NMI.
