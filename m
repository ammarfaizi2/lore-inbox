Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751291AbWCVPXh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751291AbWCVPXh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 10:23:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751295AbWCVPXh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 10:23:37 -0500
Received: from s2.ukfsn.org ([217.158.120.143]:53980 "EHLO mail.ukfsn.org")
	by vger.kernel.org with ESMTP id S1751291AbWCVPXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 10:23:35 -0500
Message-ID: <44216C0F.1070306@dgreaves.com>
Date: Wed, 22 Mar 2006 15:23:59 +0000
From: David Greaves <david@dgreaves.com>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mark Lord <liml@rtr.ca>
Cc: Justin Piszcz <jpiszcz@lucidpixels.com>, Jeff Garzik <jgarzik@pobox.com>,
       Tejun Heo <htejun@gmail.com>, linux-kernel@vger.kernel.org,
       IDE/ATA development list <linux-ide@vger.kernel.org>,
       albertcc@tw.ibm.com, axboe@suse.de, Linus Torvalds <torvalds@osdl.org>
Subject: Re: LibPATA code issues / 2.6.15.4
References: <Pine.LNX.4.64.0602140439580.3567@p34> <43F2050B.8020006@dgreaves.com> <Pine.LNX.4.64.0602141211350.10793@p34> <200602141300.37118.lkml@rtr.ca> <440040B4.8030808@dgreaves.com> <440083B4.3030307@rtr.ca> <Pine.LNX.4.64.0602251244070.20297@p34> <4400A1BF.7020109@rtr.ca> <4400B439.8050202@dgreaves.com> <4401122A.3010908@rtr.ca> <44017B4B.3030900@dgreaves.com> <4401B560.40702@rtr.ca> <4403704E.4090109@rtr.ca> <4403A84C.6010804@gmail.com> <4403CEA9.4080603@rtr.ca> <44042863.2050703@dgreaves.com> <44046CE6.60803@rtr.ca> <44046D86.7050809@pobox.com> <4405DCAF.6030500@dgreaves.com> <4405DDEA.7020309@rtr.ca> <4405E42B.9040804@dgreaves.com> <4405E83D.9000906@rtr.ca> <4405EC94.2030202@dgreaves.com> <4405FAAE.3080705@dgreaves.com> <Pine.LNX.4.64.0603031437370.9331@p34> <4408C729.50401@dgreaves.com> <4409A369.1040607@rtr.ca> <440BD31C.9090801@dgreaves.com> <442041EF.7030107@dgreaves.com>
In-Reply-To: <442041EF.7030107@dgreaves.com>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Greaves wrote:

>I've upgraded to 2.6.16 and applied your verbosity patches.
>
>I've persuaded my array to re-assemble and during the resync I got these
>messages
>
>dmesg:
>ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/04 to SCSI
>SK/ASC/ASCQ 0xb/00/00
>ata1: status=0x51 { DriveReady SeekComplete Error }
>ata1: error=0x04 { DriveStatusError }
>...(18mins later)
>ata1: no sense translation for op=0x28 cmd=0x25 status: 0x51
>ata1: translated op=0x28 cmd=0x25 ATA stat/err 0x51/00 to SCSI
>SK/ASC/ASCQ 0x3/11/04
>ata1: status=0x51 { DriveReady SeekComplete Error }
>
>smartd is not running
>This did not cause the raid subsystem to boot the disk (thank goodness!)
>  
>
Just providing a little more followon information...

I have had a further 52 of these messages over the last day. No obvious
cause.
Mar 22 13:14:55 haze kernel: ata2: no sense translation for op=0x28
cmd=0x25 status: 0x51
Mar 22 13:14:55 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }

Most recently this happened:

Mar 22 13:47:09 haze kernel: ata2: no sense translation for op=0x28
cmd=0x25 status: 0x51
Mar 22 13:47:09 haze kernel: ata2: status=0x51 { DriveReady SeekComplete
Error }
Mar 22 13:47:09 haze kernel: sd 1:0:0:0: SCSI error: return code = 0x8000002
Mar 22 13:47:09 haze kernel: sdb: Current: sense key: Medium Error
Mar 22 13:47:09 haze kernel:     Additional sense: Unrecovered read
error - auto reallocate failed
Mar 22 13:47:09 haze kernel: end_request: I/O error, dev sdb, sector
396518289

with dmesg piping up with:
raid1: sdb2: rescheduling sector 5801424
raid1: sdd2: redirecting sector 5801424 to another mirror

no drives were kicked from the array.

David

-- 

