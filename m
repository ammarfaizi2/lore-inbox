Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264060AbTKDKl0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Nov 2003 05:41:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264061AbTKDKl0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Nov 2003 05:41:26 -0500
Received: from adsl-63-194-133-30.dsl.snfc21.pacbell.net ([63.194.133.30]:25730
	"EHLO penngrove.fdns.net") by vger.kernel.org with ESMTP
	id S264060AbTKDKlY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Nov 2003 05:41:24 -0500
From: John Mock <kd6pag@qsl.net>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: Software Suspend: 2.6.0-test9 vs. 2.4.22 patched with swsusp 2.0rc2
Message-Id: <E1AGycl-0001d3-00@penngrove.fdns.net>
Date: Tue, 04 Nov 2003 02:41:23 -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order to understand what's broken in 2.6.0 vs. what hasn't worked
earlier, i picked up the current stable kernel and patched it with the
current software-suspend release candidate.  Some things which i have
found to be broken in 2.6.0-test9 on a VAIO R505EL seem to work at least
partially with 2.4.22 patched with the current software-suspend release
candidate (patch).

To wit:

   'uchi-hcd' comes back into an almost plausible state with 2.4.22-sws-rc2
	and fails as previously documented under 2.6.0-test9.  However, it
	won't sleep with a mouse or digital camera connected, and without
	that, after sleeping, it freezes when i try to plug in a USB mouse.

   Rather than dying when swap space isn't initialized,  2.4.22-sws-rc2
	just quietly doesn't go to sleep.

   X still has problems under 2.4.22-sws-rc2; however, it does not double-
	fault or auto-reboot as it does under 2.6.0-test9.  It does not
	come back properly when hibernate is done from inside a native X 
	window, but it does if native X (DRI) is running, and hibernate is 
	done from a console screen rather tahn from X (and i don't use a
	special hack to get X to run more 256 colors at 1024x786 on a VAIO
	R505EL).

   2.4.xx software suspend just feels closer to being production code (but
	isn't a mainstream kernel).

So, 2.4.22-sws-rc2 doesn't solve my problems either, but looks much closer
than 2.6.0-test9, alas.

Also the problem with 'serial_cs' releasing a resource twice does not occur
under 2.4.22-sws-rc2, so that also may be a recent development.

'ohci1394/sbp2' worked for me on 2.4.19, but doesn't on 2.4.22-sws-rc2, so
that might not just be a 2.6.0 issue (although it appears to ve at least
partially fixed by the new upstream 'ieee1394' sources under 2.6.0).  It
doesn't get a slab error, it just doesn't seem to do anything.

We need to release 2.6.0, so given that software suspend is listed in the
'config' comments as 'experimental', i think it shouldn't hold things up.

I just wish this could have gotten more attention earlier.  *sigh*

				-- JM

P.S.  With Nigel working on this on a regular basis, no doubt it will now.
