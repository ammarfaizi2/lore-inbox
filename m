Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289484AbSCRQnb>; Mon, 18 Mar 2002 11:43:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288748AbSCRQnY>; Mon, 18 Mar 2002 11:43:24 -0500
Received: from air-2.osdl.org ([65.201.151.6]:34823 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S289762AbSCRQnO>;
	Mon, 18 Mar 2002 11:43:14 -0500
Date: Mon, 18 Mar 2002 08:42:53 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Joachim Breuer <jmbreuer@gmx.net>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.18 freezes on heavy IO; SysRq question
In-Reply-To: <m3it7tg9lx.fsf@venus.fo.et.local>
Message-ID: <Pine.LNX.4.33L2.0203180828540.2434-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Mar 2002, Joachim Breuer wrote:

| Richard Ems <r.ems.mtg@gmx.net> writes:
|
| > Hi all!
| >
| > I'm seeing my system freeze on heavy IO. Only the reset button brings it
| > back to life again (ALT-SysRq-b also worked once). I'm running SuSE's
| > 2.4.18-30 on a Pentium III (Coppermine) with 256 MB RAM (yes, I should
| > try vanilla 2.4.18, I will ...)
| > No SCSI, all IDE. LVM and ext3.
| > I don't get any oopses, no entries in /var/log/messages, nothing. I
| > mounted the ext3 partitions with the debug option but still no messages.
| > What options can I turn on to search for the problem? Any kernel boot
| > options? LVM/ext3 options?
|
| Seconded; happened to me with 2.4.18 from kernel.org + LVM 2.0 beta
| 1.1 + Trond's NFS ('current' for 2.4.18). IO was to a local ext3 fs;
| no LVM on that machine (modules not loaded).
|
| Lock-up was complete for me; no panic message and no IP either so I
| couldn't poke around. Alt+Sysrq seemed dead; but it might have been on
| one of the boxen where Linux does not detect Alt+Sysrq properly.
|
| BTW, what's the status of the Sysrq entry key "decoder"? I've about 4
| different types of keyboards here, as far as I could determine only
| one of them sends Linux-parseable Alt-Sysrq. All do send *something*
| on Alt-Sysrq, though; but I couldn't get them to work with the
| procedure described in the SysRq manual. That was around 2.4.12.

I've seen a couple of cheapo keyboards where some
Alt-SysRq-key combinations don't generate anything from the
keyboard.  (I'm typing on one of them right now.)
For example, Alt-SysRq-5|6 works, but 1,2,3,4,7,8,9 don't.

I've been told that it's just keyboard manufacturers trying
to save 1/2 cent each keyboard e.g.  :(

In any case, I have 2 patches that you might find useful.
One patch uses Alt-SysRq-Y to raise the console loglevel by 1
and Alt-SysRq-V to lower it by 1.
  http://www.osdl.org/archive/rddunlap/patches/sysrq-logupdown.dif

The other patch implements magic sysrq keys via sysctl.
E.g., "echo 9 > /proc/sys/kernel/magickey" sets console loglevel
to 9, and "echo m > /proc/sys/kernel/magickey" calls show_mem().
  http://www.osdl.org/archive/rddunlap/patches/sys-magic.dif

magickey updates go directly to the sysrq keyboard handler,
so all current keycodes are supported.

-- 
~Randy

