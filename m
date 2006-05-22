Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750972AbWEVQaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750972AbWEVQaV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 12:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750973AbWEVQaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 12:30:21 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59358 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1750971AbWEVQaV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 12:30:21 -0400
Date: Mon, 22 May 2006 12:29:49 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de, zach@vmware.com
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range patch
Message-ID: <20060522162949.GG30682@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <1147759423.5492.102.camel@localhost.localdomain> <20060516064723.GA14121@elte.hu> <1147852189.1749.28.camel@localhost.localdomain> <20060519174303.5fd17d12.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060519174303.5fd17d12.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 19, 2006 at 05:43:03PM -0700, Andrew Morton wrote:
> Rusty Russell <rusty@rustcorp.com.au> wrote:
> >
> > Name: Move vsyscall page out of fixmap into normal vma as per mmap
> 
> This causes mysterious hangs when starting init.
> 
> Distro is RH FC1, running SysVinit-2.85-5.
> 
> dmesg, sysrq-T and .config are at
> http://www.zip.com.au/~akpm/linux/patches/stuff/log-vmm - nothing leaps
> out.
> 
> This is the second time recently when a patch has caused this machine to
> oddly hang in init.  It's possible that there's a bug of some form in that
> version of init that we'll need to know about and take care of in some
> fashion.

That's known bug in early glibcs short after adding vDSO support.
The vDSO support has been added in May 2003 to CVS glibc (i.e. post glibc
2.3.2) and the problems have been fixed when they were discovered, in
February 2004:
http://sources.redhat.com/ml/libc-hacker/2004-02/msg00053.html
http://sources.redhat.com/ml/libc-hacker/2004-02/msg00059.html

I strongly believe we want randomized vDSOs, people are already abusing the
fix mapped vDSO for attacks, and I think the unfortunate 10 months of broken
glibc shouldn't stop that forever.  Anyone using such glibc can still use
vdso=0, or do that just once and upgrade to somewhat more recent glibc.

	Jakub
