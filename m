Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263496AbTFPIAA (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 04:00:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263528AbTFPIAA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 04:00:00 -0400
Received: from dmz.unibanka.lv ([193.178.150.181]:17926 "EHLO dmz.unibanka.lv")
	by vger.kernel.org with ESMTP id S263496AbTFPH76 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 03:59:58 -0400
Subject: Re: Real multi-user linux
To: linux-kernel@vger.kernel.org
Cc: terje_fb@yahoo.no
X-Mailer: Lotus Notes Release 5.0.8  June 18, 2001
Message-ID: <OF0DCD72F3.3CC39515-ONC2256D47.0028668E@unibanka.lv>
From: Aivils.Stoss@unibanka.lv
Date: Mon, 16 Jun 2003 09:12:53 +0100
X-MIMETrack: Serialize by Router on lotus/UNIBANKA/LV(Release 5.0.5 |September 22, 2000) at  2003.06.16 11:12:53
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
X-Lookup-Warning: HELO lookup on lightning1 does not match 193.178.150.178
X-Return-Path: Aivils.Stoss@unibanka.lv
X-MDaemon-Deliver-To: linux-kernel@vger.kernel.org
Reply-To: Aivils.Stoss@unibanka.lv
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Terje
>is it possible to use several logical terminals
>(=tupels of monitor, keyboard and mouse) directly
>connected to _one_ system? I mean there is no problem
>to connect two keyboards, two mice and two graphic
>cards/monitors...
>
>But is there a possibility to group these to allow two
>users work simultanously on the same machine without
>having to go via serial console or network?

Yes.
You can read documentation un download paches from
http://startx.times.lv
or
http://www.schuldei.org/aivils

I have got working real multiple local X servers.
Main idea is from James Simmons.
/dev/tty1-63 is splited. Now we have a multiple
ranges of /dev/tty's
/dev/tty1-7 bounded with 1-st keyboard
/dev/tty8-16 bounded with 2-nd keyboard
and so on.
Also XFree86 server has a parameter vtXX , where
XX is a number of /dev/ttyXX. Now we can choose
right keyboard for right X sever.

Normal X server during initialization search all
video adapters and then disable these all and after
init enable one necessary video adapter. This feature
must be disabled. If You tell xf86 to use /proc
interface for PCI configuration, then is possible
filter xf86 PCI-steering commands with kernel.

In my case patching of XFree86 is not necessary.
Kernel do not allow disable innocent video adapters
and multiple XFree86 servers runs without interference.

Another trouble is with bunch of USB input devices.
After boot USB assing device files randomly - same
mouse may have a various /dev/input/mouseX device file,
because init 1-st 2-nd 3-rd . I use
/etc/hotplug/input.agent
This agent make symbolic links depends from mouse physicaly
location. So i do not use straight /dev/input/mouse0 but
input.agent created /dev/Amouse0 - symlink to right
mouse device file.

Another troble is with sound. Any programm under Linux
will use hers own sound interface. If You have multiple
sound cards, then any starting script must be patched.
Some programms are unconfigurable or i do not know how
to doe it (SUN java plugin for Netscape). My home users
well know this and configure popular apps (xmms) as they
like and create additional chaos.

Zero trobles with GLX hardware acceleration! This is true
for closed source Nvidia drivers :)

IMHO this solution is very usable for home computers with
restricted budget. I never do cost calculations, because i
will not 2-nd box in my home.

Aivils Stoss

