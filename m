Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261852AbTD2VXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Apr 2003 17:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbTD2VXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Apr 2003 17:23:39 -0400
Received: from 015.atlasinternet.net ([212.9.93.15]:31201 "EHLO
	antoli.gallimedina.net") by vger.kernel.org with ESMTP
	id S261852AbTD2VXf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Apr 2003 17:23:35 -0400
From: Ricardo Galli <gallir@uib.es>
Organization: UIB
To: linux-kernel@vger.kernel.org
Subject: Issues with 2.4.20/2.4.21-rc1[-ac3] and 2.5.68 on a Dell laptop
Date: Tue, 29 Apr 2003 23:35:51 +0200
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200304292335.51962.gallir@uib.es>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alan,
	first of all, thanks for you -acX, it solved several issues in my Dell 
X200, the inclusion of XFS is great, and dri/drm with xfree 4.3 works  
perfectly with the i830M (thanks).

But there still several problems (with APM enabled, no framebuffer):

- With cpufreq enabled, the kernel hangs if you change the CPU speed 
_after_ a suspend/resume via the old interface (/proc/sys/cpu/0/speed, 
(also repeatable in a vanilla or -rc1 kernel)). It doesn't happen if my 
governor program uses /proc/cpufreq instead. I saw this bug also with the 
original cpufreq patch and also with 2.5.68.

- cat /proc/i8k produces a long kernel lock, everything gets locked for a 
few seconds. If you are playing a music, you must restart the program in 
order the get alsa sync'd again.

- After suspend/resume, the kernel hangs during a shutdown (just like the 
infamous w98se shutdown bug :-), it happens after all processes have been 
TERMed. Sometimes the screen goes white (it happens also with Marcelo 
tree). I tried this with almost every different version and bios 
workaround in APM kernel options. I also happens with 2.5.68.

- The kernel hangs/lock hard if IO-APIC is enabled and you try to change 
the screen brightness (<Fn><[UP][DOWN]-Arrow>). It also happens with 
2.5.68.

- ACPI doesn't see the battery, the shutdown buttons just turn down with 
notifying the kernel, suspend doesn't work. Also seen with ACPI original 
patches and 2.5.68.

- Only happens with -ac3 version: the poweroff button turns the machine 
off inmediately, it doesn't wait for a few seconds, as previous versions.

Regards,


-- 
  ricardo galli       GPG id C8114D34
