Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318244AbSHDTii>; Sun, 4 Aug 2002 15:38:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318245AbSHDTii>; Sun, 4 Aug 2002 15:38:38 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1042 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318244AbSHDTii>; Sun, 4 Aug 2002 15:38:38 -0400
Date: Sun, 4 Aug 2002 12:28:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Hubertus Franke <frankeh@watson.ibm.com>,
       "David S. Miller" <davem@redhat.com>, <davidm@hpl.hp.com>,
       <davidm@napali.hpl.hp.com>, <gh@us.ibm.com>, <Martin.Bligh@us.ibm.com>,
       <wli@holomorpy.com>, <linux-kernel@vger.kernel.org>
Subject: Re: large page patch (fwd) (fwd)
In-Reply-To: <3D4D7F24.10AC4BDB@zip.com.au>
Message-ID: <Pine.LNX.4.44.0208041225180.10314-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 4 Aug 2002, Andrew Morton wrote:
> 
> Could we establish the eight pte's but still arrange for pages 1-7
> to trap, so the kernel can zero the out at the latest possible time?

You could do that by marking the pages as being there, but PROT_NONE.

On the other hand, cutting down the number of initial pagefaults (by _not_ 
doing what you suggest) migth be a bigger speedup for process startup than 
the slowdown from occasionally doing unnecessary work.

I suspect that there is some non-zero order-X (probably 2 or 3), where you 
just win more than you lose. Even for small programs. 

			Linus

