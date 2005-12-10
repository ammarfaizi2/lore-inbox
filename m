Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbVLJQYY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbVLJQYY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Dec 2005 11:24:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932387AbVLJQYY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Dec 2005 11:24:24 -0500
Received: from embla.aitel.hist.no ([158.38.50.22]:60652 "HELO
	embla.aitel.hist.no") by vger.kernel.org with SMTP id S932359AbVLJQYY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Dec 2005 11:24:24 -0500
Date: Sat, 10 Dec 2005 17:27:59 +0100
To: Linus Torvalds <torvalds@osdl.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.6.15-rc5: multiuser scheduling trouble
Message-ID: <20051210162759.GA15986@aitel.hist.no>
References: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0512032155290.3099@g5.osdl.org>
User-Agent: Mutt/1.5.11
From: Helge Hafting <helgehaf@aitel.hist.no>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.15-rc5 (and earlier 2.6 kernels) seems to have a slight scheduling 
problem, with some starvation at a load of only 2.

All it takes is two users with separate X desktops.
User one plays flash games using firefox. The ill-designed flash stuff
typically means that his Xorg and firefox divides the cpu 100% between them.

So I expect that I, as user two, should notice some slowness. I should get only
1/2 - 1/3 cpu.  But I get periods of starvation.  Logging in takes a long time,
bringing iup icewm takes 15s instead of 2, each xterm takes a long time to
start.  They are usually instantaneous.  Tha machine is unsuitable
for work in this mode.

Knowing the root password I renices his Xorg and firefox by 10, and then
everything is fine.  His games are still ok, and my xterms are snappy again.

I have tried no preempt, voluntary preempt, and preemptible kernel.  It doesn't
make a difference.  This is an amd64 kernel on an opteron 244 (1800MHz).  Everyhting
is 64-bit except firefox+flash which is 32-bit.

Perhaps the way flash games work, with lots of communication with the xserver,
makes them get "io boost" even though they are cpu hogs. I still think
my xterm (or whatever I am starting up) should get its fair third of the cpu
though, (with firefox and xorg hogging one third each too.)  Even a "600MHz opteron"
ought to do better than this.

The machine isn't trashing, it is hardly touching swap.  (512M memory, and swpd=16 
according to vmstat) The paging-in of a starting executable shouldn't be affected much
by the cpu load?

Helge Hafting
