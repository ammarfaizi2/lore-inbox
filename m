Return-Path: <linux-kernel-owner+w=401wt.eu-S932075AbXACVsp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932075AbXACVsp (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:48:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751113AbXACVsp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:48:45 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:30515 "EHLO
	agminet01.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbXACVso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:48:44 -0500
Date: Wed, 3 Jan 2007 13:35:21 -0800
From: Randy Dunlap <randy.dunlap@oracle.com>
To: bjdouma@xs4all.nl
Cc: linux-kernel@vger.kernel.org
Subject: Re: qconf: reproducible segfault
Message-Id: <20070103133521.555f97c3.randy.dunlap@oracle.com>
In-Reply-To: <459C1966.7040209@xs4all.nl>
References: <459C1966.7040209@xs4all.nl>
Organization: Oracle Linux Eng.
X-Mailer: Sylpheed 2.3.0 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Jan 2007 22:00:22 +0100 Bauke Jan Douma wrote:

> 
> Not a big deal (I just discovered 'make gconfig'), but I'm experiencing
> a reproducible segfault in 'make xconfig', i.e. qconf.
> 
> I was wondering if anyone else can reproduce this:

Yes.

> 1. QTDIR=/usr/local/lib/qt make xconfig
>     mine by default has all qconf options OFF ('Show Name', 'Show Range',
>     'Show Data', 'Show All Options', 'Show Debug Info')
> 
> 2. from the kernel options, select:
>     Networking / Networking options / Network packet filtering (replaces ipchains)
> 
> 3. from the qconf options, now select 'Show Debug Info'
>     voila -> segfault
> 
> 
> This is with qt-3.3.3:
> 
> ldd /usr/src/linux-2.6.19.1/scripts/kconfig/qconf
> 	linux-gate.so.1 =>  (0xffffe000)
> 	libqt-mt.so.3 => /usr/local/lib/qt/lib/libqt-mt.so.3 (0xb76c2000)
> 	libdl.so.2 => /lib/libdl.so.2 (0xb76ad000)
> 	libstdc++.so.6 => /usr/lib/libstdc++.so.6 (0xb75c9000)
> 	libm.so.6 => /lib/libm.so.6 (0xb75a4000)
> 	libgcc_s.so.1 => /usr/lib/libgcc_s.so.1 (0xb7598000)
> 	libc.so.6 => /lib/libc.so.6 (0xb746f000)
> 	libpng.so.3 => /usr/local/lib/libpng.so.3 (0xb7449000)
> 	libz.so.1 => /lib/libz.so.1 (0xb7435000)
> 	libGL.so.1 => /usr/lib/libGL.so.1 (0xb73a9000)
> 	libXmu.so.6 => /usr/X11R6/lib/libXmu.so.6 (0xb7393000)
> 	libXrender.so.1 => /usr/X11R6/lib/libXrender.so.1 (0xb738b000)
> 	libXrandr.so.2 => /usr/X11R6/lib/libXrandr.so.2 (0xb7387000)
> 	libXcursor.so.1 => /usr/X11R6/lib/libXcursor.so.1 (0xb737e000)
> 	libXinerama.so.1 => /usr/X11R6/lib/libXinerama.so.1 (0xb737b000)
> 	libXft.so.2 => /usr/X11R6/lib/libXft.so.2 (0xb7369000)
> 	libfreetype.so.6 => /usr/local/lib/libfreetype.so.6 (0xb72e4000)
> 	libfontconfig.so.1 => /usr/local/lib/libfontconfig.so.1 (0xb72a6000)
> 	libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0xb7298000)
> 	libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0xb71cb000)
> 	libSM.so.6 => /usr/X11R6/lib/libSM.so.6 (0xb71c2000)
> 	libICE.so.6 => /usr/X11R6/lib/libICE.so.6 (0xb71aa000)
> 	libpthread.so.0 => /lib/libpthread.so.0 (0xb7192000)
> 	/lib/ld-linux.so.2 (0xb7f1b000)
> 	libGLcore.so.1 => /usr/lib/libGLcore.so.1 (0xb690c000)
> 	libnvidia-tls.so.1 => /usr/lib/tls/libnvidia-tls.so.1 (0xb690a000)
> 	libXt.so.6 => /usr/X11R6/lib/libXt.so.6 (0xb68b8000)
> 	libexpat.so.0 => /usr/local/lib/libexpat.so.0 (0xb688c000)
> 	libiconv.so.2 => /lib/libiconv.so.2 (0xb67b1000)
> 
> First I thought qconf window geometry and maybe font would make a
> telling difference here, but I can resize the window all I want and
> change fonts any which way I can, but the segfault persists.
> 
> FWIW, my initial geometry is 957x843, font is usually LuciduxSans 7.
> 
> Strace output didn't provide much of an apparent clue, just the
> SIGSEGV.
> 
> Oh, kernel is 2.6.19.1 -- not important I'd say.

Here's thd gdb backtrace:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 47045179778192 (LWP 8553)]
0x0000000000422031 in ConfigInfoView::symbolInfo ()
(gdb) bt
#0  0x0000000000422031 in ConfigInfoView::symbolInfo ()
#1  0x00000000004223bf in ConfigInfoView::setShowDebug ()
#2  0x000000000042257c in ConfigInfoView::qt_invoke ()
#3  0x00002ac98d24f79c in QObject::activate_signal ()
   from /usr/lib64/libqt-mt.so.3
#4  0x00002ac98d24ff40 in QObject::activate_signal_bool ()
   from /usr/lib64/libqt-mt.so.3
#5  0x00002ac98d36e7a5 in QAction::internalActivation ()
   from /usr/lib64/libqt-mt.so.3
#6  0x00002ac98d54c9b3 in QAction::qt_invoke () from /usr/lib64/libqt-mt.so.3
#7  0x00002ac98d24f79c in QObject::activate_signal ()
   from /usr/lib64/libqt-mt.so.3
#8  0x00002ac98d531628 in QSignal::signal () from /usr/lib64/libqt-mt.so.3
#9  0x00002ac98d2682a5 in QSignal::activate () from /usr/lib64/libqt-mt.so.3
#10 0x00002ac98d33c6e5 in QPopupMenu::mouseReleaseEvent ()
   from /usr/lib64/libqt-mt.so.3
#11 0x00002ac98d282657 in QWidget::event () from /usr/lib64/libqt-mt.so.3
#12 0x00002ac98d1f8975 in QApplication::internalNotify ()
   from /usr/lib64/libqt-mt.so.3
#13 0x00002ac98d1f978b in QApplication::notify () from /usr/lib64/libqt-mt.so.3
#14 0x00002ac98d1a197d in QETWidget::translateMouseEvent ()
   from /usr/lib64/libqt-mt.so.3
#15 0x00002ac98d1a02a3 in QApplication::x11ProcessEvent ()
   from /usr/lib64/libqt-mt.so.3
#16 0x00002ac98d1af22f in QEventLoop::processEvents ()
   from /usr/lib64/libqt-mt.so.3
#17 0x00002ac98d20d691 in QEventLoop::enterLoop () from /usr/lib64/libqt-mt.so.3
#18 0x00002ac98d20d53a in QEventLoop::exec () from /usr/lib64/libqt-mt.so.3
#19 0x0000000000426053 in main ()


---
~Randy
