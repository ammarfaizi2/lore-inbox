Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316491AbSHRWnD>; Sun, 18 Aug 2002 18:43:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316499AbSHRWnC>; Sun, 18 Aug 2002 18:43:02 -0400
Received: from tomts8.bellnexxia.net ([209.226.175.52]:52706 "EHLO
	tomts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S316491AbSHRWnA>; Sun, 18 Aug 2002 18:43:00 -0400
Subject: Re: 2.4.18-rc3aa3: dma_intr: status=0x51 errors
From: Shane <shane@zeke.yi.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 18 Aug 2002 18:42:13 -0400
Message-Id: <1029710533.2243.44.camel@mars.goatskin.org>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the answers. Also, it is 2.4.19-rc3aa3 not whats in the
subject.

The man page for badblocks encourages me to use e2fsck -c to run
badblocks and to not run it directly. That, in addition to  the hint
from Alan that I was testing the incorrect range with badblocks lead to
wanting to run e2fsck -c -c /dev/vg01/biglv. That lead to:

kernel: lvm -- lvm_blk_ioctl: unknown command 0x24b
last message repeated 1443 times
message repeated 1422 times

Then I thought, e2fsck works on filesystems and badblocks works on
partitions so maybe this is not a good idea after all? What are the
correct numbers to feed to badblocks to get it to test that portion of
the disk?

Then some of these popped up a few minutes later:

smartd: Device: /dev/hda, S.M.A.R.T. Attribute: 231 Changed 11 
smartd: Device: /dev/hde, S.M.A.R.T. Attribute: 231 Changed 8 
smartd: Device: /dev/hdg, S.M.A.R.T. Attribute: 7 Changed -53 

This clued me into the fact I had previously enabled this SMART on this
box. I don't know much about SMART and I can't seem to find much about
which of the below errors are truly fatal and whats normal. I did a
short self test too.

I see the raw read error rate is 0 but it failed the self test in the 
read element!?

Is 11964485 a large number for Hardware ECC Recovered?

The drive is totally pooched I guess? Any light you could shed on which
of the below numbers are the tell-tale signs that the drive is dying
would be appreciated.

# smartctl -a /dev/hdg
Device: MAXTOR 6L080J4  Supports ATA Version 5
Drive supports S.M.A.R.T. and is enabled
Check S.M.A.R.T. Passed.

General Smart Values: 
Off-line data collection status: (0x00) Offline data collection activity
                                        was never started
Self-test execution status:      ( 112) The previous self-test completed
					having failed
                                        the read element of the test
Total time to complete off-line 
data collection:                 (  34) Seconds
Offline data collection 
Capabilities:                    (0x1b)SMART EXECUTE OFF-LINE IMMEDIATE
                                        Automatic timer ON/OFF support
                                        Suspend Offline Collection upon
					new command
                                        Offline surface scan supported
                                        Self-test supported
Smart Capablilities:           (0x0003) Saves SMART data before entering
                                        power-saving mode
                                        Supports SMART auto save timer
Error logging capability:        (0x01) Error logging supported
Short self-test routine 
recommended polling time:        (   2) Minutes
Extended self-test routine 
recommended polling time:        (  40) Minutes

Vendor Specific SMART Attributes with Thresholds:
Revision Number: 11
Attribute                    Flag     Value Worst Threshold Raw Value
(  1)Raw Read Error Rate     0x0029   100   253   020       0
(  3)Spin Up Time            0x0027   063   063   020       4659
(  4)Start Stop Count        0x0032   100   100   008       192
(  5)Reallocated Sector Ct   0x0033   097   097   020       18
(  7)Seek Error Rate         0x000b   100   047   023       0
(  9)Power On Hours          0x0012   096   096   001       2980
( 10)Spin Retry Count        0x0026   100   100   000       0
( 11)Calibration Retry Count 0x0013   100   100   020       0
( 12)Power Cycle Count       0x0032   100   100   008       166
( 13)Read Soft Error Rate    0x000b   100   100   023       0
(194)Temperature             0x0022   082   077   042       48
(195)Hardware ECC Recovered  0x001a   100   005   000       11964485
(196)Reallocated Event Count 0x0010   100   100   020       0
(197)Current Pending Sector  0x0032   100   100   020       3
(198)Offline Uncorrectable   0x0010   100   253   000       0
(199)UDMA CRC Error Count    0x001a   197   197   000       3
SMART Error Log:
SMART Error Logging Version: 1
Error Log Data Structure Pointer: 04
ATA Error Count: 109
Non-Fatal Count: 0

Thanks,

Shane


