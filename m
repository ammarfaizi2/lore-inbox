Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750819AbWH1T4V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750819AbWH1T4V (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 15:56:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751400AbWH1T4V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 15:56:21 -0400
Received: from mailgate.terastack.com ([195.173.195.66]:30472 "EHLO
	uk-mimesweeper.terastack.bluearc.com") by vger.kernel.org with ESMTP
	id S1750819AbWH1T4V convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 15:56:21 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: 0x7f in SectorIdNotFound errors
Date: Mon, 28 Aug 2006 12:56:18 -0700
Message-ID: <CECD6E8A589E8447BC6E836C8369AFF50AAE293D@us-email.terastack.bluearc.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 0x7f in SectorIdNotFound errors
Thread-Index: AcbK3Ac+xvPOJ/A3QgGjo/ys4dT1QQ==
From: "Martin Dorey" <mdorey@bluearc.com>
To: <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A while ago, I saw a rash of errors on a hard drive at the same alleged
sector:

Jul 26 06:30:12 ithaki kernel: hdb: drive_cmd: error=0x7f {
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
AddrMarkNotFound }, LBAsect=1647111536511, high=98175, low=8355711,
sector=0
Jul 26 06:30:12 ithaki kernel: hdb: drive_cmd: status=0x7f { DriveReady
DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Aug  6 06:30:18 ithaki kernel: hdb: drive_cmd: error=0x04 {
DriveStatusError }
Aug  6 06:30:18 ithaki kernel: hdb: drive_cmd: status=0x51 { DriveReady
SeekComplete Error }
Aug 12 01:10:17 ithaki kernel: hdb: drive_cmd: status=0x7f { DriveReady
DeviceFault SeekComplete DataRequest CorrectedError Index Error }
Aug 12 01:10:18 ithaki kernel: hdb: drive_cmd: error=0x7f {
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
AddrMarkNotFound }, LBAsect=1647111536511, high=98175, low=8355711,
sector=0
Aug 14 01:10:33 ithaki kernel: hdb: drive_cmd: error=0x7f {
DriveStatusError UncorrectableError SectorIdNotFound TrackZeroNotFound
AddrMarkNotFound }, LBAsect=1647111536511, high=98175, low=8355711,
sector=0
Aug 14 01:10:33 ithaki kernel: hdb: drive_cmd: status=0x7f { DriveReady
DeviceFault SeekComplete DataRequest CorrectedError Index Error }

In hex, that LBAsect is 0x17f7f7f7f7f.  The disk is:

	Model Number:       WDC WD3000JB-00KFA0                     
	Serial Number:      WD-WCAMR2255526
	Firmware Revision:  08.05J08

Kernel is Linux ithaki 2.6.16.18d865-sata #1 SMP Wed May 31 17:10:12 PDT
2006 i686 GNU/Linux.  IDE controller is:

0000:00:1f.1 IDE interface: Intel Corp. 82801EB/ER (ICH5/ICH5R) Ultra
ATA 100 Storage Controller (rev 02)

FS is ext3.  smartctl didn't report any errors but, then, it wouldn't
necessarily if the problem was garbage fs metadata.  I found a few other
LKML postings with 0x7f patterns in part of the LBAsect.
 
http://www.ussg.iu.edu/hypermail/linux/kernel/0605.3/1124.html 
http://www.ussg.iu.edu/hypermail/linux/kernel/0405.2/1227.html 
http://www.ussg.iu.edu/hypermail/linux/kernel/0307.2/1725.html 

I haven't found any postings in which anyone points out the 0x7f
pattern, which is why I thought I should post.  I've failed to reproduce
the problem since the above dates.  I'm not subscribed to the list but
would be interested to be cc()d on any replies.
-------------------------------------
Martin's Outlook, BlueArc Engineering

