Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262479AbSJ0SgL>; Sun, 27 Oct 2002 13:36:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262480AbSJ0SgL>; Sun, 27 Oct 2002 13:36:11 -0500
Received: from mailout06.sul.t-online.com ([194.25.134.19]:52100 "EHLO
	mailout06.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262479AbSJ0SgK>; Sun, 27 Oct 2002 13:36:10 -0500
To: linux-kernel@vger.kernel.org
Subject: Re: [Bug] 2.5.44-ac2 cdrom eject panic
References: <20021025103631.GA588@giantx.co.uk>
	<20021025103938.GN4153@suse.de> <87adl2is1u.fsf@gitteundmarkus.de>
	<20021025144224.GW4153@suse.de> <87pttyh3r5.fsf@gitteundmarkus.de>
	<20021025165354.GG4153@suse.de>
X-Face: 8omYku?tAexGd1v,5cQg?N#5RsX"8\+(X=<ysy((i6Hr2uYha{J%Mf!J:,",CqCZSr,>8o[ Ve)k4kR)7DN3VM-`_LiF(jfij'tPzNFf|MK|vL%Z9_#[ssfD[=mFaBy]?VV0&vLi09Jx*:)CVQJ*e3
 Oyv%0J(}_6</D.eu`XL"&w8`%ArL0I8AD'UKOxF0JODr/<g]
From: Markus Plail <plail@web.de>
Date: Sun, 27 Oct 2002 20:41:59 +0100
Message-ID: <874rb71xfc.fsf@gitteundmarkus.de>
User-Agent: Gnus/5.090008 (Oort Gnus v0.08) Emacs/21.3.50
 (i686-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens!

* Jens Axboe writes:
>On Fri, Oct 25 2002, Markus Plail wrote:
>>Yes it does. I can't burn though. I attached the cdrecord output. Hava
>>a look at the Blocks numbers. Although the image is only 500MB, it
>>says it wouldn't fit on the disc which is 700MB. In another try it
>>wanted to start burning although I had a bought audio CD in the
>>burner.

>As a hack, can you change:

>	if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
rq->errors = sense_key;
>in drivers/ide/ide-cd.c:cdrom_decode_status() to
>	if ((rq->flags & REQ_BLOCK_PC) && !rq->errors)
rq->errors = 2;

Works fine now :-)
Now if C2 scans would work that'd be great ;-)

[plail@plailis_lfs:plail]$ readcd dev=/dev/hdc -c2scan
Read  speed:  7056 kB/s (CD  40x, DVD  5x).
Write speed:     0 kB/s (CD   0x, DVD  0x).
Capacity: 4116432 Blocks = 8232864 kBytes = 8039 MBytes = 8430 prMB
Sectorsize: 2048 Bytes
Copy from SCSI (0,0,0) disk to file '/dev/null'
end:   4116432
addr:        0 cnt: 99^Mreadcd: Operation not permitted. Cannot send SCSI cmd vi
readcd: Operation not permitted. Cannot send SCSI cmd via ioctl

Thanks
Markus

