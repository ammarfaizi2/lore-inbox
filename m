Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288499AbSADFfJ>; Fri, 4 Jan 2002 00:35:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288501AbSADFet>; Fri, 4 Jan 2002 00:34:49 -0500
Received: from webcon.net ([216.187.106.140]:3224 "EHLO webcon.net")
	by vger.kernel.org with ESMTP id <S288499AbSADFen>;
	Fri, 4 Jan 2002 00:34:43 -0500
Date: Fri, 4 Jan 2002 00:34:30 -0500 (EST)
From: Ian Morgan <imorgan@webcon.net>
To: Ingo Molnar <mingo@elte.hu>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.33.0201040050440.1363-100000@localhost.localdomain>
Message-ID: <Pine.LNX.4.40.0201040010370.1827-100000@light.webcon.net>
Organization: "Webcon, Inc."
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Jan 2002, Ingo Molnar wrote:

> for 2.4.17:
>
> 	http://redhat.com/~mingo/O(1)-scheduler/sched-O1-2.4.17-A0.patch

> i did a fair number of UP and 2.4.17 tests as well.

> Comments, bug reports, suggestions are welcome,

Well, tried it out here on 2.4.17 (w/ ide.2.4.16 & freeswan_1.91) (and after
patching md.c and loop.c), and boy did it blow chunks! ;-)

First, loading the software watchdog module caused the thing to lock up
solid during boot. No SysRq response, and nmi_watchdog did nada too.

Next, after disabling the s/w watchdog, I could boot up.. great, I though it
was all happy. I tried starting up 1 instance of setiathome, and saw how
nicely it (mostly) remained affine to 1 processor, occasionally switching to
the 2nd, and back again, maybe every 5-10 seconds.

Next, though, I couldn't figure out why Mozilla wouldn't load. Then I
noticed I could not open any more xterms. When I went to one open xterm to
do some digging, I noticed very long pauses, where no keyboard input would
be accepted, yet the mouse and the window manager remained responsive. Other
tasks, like my scrolling network usage graph applet would stall as well.
Eventually (after another minute or so), the box locked up solid.

Well, I really liked the sound of this patch. Seemed very well though out.
Too bad it doesn't like me! :-(

You seem to indicate you've done (some) testing on 2.4.17, so I'm somewhat
surprised that it died on me so quickly here. What more info can I give you
that might help track the problem?

Box: 2x Celeron / ABIT BP6 / 384MB
Gnu C                  2.95.3
Gnu make               3.78.1
binutils               2.10.1.0.2
util-linux             2.10s
mount                  2.10s
modutils               2.4.0
e2fsprogs              1.19
reiserfsprogs          3.x.0j
pcmcia-cs              3.1.31
PPP                    2.4.0
Linux C Library        2.1.3
Dynamic linker (ldd)   2.1.3
Linux C++ Library      2.10.0
Procps                 2.0.6
Net-tools              1.54
Console-tools          0.3.3
Sh-utils               2.0
Modules Loaded         sb sb_lib uart401 sound soundcore printer hid input
usb-uhci usbcore tulip ipt_mac ipt_state iptable_mangle ipt_LOG ipt_REJECT
ip_nat_ftp ip_conntrack_ftp iptable_nat ip_conntrack iptable_filter
ip_tables



Regards,
Ian Morgan
-- 
-------------------------------------------------------------------
 Ian E. Morgan        Vice President & C.O.O.         Webcon, Inc.
 imorgan@webcon.net         PGP: #2DA40D07          www.webcon.net
-------------------------------------------------------------------

