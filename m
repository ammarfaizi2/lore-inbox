Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132577AbRDOFKp>; Sun, 15 Apr 2001 01:10:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132576AbRDOFKf>; Sun, 15 Apr 2001 01:10:35 -0400
Received: from dystopia.lab43.org ([209.217.122.210]:46292 "EHLO
	dystopia.lab43.org") by vger.kernel.org with ESMTP
	id <S132577AbRDOFKU>; Sun, 15 Apr 2001 01:10:20 -0400
Date: Sun, 15 Apr 2001 01:08:13 -0400 (EDT)
From: Rod Stewart <stewart@dystopia.lab43.org>
To: Manfred Spraul <manfred@colorfullife.com>
cc: <linux-kernel@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Re: 8139too: defunct threads
In-Reply-To: <001b01c0c52c$03070b00$5517fea9@local>
Message-ID: <Pine.LNX.4.33.0104150100210.13758-100000@dystopia.lab43.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 14 Apr 2001, Manfred Spraul wrote:
> From: "Alan Cox" <alan@lxorguk.ukuu.org.uk>
> >
> > That has an implicit race, a zombie can always appear as we are
> execing init.
> > I think init wants fixing
> >
> Rod, could you boot again with the unpatched kernel and send a sigchild
> to init?
>
> #kill -CHLD 1
>
> If I understand the init code correctly the sigchild handler reaps all
> zombies, but probably the signal got lost because the children died
> before the parent was created ;-)

That doesn't 'fix' it.  The thing I find funny is that it only appears
when IP_PNP is compiled in.  It is as if the driver ends up in some weird
state when IP_PNP is used.  According to ps, from my limited
understanding, the thread is stuck in do_exit

[root@stewart-nw34 /root]# ps elaxww|grep eth
  F   UID   PID  PPID PRI  NI   VSZ  RSS WCHAN  STAT TTY  TIME COMMAND
044     0     7     1   9   0     0    0 do_exi Z    ?  0:00 [eth0 <defunct>]
044     0     8     1   9   0     0    0 do_exi Z    ?  0:00 [eth1 <defunct>]
044     0     9     1   9   0     0    0 do_exi Z    ?  0:00 [eth2 <defunct>]
040     0   229     1   9   0     0    0 rtl813 SW   ?  0:00 [eth1]

Thanks for helping with this,
-Rms

