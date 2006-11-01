Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946196AbWKAAEV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946196AbWKAAEV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 19:04:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946203AbWKAAEV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 19:04:21 -0500
Received: from www.tglx.de ([213.239.205.147]:43931 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1946196AbWKAAEU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 19:04:20 -0500
Subject: Re: [patch 1/1] schedule removal of FUTEX_FD
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, drepper@redhat.com,
       mingo@elte.hu, rusty@rustcorp.com.au
In-Reply-To: <1162338491.11965.101.camel@localhost.localdomain>
References: <200610312309.k9VN9mco015260@shell0.pdx.osdl.net>
	 <1162338491.11965.101.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 01 Nov 2006 01:05:56 +0100
Message-Id: <1162339556.15900.222.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-10-31 at 23:48 +0000, Alan Cox wrote:
> Ar Maw, 2006-10-31 am 15:09 -0800, ysgrifennodd akpm@osdl.org:
> > From: Andrew Morton <akpm@osdl.org>
> > 
> > Apparently FUTEX_FD is unfixably racy and nothing uses it (or if it does, it
> > shouldn't).
> > 
> > Add a warning printk, give any remaining users six months to migrate off it.
> 
> Andrew - please use time based rate limits for this sort of thing, that
> way you actually get to see who is actually using it. 

Not really: It might be one time calls, so a time based rate limit might
exclude apps which get executed in a row.

Maybe some thread->deprecated bitfield which rate limits the deprecated
warning per caller would be an alternative solution. We should not have
more than 32 of such deprecated functions at once. Of cource it would
still spam the logs when high frequency forking servers use such
interfaces, but I think the probability is low.

	tglx


