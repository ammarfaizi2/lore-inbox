Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263784AbUHJJqm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263784AbUHJJqm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 05:46:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263778AbUHJJqm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 05:46:42 -0400
Received: from mailhost.cs.auc.dk ([130.225.194.6]:19898 "EHLO
	mailhost.cs.auc.dk") by vger.kernel.org with ESMTP id S263784AbUHJJnv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 05:43:51 -0400
Subject: [bug] Strange bug on Crusoe architecture and X
From: Emmanuel Fleury <fleury@cs.auc.dk>
To: Linux Kernel Mailing-list <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-b13iRP5x3640oKlWmDbc"
Organization: Aalborg University -- Computer Science Dept.
Message-Id: <1092131012.2268.48.camel@rade7.e.cs.auc.dk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 10 Aug 2004 11:43:32 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--=-b13iRP5x3640oKlWmDbc
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi all,

I have a laptop Vaio C1MZX with a Transmeta Crusoe TM5800.
The graphic card is a ATI Radeon Mobility M6 LY.

lspci:

0000:00:00.0 Host bridge: Transmeta Corporation LongRun Northbridge 
(rev 03)
0000:00:00.1 RAM memory: Transmeta Corporation SDRAM controller
0000:00:00.2 RAM memory: Transmeta Corporation BIOS scratchpad
0000:00:06.0 Multimedia audio controller: ALi Corporation M5451 PCI
AC-Link Controller Audio Device (rev 02)
0000:00:07.0 ISA bridge: ALi Corporation M1533 PCI to ISA Bridge
[Aladdin IV]
0000:00:08.0 Modem: ALi Corporation M5457 AC'97 Modem Controller
0000:00:09.0 FireWire (IEEE 1394): Texas Instruments TSB43AB22/A
IEEE-1394a-2000 Controller (PHY/Link)
0000:00:0a.0 Multimedia controller: Fujitsu Limited.: Unknown device
2011
0000:00:0b.0 Ethernet controller: Realtek Semiconductor Co., Ltd.
RTL-8139/8139C/8139C+ (rev 10)
0000:00:0c.0 VGA compatible controller: ATI Technologies Inc Radeon
Mobility M6
LY
0000:00:0f.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)
0000:00:10.0 IDE interface: ALi Corporation M5229 IDE (rev c4)
0000:00:11.0 Non-VGA unclassified device: ALi Corporation M7101 Power
Management Controller [PMU]
0000:00:12.0 CardBus bridge: Ricoh Co Ltd RL5c475 (rev 80)
0000:00:14.0 USB Controller: ALi Corporation USB 1.1 Controller (rev 03)


>From time to time the Xserver stop to work properly and refuse new
connections from any Xclients. The Xserver itself is still standing but
any Xclient trying to connect get a message from the Xserver that makes
it crash (see the gdb log attached to this mail: xlogo_bug.log). It
seems to be the 9th reply from the Xserver that makes the Xclients crash
(the normal negotiation between the Xserver and the Xclient is traced in
xlogo_nobug.log).

I also noticed that stopping the Xserver and starting it again was not
helping to remove the bug. The Xserver will still behave the same (i.e.
since the bug start it stays consistent for a while).

More surprisingly, if you do a copy of the binary file of the "buggy"
Xserver and run it, then it will work without bug, but when running the
original binary file that started with the bug, the bug will appear
again.

All Xservers (whatever version number, with optimization or not, with
debug or not, or all the combinations) will crash at some point and
behave as mentioned previously.

I tried to go inside the Xserver by attaching gdb to the Xserver process
but the Xserver start to use a lot of cpu time and nothing happen. When
interrupted inside gdb by a Ctrl-C, gdb give a prompt again but a "bt"
gives some nonsense informations (when the bug is not present attaching
gdb to the process works normally).

I and other people have been reporting this problem in the GNU/Linux
Debian X-strike force mailing-list (see bug #216933:
http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=216933).



