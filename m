Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266077AbTGLPhG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jul 2003 11:37:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266085AbTGLPhG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jul 2003 11:37:06 -0400
Received: from c180224.adsl.hansenet.de ([213.39.180.224]:16024 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S266077AbTGLPhA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jul 2003 11:37:00 -0400
Message-ID: <3F102E8E.4030507@portrix.net>
Date: Sat, 12 Jul 2003 17:51:42 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030524 Debian/1.3.1-1.he-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: agpgart, nforce2, radeon and agp fastwrite
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just took me half a hour to figure out. On nforce2 you have to disable 
agp fastwrites, otherwise X locks hard on startup with the following 
(from serial console).

Linux agpgart interface v0.100 (c) Dave Jones
agpgart: Detected NVIDIA nForce2 chipset
agpgart: Maximum main memory to use for agp memory: 816M
agpgart: AGP aperture is 128M @ 0xd0000000
[drm] Initialized radeon 1.9.0 20020828 on minor 0
agpgart: Found an AGP 2.0 compliant device at 0000:00:00.0.
agpgart: Putting AGP V2 device at 0000:00:00.0 into 2x mode
agpgart: Putting AGP V2 device at 0000:02:00.0 into 2x mode

No response, neither by ping, nor sysrq or anything else. just dead.
I already defined AGP_DEBUG in agp.h but that doesn't make it noisier.

# lspci -v
02:00.0 VGA compatible controller: ATI Technologies Inc Radeon R200 QL 
[Radeon )
         Subsystem: Hercules: Unknown device 0000
         Flags: bus master, stepping, 66Mhz, medium devsel, latency 32, 
IRQ 5
         Memory at d8000000 (32-bit, prefetchable) [size=128M]
         I/O ports at a000 [size=256]
         Memory at e2000000 (32-bit, non-prefetchable) [size=64K]
         Expansion ROM at <unassigned> [disabled] [size=128K]
         Capabilities: [58] AGP version 2.0
         Capabilities: [50] Power Management version 2

Without AGP Fastwrites turned on, it all works wonderful. Just if 
anybody encounters the same problem.
Mainboard is nForce2 based, graphics is radeon 8500le (R200).

Jan

-- 
Linux rubicon 2.5.75-mm1-jd1 #2 SMP Fri Jul 11 12:49:37 CEST 2003 i686

