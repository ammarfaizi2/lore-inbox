Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264391AbTLLKEB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Dec 2003 05:04:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264524AbTLLKEA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Dec 2003 05:04:00 -0500
Received: from pop.gmx.de ([213.165.64.20]:43660 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264391AbTLLKD6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Dec 2003 05:03:58 -0500
Date: Fri, 12 Dec 2003 11:03:57 +0100 (MET)
From: "Svetoslav Slavtchev" <svetljo@gmx.de>
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Subject: Multiple keyboard/monitor vs linux-2.6?
X-Priority: 3 (Normal)
X-Authenticated: #20183004
Message-ID: <1622.1071223437@www41.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

zb == Zoltán Böszörményi
< zb >
is there a way to assign different keyboards to different vcs?
I would like to set up a machine that has 2 keyboards, 2 mice and
2 videocards and run XFree-4.x on both heads. The videocard/monitor and
mouse settings are easy to set up but I cannot find a device setting
for the keyboard in man XF86Config. How can I do it with mainline kernels?
</ zb >

you can not do it with mainline kernel

you need both patched kernel and XFree, although the 
second might be skiped in case a similar functionality
added by the kernel patch is used 

< zb >
After some googleing I found something called "backstreet ruby"
http://startx.times.lv/eng-faq.html
</ zb >

check the entire documentation there
and visit the links section -> you'll get the big picture

for 2.6 most info is still on the linuxconsole ml archive

< zb >
This gave me this info (howto in a nutshell):

1. Boot with kernel option "dumbcon=N" to activate N dummy console.
</ zb >

mostly undocumented, but dumbcon= ... is not obligatory for 2.6,
you can also use multiple independent framebuffer consoles instead,
which is still work in progress

< zb >
2. cat /proc/bus/input/devices gives the input devices, search for keyboard
    entries.
3. To assign a keyboard to a VT, feed the keyboard Phys= entry into
    a VT, e.g. echo "isa0060/serio0/input0" > /proc/bus/console/00/keyboard
4. Start the X server on the proper VT.
</ zb >
 
you can configure hotplug to do this for you
and let a display manager start X for you,
but i'm not sure how well will this work with
multiple framebuffer consoles

< zb >
The functionality can be found at linuxconsole.sourceforge.net.
Will this be included into mainline near term? Say 2.6.[12]?
The ruby-2.6 is against 2.6.0-test9 so it's almost uptodate.
</ zb >

the ruby tree works with current 2.6 too
multiple framebuffer console is not yet polished
and the framebuffer drivers in vanilla 2.6 aren't
in very good shape too

i really doubt it will be included in the near term,
i think it  will be first merged in 2.7 
(hopefully right after it opens) and then it will 
be "backported" to 2.6, may be arround 2.6.1[0-9]

best,

svetljo

-- 
+++ GMX - die erste Adresse für Mail, Message, More +++
Neu: Preissenkung für MMS und FreeMMS! http://www.gmx.net


