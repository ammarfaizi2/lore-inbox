Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263692AbUEWWtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263692AbUEWWtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 May 2004 18:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263697AbUEWWtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 May 2004 18:49:16 -0400
Received: from web40607.mail.yahoo.com ([66.218.78.144]:22621 "HELO
	web40607.mail.yahoo.com") by vger.kernel.org with SMTP
	id S263692AbUEWWtJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 May 2004 18:49:09 -0400
Message-ID: <20040523224908.25194.qmail@web40607.mail.yahoo.com>
Date: Mon, 24 May 2004 00:49:08 +0200 (CEST)
From: =?iso-8859-1?q?szonyi=20calin?= <caszonyi@yahoo.com>
Subject: Re: tvtime and the Linux 2.6 scheduler
To: Billy Biggs <vektor@dumbterm.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20040523154859.GC22399@dumbterm.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 --- Billy Biggs <vektor@dumbterm.net> a écrit : >   I am the
author of tvtime, a TV application with advanced
> image
> processing algorithms.  Some users are complaining about poor
> performance under Linux 2.6, and I would like more information
> about how
> tvtime will be treated by the scheduler.  Here is an example
> of the
> intended usage:
> 
>   - Program running as root and SCHED_FIFO
>   - NTSC, input ~30 fps, each field processed for an output of
> ~60 fps
>   - CPU intensive processing, say 9 ms per field on my P3-733
>   - with a typical AGP card, the X driver takes 4 ms to draw
>   - Wait using /dev/rtc set to 1024 Hz
> 
>   for(;;)
>       9 ms : process frame
>       4 ms : draw frame
>       3 ms : wait until next field time using /dev/rtc
>       9 ms : process frame
>       4 ms : draw frame
>       3 ms : block on /dev/video0 for next frame
>      -----
>      33 ms : time per NTSC frame
> 
>   The theory is that Linux classifies this as a CPU hog
> regardless of
> its priority, and preempts tvtime with other processes. 
> Oswald
> Buddenhagen describes the effect as this:
> 
>   "[...] it starts up fine, but after a few seconds (when the
> scheduler
> gathered some stats) ... well, it looks funny: the scene goes
> roughly
> exponentially into slow motion, then there is a frame drop and
> the
> process starts over.  this behaviour can be observed at any
> priority,
> which is clearly against the claim "no normally priorized
> interactive
> process will preempt a highly priorized cpu-hog" that i've
> read
> somewhere.  the xserver priority does not change anything,
> either;"
> 
>   Avoiding root/SCHED_FIFO and using usleep() instead of
> /dev/rtc seems
> to exhibit the same behavior.
> 
>   Thoughts?
> 

For me it works ok
Running tvtime with 2.6.6-mm5 load average 26 (twenty six) it
works 
almost perfect (no frame skipped -- at least not reported by
tvtime)
at full rate (50 frames/sec). Computer: AMD Duron 700 MHz, 256MB
Ram,
VIA KT133 chipset, AGP 4x, Ati Radeon 7200 

Maybe your users are renicing tvtime ?
AFAIK it is not recommended to renice a process which uses X
server and 
wants realtime processing 

Ohhhhhhhhhh
Take a look at this. Is tvtime's fault (X server does'n have the
chance to display what tvtime processed because tvtime gets
almost all the cpu)

sony@grinch -01:40:31- 0 jobs, ver 2.05b.0 3 
 /~ $ tvtime -s -v
Running tvtime 0.9.12.
Reading configuration from /usr/local/etc/tvtime/tvtime.xml
Reading configuration from /home/sony/.tvtime/tvtime.xml
cpuinfo: CPU AMD Duron(tm) Processor, family 6, model 3,
stepping 1.
cpuinfo: CPU measured at 700,579MHz.
tvtime: Cannot set priority to -19: Permission denied.
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

xcommon: Display :0.0, vendor The XFree86 Project, Inc, XFree86
4.4.0
xfullscreen: Single-head detected, pixel aspect will be
calculated.
xfullscreen: Pixel aspect ratio on the primary head is: 75/76 ==
0,99.
xfullscreen: Using the XFree86-VidModeExtension to calculate
fullscreen size.
xfullscreen: Fullscreen to 0,0 with size 1024x768.
xcommon: Have XTest, will use it to ping the screensaver.
xcommon: Pixel aspect ratio 75:76.
xcommon: No window properties found for EWMH.
xcommon: Window manager is not EWMH compliant.
xcommon: Pixel aspect ratio 75:76.
xcommon: Displaying in a 778x576 window inside 778x576 space.
xvoutput: Using XVIDEO adaptor 69: ATI Radeon Video Overlay.
speedycode: Using MMXEXT optimized functions.
station: Reading stationlist from
/home/sony/.tvtime/stationlist.xml
videoinput: Using video4linux2 driver 'bttv', card 'BT878 video
(AVerMedia TVCaptur' (bus PCI:0000:00:09.0).
videoinput: Version is 2318, capabilities 5010015.
tvtime: Sampling input at 720 pixels per scanline.
xcommon: Pixel aspect ratio 75:76.
xcommon: Displaying in a 778x576 window inside 778x576 space.
xcommon: Received a map, marking window as visible (50)

I hope the line above answers your question

>   -Billy
> 
Calin

P.S. Load average is that high because i run freenet
 http://freenet.sourceforge.net -- lots of java processes

=====
--
A mouse is a device used to point at 
the xterm you want to type in.
Kim Alm on a.s.r.


	

	
		
Yahoo! Mail : votre e-mail personnel et gratuit qui vous suit partout ! 
Créez votre Yahoo! Mail sur http://fr.benefits.yahoo.com/

Dialoguez en direct avec vos amis grâce à Yahoo! Messenger !Téléchargez Yahoo! Messenger sur http://fr.messenger.yahoo.com
