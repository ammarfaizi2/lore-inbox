Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268597AbTBZB5J>; Tue, 25 Feb 2003 20:57:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268598AbTBZB5I>; Tue, 25 Feb 2003 20:57:08 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:27921 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268597AbTBZB5H>; Tue, 25 Feb 2003 20:57:07 -0500
Date: Tue, 25 Feb 2003 18:04:38 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Jones <davej@codemonkey.org.uk>
cc: linux-kernel@vger.kernel.org
Subject: Re: Minutes from Feb 21 LSE Call
In-Reply-To: <20030225195339.GA31317@suse.de>
Message-ID: <Pine.LNX.4.44.0302251802230.2370-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 25 Feb 2003, Dave Jones wrote:
> 
>  > Yes, if you don't take advantage of sysenter, then all the sysenter
>  > support will just make us look worse ;(
> 
> Andi's patch[1] to remove one of the wrmsr's from the context switch
> fast path should win back at least some of the lost microbenchmark
> points. 

But the patch is fundamentally broken wrt preemption at least, and it 
looks totally unfixable.

It's also overly complex, for no apparent reason. The simple way to avoid 
the wrmsr of SYSENTER_CS is to just cache a per-cpu copy in memory, 
preferably in some location that is already in the cache at context switch 
time for other reasons.

		Linus

