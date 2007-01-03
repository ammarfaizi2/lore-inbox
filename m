Return-Path: <linux-kernel-owner+w=401wt.eu-S932138AbXACVRF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932138AbXACVRF (ORCPT <rfc822;w@1wt.eu>);
	Wed, 3 Jan 2007 16:17:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932139AbXACVRE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Jan 2007 16:17:04 -0500
Received: from smtp-vbr2.xs4all.nl ([194.109.24.22]:3258 "EHLO
	smtp-vbr2.xs4all.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932138AbXACVRD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Jan 2007 16:17:03 -0500
X-Greylist: delayed 996 seconds by postgrey-1.27 at vger.kernel.org; Wed, 03 Jan 2007 16:17:03 EST
Message-ID: <459C1966.7040209@xs4all.nl>
Date: Wed, 03 Jan 2007 22:00:22 +0100
From: Bauke Jan Douma <bjdouma@xs4all.nl>
Reply-To: bjdouma@xs4all.nl
Organization: a training zoo
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: qconf: reproducible segfault
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Not a big deal (I just discovered 'make gconfig'), but I'm experiencing
a reproducible segfault in 'make xconfig', i.e. qconf.

I was wondering if anyone else can reproduce this:

1. QTDIR=/usr/local/lib/qt make xconfig
    mine by default has all qconf options OFF ('Show Name', 'Show Range',
    'Show Data', 'Show All Options', 'Show Debug Info')

2. from the kernel options, select:
    Networking / Networking options / Network packet filtering (replaces ipchains)

3. from the qconf options, now select 'Show Debug Info'
    voila -> segfault


This is with qt-3.3.3:

ldd /usr/src/linux-2.6.19.1/scripts/kconfig/qconf
	linux-gate.so.1 =>  (0xffffe000)
	libqt-mt.so.3 => /usr/local/lib/qt/lib/libqt-mt.so.3 (0xb76c2000)
	libdl.so.2 => /lib/libdl.so.2 (0xb76ad000)
	libstdc++.so.6 => /usr/lib/libstdc++.so.6 (0xb75c9000)
	libm.so.6 => /lib/libm.so.6 (0xb75a4000)
	libgcc_s.so.1 => /usr/lib/libgcc_s.so.1 (0xb7598000)
	libc.so.6 => /lib/libc.so.6 (0xb746f000)
	libpng.so.3 => /usr/local/lib/libpng.so.3 (0xb7449000)
	libz.so.1 => /lib/libz.so.1 (0xb7435000)
	libGL.so.1 => /usr/lib/libGL.so.1 (0xb73a9000)
	libXmu.so.6 => /usr/X11R6/lib/libXmu.so.6 (0xb7393000)
	libXrender.so.1 => /usr/X11R6/lib/libXrender.so.1 (0xb738b000)
	libXrandr.so.2 => /usr/X11R6/lib/libXrandr.so.2 (0xb7387000)
	libXcursor.so.1 => /usr/X11R6/lib/libXcursor.so.1 (0xb737e000)
	libXinerama.so.1 => /usr/X11R6/lib/libXinerama.so.1 (0xb737b000)
	libXft.so.2 => /usr/X11R6/lib/libXft.so.2 (0xb7369000)
	libfreetype.so.6 => /usr/local/lib/libfreetype.so.6 (0xb72e4000)
	libfontconfig.so.1 => /usr/local/lib/libfontconfig.so.1 (0xb72a6000)
	libXext.so.6 => /usr/X11R6/lib/libXext.so.6 (0xb7298000)
	libX11.so.6 => /usr/X11R6/lib/libX11.so.6 (0xb71cb000)
	libSM.so.6 => /usr/X11R6/lib/libSM.so.6 (0xb71c2000)
	libICE.so.6 => /usr/X11R6/lib/libICE.so.6 (0xb71aa000)
	libpthread.so.0 => /lib/libpthread.so.0 (0xb7192000)
	/lib/ld-linux.so.2 (0xb7f1b000)
	libGLcore.so.1 => /usr/lib/libGLcore.so.1 (0xb690c000)
	libnvidia-tls.so.1 => /usr/lib/tls/libnvidia-tls.so.1 (0xb690a000)
	libXt.so.6 => /usr/X11R6/lib/libXt.so.6 (0xb68b8000)
	libexpat.so.0 => /usr/local/lib/libexpat.so.0 (0xb688c000)
	libiconv.so.2 => /lib/libiconv.so.2 (0xb67b1000)

First I thought qconf window geometry and maybe font would make a
telling difference here, but I can resize the window all I want and
change fonts any which way I can, but the segfault persists.

FWIW, my initial geometry is 957x843, font is usually LuciduxSans 7.

Strace output didn't provide much of an apparent clue, just the
SIGSEGV.

Oh, kernel is 2.6.19.1 -- not important I'd say.

Thanks for your time.

bjd
