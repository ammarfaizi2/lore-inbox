Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030298AbVINRqJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030298AbVINRqJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 13:46:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030297AbVINRqI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 13:46:08 -0400
Received: from pat.qlogic.com ([198.70.193.2]:62306 "EHLO avexch01.qlogic.com")
	by vger.kernel.org with ESMTP id S1030295AbVINRqG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 13:46:06 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.6556.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Date: Wed, 14 Sep 2005 10:46:06 -0700
Message-ID: <3679966B84813344B908D418BA3F6A4A0461EE6B@AVEXCH01.qlogic.org>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Thread-Index: AcW5Ssmsad29ZrXNQ2ilWwMZAbcUaQABtQJg
From: "Ravi Anand" <ravi.anand@qlogic.com>
To: "Patrick Mansfield" <patmans@us.ibm.com>, "Sergey Panov" <sipan@sipan.org>
Cc: "Luben Tuikov" <luben_tuikov@adaptec.com>,
       "Matthew Wilcox" <matthew@wil.cx>,
       "James Bottomley" <James.Bottomley@SteelEye.com>,
       "Douglas Gilbert" <dougg@torque.net>,
       "Christoph Hellwig" <hch@infradead.org>,
       "Luben Tuikov" <ltuikov@yahoo.com>,
       "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
       "SCSI Mailing List" <linux-scsi@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 Patrick Mansfield wrote:
>>I didn't look at raid driver code, I mean they can setup and use luns
>>however they want, as they are not following any scsi transport specs.

>>In drivers/scsi/qla2xxx/qla_iocb.c qla2x00_start_scsi(), it is swapped as
>>firmware wants le, and then the firmware has to convert it to a proper 8
>>byte LUN:

>>	cmd_pkt->lun = cpu_to_le16(sp->cmd->device->lun);

>>(I'm not sure where or how they handle 8 byte LUN for qla24xx per Ravin's
email).

As I mentioned that HBA's can handle an 8 byte lun. But as far as the driver
is concerned, it does not populate all the level.

So if you look at the "struct cmd_type_7" iocb in qla_fw.h lun field is an 8 byte field.

struct cmd_type_7 {
	.......
 uint8_t lun[8];                 /* FCP LUN (BE). */
	.........
}

Here's the snippet
of the code where the driver builds iocb for ISP24XX in  qla24xx_start_scsi():

	 /* Set LUN number*/
        cmd_pkt->lun[1] = LSB(fclun->lun);
        cmd_pkt->lun[2] = MSB(fclun->lun);

Hope this clarifies the confusion if any.

Ravi