Some (stupid?) Hypothesis...

Well, I don't know if it is right but it seems that there is a "cache"
which contains a wrong image of the Xserver which is not flushed.

If we accept this hypothesis, I don't know why the bug is still the same
(usually these cache problems are random).

Another problem is that I don't know what to try next and how to get
deeper or how to have a better understanding on what is going on.

Can somebody confirm the behavior that I described or give me some hints
on what to do next ?????

Thanks a lot.


PS: Some useful links to better understand the specificities of the
Crusoe processors:
http://www.realworldtech.com/page.cfm?ArticleID=RWT010204000000
http://www.realworldtech.com/page.cfm?ArticleID=RWT012704012616



Regards
-- 
Emmanuel Fleury

Computer Science Department, |  Office: B1-201
Aalborg University,          |  Phone:  +45 96 35 72 23
Fredriks Bajersvej 7E,       |  Fax:    +45 98 15 98 89
9220 Aalborg East, Denmark   |  Email:  fleury@cs.auc.dk

--=-b13iRP5x3640oKlWmDbc
Content-Disposition: attachment; filename=xlogo_bug.log
Content-Type: text/x-log; name=xlogo_bug.log; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

GNU gdb 6.1-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...Using host libthread_db library "/lib/tls/libthread_db.so.1".

(gdb) b XlibInt.c:_XReply
Make breakpoint pending on future shared library load? (y or [n]) 
Breakpoint 1 (XlibInt.c:_XReply) pending.
(gdb) r
Starting program: /home/fleury/devel/crusoe_bug/src/xfree86-4.3.0-dfsg/xc/programs/xlogo/xlogo 
Breakpoint 2 at 0x4026f3bc: file XlibInt.c, line 1642.
Pending breakpoint "XlibInt.c:_XReply" resolved

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff590, extra=0, discard=0)
    at XlibInt.c:1642
	in XlibInt.c
(gdb) c
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff5b0, extra=0, discard=0)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff420, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff600, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff600, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbfffe4d0, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbfffe4e0, extra=0, discard=0)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff3d0, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

X Error of failed request:  BadLength (poly request too large or internal Xlib length error)
  Major opcode of failed request:  18 (X_ChangeProperty)
  Serial number of failed request:  15
  Current serial number in output stream:  18

Program exited with code 01.
(gdb) quit

--=-b13iRP5x3640oKlWmDbc
Content-Disposition: attachment; filename=xlogo_nobug.log
Content-Type: text/x-log; name=xlogo_nobug.log; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

GNU gdb 6.1-debian
Copyright 2004 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain conditions.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "i386-linux"...Using host libthread_db library "/lib/tls/libthread_db.so.1".

(gdb) b XlibInt.c:_XReply
Make breakpoint pending on future shared library load? (y or [n]) 
Breakpoint 1 (XlibInt.c:_XReply) pending.
(gdb) r
Starting program: /home/fleury/devel/crusoe_bug/src/xfree86-4.3.0-dfsg/xc/programs/xlogo/xlogo 
Breakpoint 2 at 0x4026f3bc: file XlibInt.c, line 1642.
Pending breakpoint "XlibInt.c:_XReply" resolved

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff590, extra=0, discard=0)
    at XlibInt.c:1642
	in XlibInt.c
(gdb) c
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff5b0, extra=0, discard=0)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff420, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff600, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff600, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbfffe4d0, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbfffe4e0, extra=0, discard=0)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff3d0, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff530, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff730, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Breakpoint 2, _XReply (dpy=0x8050488, rep=0xbffff6f0, extra=0, discard=1)
    at XlibInt.c:1642
1642	in XlibInt.c
(gdb) 
Continuing.

Program received signal SIGINT, Interrupt.
0x403e7398 in select () from /lib/tls/libc.so.6
(gdb) quit
The program is running.  Exit anyway? (y or n) 
--=-b13iRP5x3640oKlWmDbc--

