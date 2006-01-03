Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932472AbWACS34@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932472AbWACS34 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jan 2006 13:29:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932454AbWACS34
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jan 2006 13:29:56 -0500
Received: from bay101-f18.bay101.hotmail.com ([64.4.56.28]:43646 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S932420AbWACS3y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jan 2006 13:29:54 -0500
Message-ID: <BAY101-F1894F0927E1FB790D14772DF2C0@phx.gbl>
X-Originating-IP: [70.150.153.162]
X-Originating-Email: [jtreubig@hotmail.com]
From: "John Treubig" <jtreubig@hotmail.com>
To: alan@lxorguk.ukuu.org.uk, raw@dslr.net
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
       linux-scsi@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Tue, 03 Jan 2006 12:29:53 -0600
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----=_NextPart_000_3e45_188c_698"
X-OriginalArrivalTime: 03 Jan 2006 18:29:54.0149 (UTC) FILETIME=[B0F17950:01C61093]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

------=_NextPart_000_3e45_188c_698
Content-Type: text/plain; format=flowed

Alan,

Happy new year and many thanks for your help.  I took the information from 
the prior submissions and wanted to see if the Promise sub-system was my 
failure point.  I put a drive on the Secondary IDE bus hanging off the 
motherboard Nvidia NForce 2 controller, began an access and pulled the plug. 
  Sure enough the failures occured and were passed back to user level, but 
the system did not hang.  I've repeated this a number of times.  I moved the 
same drive to the Promise Controller and the hang occurs.  Thus it seems we 
have proved the Promise sub-system is my problem.

You suggested the something like IORDY hanging was not likely the problem.  
Given the data, what would you suspect?  I've included the message logs for 
the NForce for comparison.


From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Drew Winstel <raw@dslr.net>
CC: linux-ide@vger.kernel.org, John Treubig 
<jtreubig@hotmail.com>,linux-kernel@vger.kernel.org, 
linux-scsi@vger.kernel.org
Subject: Re: ATA Write Error and Time-out Notification in User Space
Date: Thu, 22 Dec 2005 01:09:16 +0000

On Maw, 2005-12-20 at 18:31 -0600, Drew Winstel wrote:
 > With the application that John is using (namely, it delivers reads and 
writes
 > directly to the drive via various SG ioctls), the file system is not an
 > issue, hence wanting the errors to be returned to userspace.
 >
 > I presume this means that John would have to look at the block level 
error
 > handling as opposed to the SCSI level?

If you are using the sg ioctls then the commands are dispatched and the
results come through the request queues but not the block layer above.

In that case you really shouldn't be seeing a hang.

Alan

-
To unsubscribe from this list: send the line "unsubscribe linux-ide" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


------=_NextPart_000_3e45_188c_698
Content-Type: text/plain; name="failure.txt"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Disposition: attachment; filename="failure.txt"

Jan  3 10:35:43 localhost kernel: [ 1326.485012] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 44 ce 00
Jan  3 10:35:43 localhost kernel: [ 1326.485018] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.485248] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 44 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.485358] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 44 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.485403] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.485407] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.485477] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 a3 cf 00
Jan  3 10:35:43 localhost kernel: [ 1326.485481] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.485519] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 a3 cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.485589] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 a3 cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.485632] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.485635] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.504714] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 27 cd 00
Jan  3 10:35:43 localhost kernel: [ 1326.504721] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.504939] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 27 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.505048] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 27 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.505093] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.505097] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.505168] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 92 cf 00
Jan  3 10:35:43 localhost kernel: [ 1326.505172] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.505226] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 92 cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.505297] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 92 cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.505340] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.505343] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.524300] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 e5 cd 00
Jan  3 10:35:43 localhost kernel: [ 1326.524307] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.524523] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 e5 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.524633] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 e5 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.524678] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.524682] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.524750] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 44 ce 00
Jan  3 10:35:43 localhost kernel: [ 1326.524754] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.524793] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 44 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.524864] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 44 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.524907] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.524910] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.543782] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 f9 cd 00
Jan  3 10:35:43 localhost kernel: [ 1326.543789] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.544003] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 f9 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.544113] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 f9 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.544176] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.544180] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.544251] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 2a cf 00
Jan  3 10:35:43 localhost kernel: [ 1326.544254] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.544292] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 2a cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.544361] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 2a cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.544404] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.544407] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.563356] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 9c cf 00
Jan  3 10:35:43 localhost kernel: [ 1326.563363] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.563581] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 9c cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.563690] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 9c cf 58
Jan  3 10:35:43 localhost kernel: [ 1326.563736] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.563739] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.563809] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 45 ce 00
Jan  3 10:35:43 localhost kernel: [ 1326.563813] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.563850] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 45 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.563922] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 45 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.563965] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.563968] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.582915] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 9e c9 00
Jan  3 10:35:43 localhost kernel: [ 1326.582922] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.583152] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 9e c9 58
Jan  3 10:35:43 localhost kernel: [ 1326.583264] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 9e c9 58
Jan  3 10:35:43 localhost kernel: [ 1326.583309] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.583313] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.583383] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 67 cd 00
Jan  3 10:35:43 localhost kernel: [ 1326.583387] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.583424] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 67 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.583494] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 67 cd 58
Jan  3 10:35:43 localhost kernel: [ 1326.583537] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.583540] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.602537] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 00 00 00 60 00 b1 c4 00
Jan  3 10:35:43 localhost kernel: [ 1326.602544] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.602760] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 00 00 fc 00 b1 c4 58
Jan  3 10:35:43 localhost kernel: [ 1326.602869] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 12 01 80 00 fc 00 b1 c4 58
Jan  3 10:35:43 localhost kernel: [ 1326.602914] ata_scsi_dump_cdb: CDB 
(1:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.602918] ata_scsiop_read_cap: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.602987] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 00 00 00 60 00 48 ce 00
Jan  3 10:35:43 localhost kernel: [ 1326.602991] ata_scsiop_inq_std: ENTER
Jan  3 10:35:43 localhost kernel: [ 1326.603028] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 00 00 fc 00 48 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.603114] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 12 01 80 00 fc 00 48 ce 58
Jan  3 10:35:43 localhost kernel: [ 1326.603157] ata_scsi_dump_cdb: CDB 
(6:0,0,0) 25 00 00 00 00 00 00 00 00
Jan  3 10:35:43 localhost kernel: [ 1326.603161] ata_scsiop_read_cap: ENTER
Jan  3 10:35:44 localhost kernel: [ 1327.700597] raddio: raddio_open() - 
file->f_mode=15
Jan  3 10:36:21 localhost kernel: [ 1364.170793] hdc: dma_timer_expiry: dma 
status == 0x61
Jan  3 10:36:31 localhost kernel: [ 1374.156104] hdc: DMA timeout error
Jan  3 10:36:31 localhost kernel: [ 1374.156114] hdc: dma timeout error: 
status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError 
Index Error }
Jan  3 10:36:31 localhost kernel: [ 1374.156121] hdc: dma timeout error: 
error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound 
TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=58557208
Jan  3 10:36:31 localhost kernel: [ 1374.156132] ide: failed opcode was: 
unknown
Jan  3 10:36:31 localhost kernel: [ 1374.158087] hdc: DMA disabled
Jan  3 10:36:31 localhost kernel: [ 1374.206030] ide1: reset: master: error 
(0x0a?)
Jan  3 10:37:01 localhost kernel: [ 1404.161969] hdc: lost interrupt
Jan  3 10:37:01 localhost kernel: [ 1404.161976] hdc: set_geometry_intr: 
status=0x7f { DriveReady DeviceFault SeekComplete DataRequest CorrectedError 
Index Error }
Jan  3 10:37:01 localhost kernel: [ 1404.161984] hdc: set_geometry_intr: 
error=0x7f { DriveStatusError UncorrectableError SectorIdNotFound 
TrackZeroNotFound AddrMarkNotFound }, LBAsect=260013951, sector=58557208
Jan  3 10:37:01 localhost kernel: [ 1404.161994] ide: failed opcode was: 
unknown
Jan  3 10:37:01 localhost kernel: [ 1404.211892] ide1: reset: master: error 
(0x0e?)
Jan  3 10:37:01 localhost kernel: [ 1404.211905] end_request: I/O error, dev 
hdc, sector 58557208
Jan  3 10:37:01 localhost kernel: [ 1404.295241] end_request: I/O error, dev 
hdc, sector 11436648
Jan  3 10:37:01 localhost kernel: [ 1404.295598] end_request: I/O error, dev 
hdc, sector 35034528
Jan  3 10:37:01 localhost kernel: [ 1404.295851] end_request: I/O error, dev 
hdc, sector 71396488
Jan  3 10:37:01 localhost kernel: [ 1404.296074] end_request: I/O error, dev 
hdc, sector 35035064
Jan  3 10:37:01 localhost kernel: [ 1404.296288] end_request: I/O error, dev 
hdc, sector 29730312
Jan  3 10:37:01 localhost kernel: [ 1404.296507] end_request: I/O error, dev 
hdc, sector 18232768
Jan  3 10:37:01 localhost kernel: [ 1404.297303] end_request: I/O error, dev 
hdc, sector 50093576
Jan  3 10:37:01 localhost kernel: [ 1404.297496] end_request: I/O error, dev 
hdc, sector 13031360
Jan  3 10:37:01 localhost kernel: [ 1404.297718] end_request: I/O error, dev 
hdc, sector 4525024
Jan  3 10:37:01 localhost kernel: [ 1404.298029] end_request: I/O error, dev 
hdc, sector 68605856
Jan  3 10:37:01 localhost kernel: [ 1404.298248] end_request: I/O error, dev 
hdc, sector 20995192
Jan  3 10:37:01 localhost kernel: [ 1404.298445] end_request: I/O error, dev 
hdc, sector 41058880
Jan  3 10:37:01 localhost kernel: [ 1404.298632] end_request: I/O error, dev 
hdc, sector 73172512
Jan  3 10:37:01 localhost kernel: [ 1404.298837] end_request: I/O error, dev 
hdc, sector 48503288
Jan  3 10:37:01 localhost kernel: [ 1404.299022] end_request: I/O error, dev 
hdc, sector 46497312
Jan  3 10:37:01 localhost kernel: [ 1404.299167] end_request: I/O error, dev 
hdc, sector 60576872
Jan  3 10:37:01 localhost kernel: [ 1404.299308] end_request: I/O error, dev 
hdc, sector 9632736
Jan  3 10:37:01 localhost kernel: [ 1404.299449] end_request: I/O error, dev 
hdc, sector 40871200
Jan  3 10:37:01 localhost kernel: [ 1404.299627] end_request: I/O error, dev 
hdc, sector 68270824
Jan  3 10:37:01 localhost kernel: [ 1404.299800] end_request: I/O error, dev 
hdc, sector 22557072
Jan  3 10:37:01 localhost kernel: [ 1404.299805] Buffer I/O error on device 
hdc, logical block 2819634
Jan  3 10:37:01 localhost kernel: [ 1404.299807] lost page write due to I/O 
error on hdc
Jan  3 10:37:01 localhost kernel: [ 1404.299952] end_request: I/O error, dev 
hdc, sector 58118752
Jan  3 10:37:01 localhost kernel: [ 1404.300100] end_request: I/O error, dev 
hdc, sector 74922088
Jan  3 10:37:01 localhost kernel: [ 1404.300240] end_request: I/O error, dev 
hdc, sector 38151592
Jan  3 10:37:01 localhost kernel: [ 1404.300380] end_request: I/O error, dev 
hdc, sector 76381056
Jan  3 10:37:01 localhost kernel: [ 1404.300520] end_request: I/O error, dev 
hdc, sector 62933696
Jan  3 10:37:01 localhost kernel: [ 1404.300660] end_request: I/O error, dev 
hdc, sector 42973464
Jan  3 10:37:01 localhost kernel: [ 1404.300810] end_request: I/O error, dev 
hdc, sector 37614272
Jan  3 10:37:01 localhost kernel: [ 1404.300950] end_request: I/O error, dev 
hdc, sector 14795552
Jan  3 10:37:01 localhost kernel: [ 1404.301137] end_request: I/O error, dev 
hdc, sector 73067064
Jan  3 10:37:01 localhost kernel: [ 1404.301141] Buffer I/O error on device 
hdc, logical block 9133383
Jan  3 10:37:01 localhost kernel: [ 1404.301143] lost page write due to I/O 
error on hdc
Jan  3 10:37:01 localhost kernel: [ 1404.301292] end_request: I/O error, dev 
hdc, sector 68217912
Jan  3 10:37:01 localhost kernel: [ 1404.301442] end_request: I/O error, dev 
hdc, sector 73352768
Jan  3 10:37:01 localhost kernel: [ 1404.301446] Buffer I/O error on device 
hdc, logical block 9169096
Jan  3 10:37:01 localhost kernel: [ 1404.301448] lost page write due to I/O 
error on hdc
Jan  3 10:37:01 localhost kernel: [ 1404.301590] end_request: I/O error, dev 
hdc, sector 46747304
Jan  3 10:37:01 localhost kernel: [ 1404.301730] end_request: I/O error, dev 
hdc, sector 65496040
Jan  3 10:37:01 localhost kernel: [ 1404.301881] end_request: I/O error, dev 
hdc, sector 66611208
Jan  3 10:37:01 localhost kernel: [ 1404.302021] end_request: I/O error, dev 
hdc, sector 3644328
Jan  3 10:37:01 localhost kernel: [ 1404.302167] end_request: I/O error, dev 
hdc, sector 17088312
Jan  3 10:37:01 localhost kernel: [ 1404.302316] end_request: I/O error, dev 
hdc, sector 47087584
Jan  3 10:37:01 localhost kernel: [ 1404.302320] Buffer I/O error on device 
hdc, logical block 5885948
Jan  3 10:37:01 localhost kernel: [ 1404.302322] lost page write due to I/O 
error on hdc
Jan  3 10:37:01 localhost kernel: [ 1404.302474] end_request: I/O error, dev 
hdc, sector 15981504
Jan  3 10:37:01 localhost kernel: [ 1404.302478] Buffer I/O error on device 
hdc, logical block 1997688
Jan  3 10:37:01 localhost kernel: [ 1404.302480] lost page write due to I/O 
error on hdc
Jan  3 10:37:01 localhost kernel: [ 1404.302653] end_request: I/O error, dev 
hdc, sector 70501312
Jan  3 10:37:01 localhost kernel: [ 1404.303509] end_request: I/O error, dev 
hdc, sector 0
Jan  3 10:37:01 localhost kernel: [ 1404.303512] Buffer I/O error on device 
hdc, logical block 0
Jan  3 10:56:42 localhost /sbin/hotplug: no runnable /etc/hotplug/vc.agent 
is installed


------=_NextPart_000_3e45_188c_698--
