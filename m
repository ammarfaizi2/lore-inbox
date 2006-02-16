Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751314AbWBPLKB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751314AbWBPLKB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 06:10:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751352AbWBPLKB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 06:10:01 -0500
Received: from smtp-4.smtp.ucla.edu ([169.232.46.138]:10624 "EHLO
	smtp-4.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1751314AbWBPLKB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 06:10:01 -0500
Date: Thu, 16 Feb 2006 03:10:00 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: linux-kernel@vger.kernel.org
Subject: oops, 2.6.15.4 + qla1280+md+xfs+quota
Message-ID: <Pine.LNX.4.64.0602160115120.13014@potato.cts.ucla.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have a 2.6.15.4 system that was running fine.  Internal drives are using 
the Fusion MPT driver.  I have two external JBODs with 12 disks each. 
Each JBOD has two channels, 6 disks per channel, and each channel is 
connected to a QLogic ISP 10160 controller.

Each of the JBODs is built as an md raid5 (md1 and md2).  Both raid5s are 
mirrored (md3).  I had an ext3 filesystem running fine.

I unmounted md3, ran "mkfs.xfs /dev/md3 && mount /dev/md3" and the system 
hung.  md is built in, qla1280 and xfs are both modules.  mount options in 
fstab are rw, quota, noatime -- possibly also noexec and nosuid, but I 
don't think they were enabled.  XFS is built with XFS quota support; I've 
tried also with and without generic quota support.  4K stacks are enabled, 
if that matters.  Full .config and dmesg output are at 
http://hashbrown.cts.ucla.edu/pub/oops-200602/ (config is with generic 
quota, dmesg has xfs loaded as a module and /dev/md3 mounted without quota 
set).

I added "defaults" and removed "quota" from fstab for /dev/md3 and 
was able to mount the partition normally.

It's not responsive to sysrq on the serial console. The last output 
(without generic quota) was:

XFS mounting filesystem md3
XFS quotacheck md3: Please wait.
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
c0114f5a
*pde = 00000000
Oops: 0000 [#1]
SMP
Modules linked in: xfs e1000 bonding qla1280 st
CPU:    0
EIP:    0060:[<c0114f5a>]    Not tainted VLI
EFLAGS: 00010006   (2.6.15.4)
EIP is at do_page_fault+0x93/0x545
eax: eb7ac000   ebx: 00000001   ecx: 0000007b   edx: 00100100
esi: 000001ff   edi: c0114ec7   ebp: eb7ac0e8   esp: eb7ac094
ds: 007b   es: 007b   ss: 0068
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel NULL pointer dereference at virtual address 
00000078
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address bebaee76
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address bebaee76
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:
Unable to handle kernel paging request at virtual address 00100178
  printing eip:


As soon as I mount the partition with quota in fstab, the machine hangs. 
The oops is not always the same.  During one test run, I saw a number of 
"BUG: soft lockup detected on CPU#0" errors.  The above oops is the only 
one I managed to capture.



-Chris
