Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265670AbTAFB5U>; Sun, 5 Jan 2003 20:57:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265677AbTAFB5U>; Sun, 5 Jan 2003 20:57:20 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:54164 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265670AbTAFB5T>; Sun, 5 Jan 2003 20:57:19 -0500
Date: Mon, 6 Jan 2003 03:05:42 +0100
From: Andi Kleen <ak@muc.de>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@muc.de>, "David S. Miller" <davem@redhat.com>,
       andrew.morton@digeo.com, linux-kernel@vger.kernel.org,
       Mikael Pettersson <mikpe@csd.uu.se>
Subject: Re: [BENCHMARK] Lmbench 2.5.54-mm2 (impressive improvements)
Message-ID: <20030106020542.GA5615@averell>
References: <20030105234617.GA4714@averell> <Pine.LNX.4.44.0301051720420.13313-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301051720420.13313-100000@home.transmeta.com>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 06, 2003 at 02:33:28AM +0100, Linus Torvalds wrote:
> > I can think of some things to speed it up more. e.g. replace all the
> > push / pop in SAVE/RESTORE_ALL with sub $frame,%esp ; movl %reg,offset(%esp) 
> > and movl offset(%esp),%reg ; addl $frame,%esp. This way the CPU has 
> > no dependencies between all the load/store options unlike push/pop.
> 
> Last I remember, that only made a difference on Athlons, and Intel CPU's 

I didn't benchmark it, but as a data point ICC 7 generates the movls instead 
of pushes now too, (even though it generates bigger code). In fact it is even more 
aggressive on that than gcc: gcc does it only for more than three or four registers, 
icc does it for two and more.  So I expect it being faster on Intel CPUs - at least on 
the P4 - too.  I doubt they tuned it for Athlons.


-Andi
