Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264233AbTEXKBF (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 May 2003 06:01:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264235AbTEXKBE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 May 2003 06:01:04 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:16816 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S264233AbTEXKBD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 May 2003 06:01:03 -0400
Date: Sat, 24 May 2003 12:14:08 +0200 (MEST)
Message-Id: <200305241014.h4OAE8s0011456@harpo.it.uu.se>
From: mikpe@csd.uu.se
To: linux-kernel@vger.kernel.org, linuxtech@knology.net
Subject: Re: Still more Redhat Module Troubles
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 24 May 2003 00:02:30 -0400, John Shillinglaw wrote:
>Anyway I get not found messages when redhat modprobes char-major-10-1,
>eth1, etc. when it boots up. This seems to be related to aliases since
>eth1 is aliased to sis900 and char-major-10-1 to psaux. All help greatly
>appreciated... exact details and .config file below:
...
>I also tried to run the generate modprobe.conf script with no changes to
>the behavior.

Did you install the generated modprobe.conf in /etc? If not, do so.

rc.sysinit has a known problem that causes it to disable module
autoloading in 2.5 kernels. Fixed by the patch below.

mkinitrd generally doesn't work with 2.5 modules, or once the new
module-init-tools have been installed. I don't know how to fix
that; maybe an LKML archive search will find something.

--- /etc/rc.d/rc.sysinit~	2003-02-24 22:54:17.000000000 +0100
+++ /etc/rc.d/rc.sysinit	2003-05-01 17:07:09.000000000 +0200
@@ -357,7 +357,7 @@
     IN_INITLOG=
 fi
 
-if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/ksyms ]; then
+if ! LC_ALL=C grep -iq nomodules /proc/cmdline 2>/dev/null && [ -f /proc/modules ]; then
     USEMODULES=y
 fi
 
