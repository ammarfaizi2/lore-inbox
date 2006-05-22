Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751045AbWEVRQH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751045AbWEVRQH (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 13:16:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751047AbWEVRQH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 13:16:07 -0400
Received: from smtp.osdl.org ([65.172.181.4]:18310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751045AbWEVRQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 13:16:05 -0400
Date: Mon, 22 May 2006 10:14:54 -0700
From: Andrew Morton <akpm@osdl.org>
To: Zachary Amsden <zach@vmware.com>
Cc: jakub@redhat.com, rusty@rustcorp.com.au, mingo@elte.hu,
       linux-kernel@vger.kernel.org, torvalds@osdl.org,
       virtualization@lists.osdl.org, kraxel@suse.de
Subject: Re: [PATCH] Gerd Hoffman's move-vsyscall-into-user-address-range
 patch
Message-Id: <20060522101454.52551222.akpm@osdl.org>
In-Reply-To: <4471EA60.8080607@vmware.com>
References: <1147759423.5492.102.camel@localhost.localdomain>
	<20060516064723.GA14121@elte.hu>
	<1147852189.1749.28.camel@localhost.localdomain>
	<20060519174303.5fd17d12.akpm@osdl.org>
	<20060522162949.GG30682@devserv.devel.redhat.com>
	<4471EA60.8080607@vmware.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zachary Amsden <zach@vmware.com> wrote:
>
> Jakub Jelinek wrote:
> >
> > That's known bug in early glibcs short after adding vDSO support.
> > The vDSO support has been added in May 2003 to CVS glibc (i.e. post glibc
> > 2.3.2) and the problems have been fixed when they were discovered, in
> > February 2004:
> > http://sources.redhat.com/ml/libc-hacker/2004-02/msg00053.html
> > http://sources.redhat.com/ml/libc-hacker/2004-02/msg00059.html
> >
> > I strongly believe we want randomized vDSOs, people are already abusing the
> > fix mapped vDSO for attacks, and I think the unfortunate 10 months of broken
> > glibc shouldn't stop that forever.  Anyone using such glibc can still use
> > vdso=0, or do that just once and upgrade to somewhat more recent glibc.
> >   
> 
> While I'm now inclined to agree with randomization, I think the default 
> should be off.  You can quite easily "echo 1 > 
> /proc/sys/kernel/vdso_randomization" in the RC scripts, which allows you 
> to maintain compatibility for everyone and get randomization turned on 
> early enough to thwart attacks against any vulnerable daemons.
> 

It kinda sucks but yes, that's obviously least-breakage approach.  It does
mean that many people won't benefit from (and won't test!) the new feature
though.

Unless there's some sneaky way of auto-detecting a modern userspace,
perhaps (something which mounts /sys?).

All very sad.
