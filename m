Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291258AbSCHXo4>; Fri, 8 Mar 2002 18:44:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291194AbSCHXof>; Fri, 8 Mar 2002 18:44:35 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:33798 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S291245AbSCHXoX>; Fri, 8 Mar 2002 18:44:23 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] Futexes IV (Fast Lightweight Userspace Semaphores)
Date: 8 Mar 2002 15:43:56 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <a6bibs$9mu$1@cesium.transmeta.com>
In-Reply-To: <E16jRAU-0007QU-00@the-village.bc.nu> <Pine.LNX.4.33.0203081252450.1412-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2002 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.LNX.4.33.0203081252450.1412-100000@penguin.transmeta.com>
By author:    Linus Torvalds <torvalds@transmeta.com>
In newsgroup: linux.dev.kernel
> 
> On Fri, 8 Mar 2002, Alan Cox wrote:
> > 
> > Can we go to cache line alignment - for an array of locks thats clearly
> > advantageous
> 
> I disagree about the "clearly". Firstly, the cacheline alignment is CPU 
> dependent, so on some CPU's it's 32 bytes (or even 16), on others it is 
> 128 bytes. 
> 
> Secondly, a lot of locking is actually done inside a single thread, and
> false sharing doesn't happen much - so keeping the locks dense can be
> quite advantageous.
> 
> The cases where false sharing _does_ happen and are a problem should be 
> for the application writer to worry about, not for the kernel to force.
> 
> So I think 8 bytes is plenty fine enough - with 16 bytes a remote 
> possibility (I don't think it is needed, but it gives you som epadding for 
> future expansion). And people who have arrays and find false sharing to be 
> a problem can fix it themselves.
> 
> I personally don't find arrays of locks very common. It's much more common
> to have arrays of data structures that _contain_ locks (eg things like
> having hash tables etc with a per-hashchain lock) and then those container 
> structures may want to be cacheline aligned, but the locks themselves 
> should not need to be.
> 

Also, on UP this is all a waste.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt	<amsp@zytor.com>
