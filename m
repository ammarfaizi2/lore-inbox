Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261514AbTCJW0q>; Mon, 10 Mar 2003 17:26:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbTCJW0q>; Mon, 10 Mar 2003 17:26:46 -0500
Received: from adsl-67-113-154-34.dsl.sntc01.pacbell.net ([67.113.154.34]:28155
	"EHLO postbox.aslab.com") by vger.kernel.org with ESMTP
	id <S261514AbTCJW0o>; Mon, 10 Mar 2003 17:26:44 -0500
Message-ID: <3E6D150E.40105@aslab.com>
Date: Mon, 10 Mar 2003 14:43:26 -0800
From: Michael Madore <mmadore@aslab.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020830
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Video kernel modules can't enable write-combining
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I am experiencing a problem with AGP graphic cards on a SuperMicro 
X5DAL-G motherboard with RAM >= 4 GB.  I am seeing the problem with both 
an Nvidia as well as an ATI card, so I'm thinking that it is not the 
drivers.  Also, when the system is populated with 2GB of RAM, both cards 
work fine.  Here are the diagnostic messages from the Nvidia driver:

Mar 10 14:20:04 asl193 kernel: 1: nvidia: loading NVIDIA Linux x86 
nvidia.o Kernel Module  1.0-4191  Mon Dec  9 11:49:01
PST 2002
Mar 10 14:21:33 asl193 kernel: mtrr: type mismatch for e4000000,4000000 
old: uncachable new: write-combining
Mar 10 14:21:33 asl193 kernel: 1: nvidia: cannot write-combine 
0xe4000000, 64M

The performance of the video after X starts is extremely poor, and the 
contents of /proc/driver/nvidia/agp/status indicate that AGP is not 
enable.  I have tried 2.4.19 and 2.4.21pre5 (with PAE enabled) with the 
same results.

The contents of /proc/mtrr are:

reg00: base=0xe0000000 (3584MB), size= 512MB: uncachable, count=1
reg01: base=0x00000000 (   0MB), size=4096MB: write-back, count=1
reg02: base=0x100000000 (4096MB), size= 512MB: write-back, count=1
reg03: base=0xdff80000 (3583MB), size= 512KB: uncachable, count=1

The contents of /proc/meminfo are:

        total:    used:    free:  shared: buffers:  cached:
Mem:  4233945088 221356032 4012589056        0 17256448 160219136
Swap: 4293586944        0 4293586944
MemTotal:      4134712 kB
MemFree:       3918544 kB
MemShared:           0 kB
Buffers:         16852 kB
Cached:         156464 kB
SwapCached:          0 kB
Active:          75996 kB
Inactive:       102752 kB
HighTotal:     3276260 kB
HighFree:      3111608 kB
LowTotal:       858452 kB
LowFree:        806936 kB
SwapTotal:     4192956 kB
SwapFree:      4192956 kB
BigFree:             0 kB

If I install Windows XP on the same machine, the graphics performance is 
fine.  Interestingly, Windows only reports < 3.5GB of available memory.

Is it the case that this machine has only 3.5GB of usable memory?  If 
so, how do I configure the kernel to avoid putting the AGP aperture in 
the uncacheable region?  I tried passing mem=3400M at boot time. 
 /proc/meminfo reported the reduced memory, but the problem persists. 
 In any case, that would not work in a machine with 6GB.

Thanks for any advice

Mike Madore

