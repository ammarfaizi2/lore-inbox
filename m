Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTDOHvr (for <rfc822;willy@w.ods.org>); Tue, 15 Apr 2003 03:51:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264390AbTDOHvr (for <rfc822;linux-kernel-outgoing>);
	Tue, 15 Apr 2003 03:51:47 -0400
Received: from siaag2ac.compuserve.com ([149.174.40.133]:12730 "EHLO
	siaag2ac.compuserve.com") by vger.kernel.org with ESMTP
	id S264387AbTDOHvq (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 15 Apr 2003 03:51:46 -0400
Date: Tue, 15 Apr 2003 03:58:44 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Problem and solution: 2.5 broke KDE panel (kpanel)
To: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200304150403_MC3-1-3478-63FB@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


 When I tried KDE 3.0 on kernel 2.5.66 I got an exception message
from kpanel.  Everything else worked OK but there was no panel, so
it wasn't much fun.

 Solution: boot up 2.4 and remove applets from the panel.  The system
monitor seems to be the problem -- it faulted when I tried to add it
back (but the panel kept running.)

 In case anyone is interested, here's the backtrace I got when the
panel died in 2.5:



(no debugging symbols found)...(no debugging symbols found)...
(no debugging symbols found)...(no debugging symbols found)...
(no debugging symbols found)...(no debugging symbols found)...
(no debugging symbols found)...(no debugging symbols found)...
(no debugging symbols found)...[New Thread 1024 (LWP 847)]
0x420b48b9 in wait4 () from /lib/i686/libc.so.6
#0  0x420b48b9 in wait4 () from /lib/i686/libc.so.6
#1  0x4213030c in __DTOR_END__ () from /lib/i686/libc.so.6
#2  0x40eecc33 in waitpid () from /lib/i686/libpthread.so.0
#3  0x406b08d2 in KCrash::defaultCrashHandler ()
   from /usr/lib/libkdecore-gcc2.96.so.4
#4  0x40eeaf05 in pthread_sighandler () from /lib/i686/libpthread.so.0
#5  <signal handler called>
#6  0x409a06a3 in QTimer::stop () from /usr/lib/qt3-gcc2.96/lib/libqt-mt.so.3
#7  0x41394df1 in KTimeMon::stop ()
   from /usr/lib/kde3/ktimemon_panelapplet.so.1
#8  0x41391e82 in KSample::fatal ()
   from /usr/lib/kde3/ktimemon_panelapplet.so.1
#9  0x41392a10 in KSample::readSample ()
   from /usr/lib/kde3/ktimemon_panelapplet.so.1
#10 0x4139157c in KSample::KSample ()
   from /usr/lib/kde3/ktimemon_panelapplet.so.1
#11 0x413948a9 in KTimeMon::KTimeMon ()
   from /usr/lib/kde3/ktimemon_panelapplet.so.1
#12 0x413935f6 in init () from /usr/lib/kde3/ktimemon_panelapplet.so.1
#13 0x4001c82f in PluginLoader::loadApplet ()
   from /usr/lib/libkickermain-gcc2.96.so.1
#14 0x41221a6e in InternalAppletContainer::InternalAppletContainer ()
   from /usr/lib/kicker-gcc2.96.so
#15 0x41229e9b in PluginManager::createAppletContainer ()
   from /usr/lib/kicker-gcc2.96.so
#16 0x41214343 in ContainerArea::loadContainerConfig ()
   from /usr/lib/kicker-gcc2.96.so
#17 0x41210419 in ContainerArea::initialize () from /usr/lib/kicker-gcc2.96.so
#18 0x4120eb25 in Panel::initialize () from /usr/lib/kicker-gcc2.96.so
#19 0x4120deaa in Kicker::Kicker () from /usr/lib/kicker-gcc2.96.so
#20 0x4120cf9a in main () from /usr/lib/kicker-gcc2.96.so
#21 0x0804cee9 in strcpy ()
#22 0x0804dbcc in strcpy ()
#23 0x0804e016 in strcpy ()
#24 0x0804f505 in strcpy ()
#25 0x42017589 in __libc_start_main () from /lib/i686/libc.so.6


--
 Chuck
