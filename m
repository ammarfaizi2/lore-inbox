Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261979AbUDTA0h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261979AbUDTA0h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Apr 2004 20:26:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261981AbUDTA0h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Apr 2004 20:26:37 -0400
Received: from ra.sai.msu.su ([158.250.29.2]:4481 "EHLO ra.sai.msu.su")
	by vger.kernel.org with ESMTP id S261979AbUDTA02 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Apr 2004 20:26:28 -0400
Date: Tue, 20 Apr 2004 04:26:20 +0400 (MSD)
From: "E.Rodichev" <er@sai.msu.su>
To: linux-kernel@vger.kernel.org
Subject: /dev/psaux problem (2.6.5)
Message-ID: <Pine.GSO.4.58.0404200404360.22353@ra.sai.msu.su>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

as it was described already, the new 2.6.0 approach for handling some
input devices (mice!) lead to many troubles. As for me, the tp4d daemon
(which is for IBM ThinkPad trackpoint) is very useful and reliable with
2.0, 2.2 and 2.4 kernels, but it doesn't work with 2.6.x.

There is a good problem description at
http://www.informatik.uni-freiburg.de/~danlee/fun/psaux/ and a user space
driver which solves the problem. It works fine with 2.6.3, but not with
2.6.5.

The reason is that in 2.6.5 it looks impossible to disable the existing
mouse driver, which conflicts with driver from Tuukka Toivonen. My
temporary solution was as follows:


--- drivers/input/Kconfig.orig  2004-04-04 07:36:18.000000000 +0400
+++ drivers/input/Kconfig       2004-04-20 03:45:31.000000000 +0400
@@ -26,7 +26,6 @@ comment "Userland interfaces"

 config INPUT_MOUSEDEV
        tristate "Mouse interface" if EMBEDDED
-       default y
        depends on INPUT
        ---help---
          Say Y here if you want your mouse to be accessible as char devices


I am not experienced with the modern config managment, but it looks like
a bug in 2.6.5 configuration system. I suggest also to include Tuukka Toivonen
driver in 2.6.x tree, as it is stable, clearly described, and it solves
many compatibility problems.

_________________________________________________________________________
Evgeny Rodichev                          Sternberg Astronomical Institute
email: er@sai.msu.su                              Moscow State University
Phone: 007 (095) 939 2383
Fax:   007 (095) 932 8841                       http://www.sai.msu.su/~er
