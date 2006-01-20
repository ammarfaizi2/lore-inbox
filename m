Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWATWiU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWATWiU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Jan 2006 17:38:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932250AbWATWiU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Jan 2006 17:38:20 -0500
Received: from web50210.mail.yahoo.com ([206.190.38.51]:30899 "HELO
	web50210.mail.yahoo.com") by vger.kernel.org with SMTP
	id S932099AbWATWiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Jan 2006 17:38:20 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=wlzPQdMuNdQPyG/qAMnsJo4DqixJ8RpGYBsPlq69eBZwdw+xhakf4JiuO3n/Hn7cWedauP9d4TMG87C6V/4qKCC95bpDMvIMEc1LqQWzx8tJsfbzn3nf5hKO1Ld4dEF3Tagqdrx6i/qj481p/daAL1arDsd+2dLRCzC/PEj/cTs=  ;
Message-ID: <20060120223819.29415.qmail@web50210.mail.yahoo.com>
Date: Fri, 20 Jan 2006 14:38:19 -0800 (PST)
From: Alex Davis <alex14641@yahoo.com>
Subject: [BUG] DVD assigned wrong SCSI level when using SCSI emulation
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've noticed that since I upgraded to 2.6.15, my IDE DVD ROM
is assigned a bogus SCSI level. Here is output from /proc/scsi/scsi:

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVD-ROM GDR8082N Rev: 0106
  Type:   CD-ROM                           ANSI SCSI revision: 0xffffffff


Here's what I get with 2.6.8.1:

Host: scsi0 Channel: 00 Id: 00 Lun: 00
  Vendor: HL-DT-ST Model: DVD-ROM GDR8082N Rev: 0106
  Type:   CD-ROM                           ANSI SCSI revision: 02



I did a little digging, and it seems that in drivers/scsi/sr.c,
function get_capabilities(), the call to scsi_mode_sense() is failing (it's returning 134217730). 

On a side note, I can't watch DVDs on 2.6.15.

I have ide-scsi and sr-mod loaded as modules.
gcc version is 3.3.6

Here is the config for 2.6.8.1 : http://linux.ace-technologies.biz/config-2.6.8.1

Here is the config for 2.6.15: http://linux.ace-technologies.biz/config-2.6.15

I've tried booting with hdc=scsi; makes no difference.

Here's an excerpt from /var/log/messages:

Jan 19 20:46:29 boss kernel: [    1.662575] hdc: HL-DT-STDVD-ROM GDR8082N, ATAPI CD/DVD-ROM drive
Jan 19 20:46:29 boss kernel: [    1.969598] ide1 at 0x170-0x177,0x376 on irq 15
Jan 19 20:46:29 boss kernel: [    2.039442] IP route cache hash table entries: 65536 (order: 6,
262144 bytes)
Jan 19 20:46:29 boss kernel: [    2.039716] TCP established hash table entries: 262144 (order: 9,
2097152 bytes)
Jan 19 20:46:29 boss kernel: [    2.040901] TCP bind hash table entries: 65536 (order: 7, 524288
bytes)
Jan 19 20:46:29 boss kernel: [    2.042093] Using IPI Shortcut mode
Jan 19 20:46:29 boss kernel: [    2.052961] VFS: Mounted root (ext2 filesystem) readonly.
Jan 19 20:46:29 boss kernel: [    4.801179] ide-scsi is deprecated for cd burning! Use ide-cd and
give dev=/dev/hdX as device
Jan 19 20:46:29 boss kernel: [    4.954103] sr0: scsi-1 drive


I've seen this same phenomena in the dmesg output of another posting on this list.


I can test patches if needed. 

Additional info will be provided upon request.

-Alex


I code, therefore I am

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
