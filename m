Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262586AbVHDQtB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262586AbVHDQtB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 12:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262618AbVHDQq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 12:46:56 -0400
Received: from rproxy.gmail.com ([64.233.170.204]:35148 "EHLO rproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262628AbVHDQob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 12:44:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:x-accept-language:mime-version:to:cc:subject:x-enigmail-version:x-enigmail-supports:content-type:content-transfer-encoding;
        b=a2eDeh+G7EE3yV527UiwajhD+5dKS5QsKHTPJlAHwLyJkf4cganGvUApqC9Zy4V713GrkHSgCntDzk8u8QJZziY/vLogNWj7FztK1H40i+52dlXnOkbMeLDjfmRk6DoSL6wYfOPSHjwms9Mb9VmR5+w7yHCj+1FBSC3x/U3IeYk=
Message-ID: <42F219B3.6090502@gmail.com>
Date: Thu, 04 Aug 2005 13:35:47 +0000
From: Luca Falavigna <dktrkranz@gmail.com>
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: ebiederm@xmission.com, rddunlap@osdl.org
CC: fastboot@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: kexec and frame buffer
X-Enigmail-Version: 0.89.5.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I made three experiments regarding kexec with frame buffer support (vesafb). For
each of them I gathered dmesg messages from original and relocated kernel, in
order to easily compare them later on. These tests were run on a virtual machine
in order to provide the same environment for each experiment.

Here are my tests and related results:



	1) Frame buffer not enabled

Original kernel command line: root=/dev/hda1 ro
Relocated kernel command line: root=/dev/hda1 ro

Everything went well, as supposed to be. I was able to read boot messages and to
see login prompts.


	2) Frame buffer enabled in the relocated kernel

Original kernel command line: root=/dev/hda1 ro
Relocated kernel command line: root=/dev/hda1 ro vga=791

This time I was able to read boot messages and so on, but I couldn't be able to
load vesafb in the relocated kernel. dmesg showed nothing about vesafb.


	3) Frame buffer enabled in the original kernel

Original kernel command line: root=/dev/hda1 ro vga=791
Relocated kernel command line: root=/dev/hda1 ro {vga=791,}

This time I wasn't able to read boot messages in the relocated kernel, whether
vga parameter was set or not. I looked at dmesg in order to get some useful
informations:

Linux version 2.6.13-rc5 (dktrkranz@gandalf) (gcc version 3.3.4 (Debian
1:3.3.4-13)) #3 Wed Aug 3 13:39:11 UTC 2005
[...]
-Console: colour dummy device 80x25
+Console: colour VGA+ 80x25
[...]
-vesafb: framebuffer at 0xf0000000, mapped to 0xc2880000, using 3072k, total
16384k
-vesafb: mode is 1024x768x16, linelength=2048, pages=0
-vesafb: protected mode interface info at 00ff:44f0
-vesafb: scrolling: redraw
-vesafb: Truecolor: size=0:5:6:5, shift=0:11:5:0
-mtrr: your processor doesn't support write-combining
-Console: switching to colour frame buffer device 128x48
-fb0: VESA VGA frame buffer device
[...]

It seems relocated kernel doesn't (or can't) load vesafb. Is frame buffer
supported in kexec or there is some work-in-progress?



Regards,
--
					Luca


