Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbULTUqh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbULTUqh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Dec 2004 15:46:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261634AbULTUqh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Dec 2004 15:46:37 -0500
Received: from main.gmane.org ([80.91.229.2]:47543 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261632AbULTUpv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Dec 2004 15:45:51 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: "Joseph Seigh" <jseigh_02@xemaps.com>
Subject: Re: What does atomic_read actually do?
Date: Mon, 20 Dec 2004 15:51:37 -0500
Message-ID: <opsjbqwbz6s29e3l@grunion>
References: <opsi7o5nqfs29e3l@grunion> <1103394867.4127.18.camel@laptopd505.fenrus.org> <opsi7xcuizs29e3l@grunion> <1103399680.4127.20.camel@laptopd505.fenrus.org> <opsi707edhs29e3l@grunion> <1103494866.6052.354.camel@localhost> <opsi94i4z0s29e3l@grunion> <20041220125223.GI4424@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed	delsp=yes
Content-Transfer-Encoding: 7BIT
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: stenquists.ne.client2.attbi.com
User-Agent: Opera M2/7.54 (Win32, build 3865)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 Dec 2004 13:52:23 +0100, Andrea Arcangeli <andrea@suse.de>  
wrote:
>
> set_pte_atomic also requires atomicity in
> asm-generic/pgtable.h:ptep_establish, but it's not even using volatile
> and it's a 64bit pointer that we're writing to.  We're relaying on the
> compiler to do the right thing for us. I don't think it's a good idea
> for the long run, but Benjamin on ppc64 rejected my suggestion to
> rewrite set_pte_atomic in asm, so I doubt you'll be able to rewrite
> atomic_read with asm either (because at least atomic_read is an int and
> not a long pointer, and at least atomic_read is a volatile unlike
> set_pte).
>
> My point is that even before worrying about the theoretical correctness
> of atomic_read, I would suggest to worry about set_pte_atomic first,
> which is a lot more likely to break if something. The compiler may truly
> execute two separate writes if power of 2 bitshifts are involved, as the
> optimal compilation of the C source.

Actually, I'm programming out in user space.  I was looking at the atomic.h
stuff to see how much would be usable.  But I have to look at reading
and writing pointers atomically also since that is heavily used in  
lock-free
programming, e.g. RCU for preemptive user threads which I have a couple of
implementations for.  I remember a discussion a while back about dependent
load memory ordering (alpha doesn't have it) for RCU but I don't recall any
discussion of the requirement for gcc to do atomic loads and stores.  I  
guess
it's just assumed.

It would be nice to have macros tied to the linux ones, ie. check the  
current
linux versions when porting them.  But I can always use asm if I have to.   
I'll
probably have to modify the conditions of use to say "no warranty is  
implied
and we really do mean it" and add a compiler flag to select between the  
safe asm
version and the "Do you feel lucky?" C macro version.

Joe Seigh

