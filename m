Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261190AbVAWC6t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261190AbVAWC6t (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jan 2005 21:58:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261191AbVAWC6t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jan 2005 21:58:49 -0500
Received: from main.gmane.org ([80.91.229.2]:32954 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261190AbVAWC6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jan 2005 21:58:45 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: =?ISO-8859-15?Q?Sven_K=F6hler?= <skoehler@upb.de>
Subject: 2.6 more picky about IDE drives than 2.4 ?
Date: Sun, 23 Jan 2005 04:00:52 +0100
Message-ID: <csv3ss$a4m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dsl-082-083-000-032.arcor-ip.net
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.8a6) Gecko/20050111
X-Accept-Language: de, en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

i have many problems with kernel 2.6.10 since it won't run stable with 
an IDE-device. It's an internal IDE-RAID subsystem. The DMA is 
frequently disabled, and even writes/reads fail and the kernel reports 
I/O-Errors for many sectors. The RAID-device doesn't report any errors 
it it's own event-log. You can have a closer look at the error-messages 
below.

I'm mailing to the LKML, since i haven't been abled to reproduce the 
problem with a kernel 2.4 bases system, but it randomly happens with 2.6 
kernels. Let's take the latest Knoppix as an example (it comes with both 
kernels):
- if i boot kernel 2.4, i can stress test the harddisk as much as i 
want. the kernel does report any problem and it doesn't disable DMA well
- if i boot kernel 2.6, after a while, there are the error-message below 
in the log. "hdparm -k1" doesn't help, the kernel will disable DMA mode. 
There was a also a bigger problems for two times now, where the kernel 
refused to write to the devide, due to the I/O-Errors below. I'm very 
sad, that i haven't the log-lines prior to the I/O-Errors.

I testes the RAID-subsystem with two different PC-systems. Always the 
same result: 2.4 works, 2.6 does not. It's hard for me to reproduce the 
Errors through. I'm still writing an application to reliably reproduce 
them :-( Does anybody know a good stress-test perhaps? Sequential 
reading doesn't seem to do the trick.

What changes have been applied to the IDE subsystem from kernel 2.4 to 
kernel 2.6? What may cause this different behaviour? What does 
"status=0x51" mean? And why is "error=0x00" although the Error-Bit in 
the status-byte has been set. (i guess this is what status=0x51 means).

How can the behaviour of kernel 2.6 be reverted to the behaviour of 
kernel 2.4? I already tried "hda=nowerr" in the append-line, but it 
doesn't help either. Is it a Bug of kernel 2.6, or should i smash the 
manufactures doors, to make them release a firmware-update of the 
RAID-subsystem since it reports strange values to the OS?


The first kind of errors:

hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x00 { }
ide: failed opcode was: unknown
hda: recal_intr: status=0x51 { DriveReady SeekComplete Error }
hda: recal_intr: error=0x00 { }
ide: failed opcode was: unknown
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x00 { }
ide: failed opcode was: unknown
hda: DMA disabled
ide0: reset: success

"dmesg" after with bigger problems:

end_request: I/O error, dev hdc, sector 709679458
ReiserFS: hdc3: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [1018017 1018816 0x0 SD]
ReiserFS: hdc3: warning: clm-6006: writing inode 283 on readonly FS
end_request: I/O error, dev hdc, sector 705275426
ReiserFS: hdc3: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [1018017 1018708 0x0 SD]
ReiserFS: hdc3: warning: clm-6006: writing inode 283 on readonly FS
end_request: I/O error, dev hdc, sector 709687130
ReiserFS: hdc3: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [1018017 1018817 0x0 SD]
ReiserFS: hdc3: warning: clm-6006: writing inode 283 on readonly FS
end_request: I/O error, dev hdc, sector 709695114
ReiserFS: hdc3: warning: vs-13070: reiserfs_read_locked_inode: i/o 
failure occurred trying to find stat data of [1018017 1018818 0x0 SD]
ReiserFS: hdc3: warning: clm-6006: writing inode 283 on readonly FS
end_request: I/O error, dev hdc, sector 709107250
...

