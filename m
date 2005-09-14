Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030252AbVINQ26@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030252AbVINQ26 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 12:28:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVINQ25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 12:28:57 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:48066 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1030253AbVINQ2z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 12:28:55 -0400
Date: Wed, 14 Sep 2005 09:28:35 -0700
From: Patrick Mansfield <patmans@us.ibm.com>
To: Sergey Panov <sipan@sipan.org>
Cc: Luben Tuikov <luben_tuikov@adaptec.com>, Matthew Wilcox <matthew@wil.cx>,
       James Bottomley <James.Bottomley@SteelEye.com>,
       Douglas Gilbert <dougg@torque.net>,
       Christoph Hellwig <hch@infradead.org>, Luben Tuikov <ltuikov@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       SCSI Mailing List <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 2.6.13 5/14] sas-class: sas_discover.c Discover process (end devices)
Message-ID: <20050914162835.GA9409@us.ibm.com>
References: <1126537041.4825.28.camel@mulgrave> <20050912164548.GB11455@us.ibm.com> <1126545680.4825.40.camel@mulgrave> <20050912184629.GA13489@us.ibm.com> <1126639342.4809.53.camel@mulgrave> <4327354E.7090409@adaptec.com> <20050913203611.GH32395@parisc-linux.org> <43273E6C.9050807@adaptec.com> <20050913222519.GA1308@us.ibm.com> <1126675366.26050.41.camel@sipan.sipan.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1126675366.26050.41.camel@sipan.sipan.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2005 at 01:22:46AM -0400, Sergey Panov wrote:
> On Tue, 2005-09-13 at 15:25 -0700, Patrick Mansfield wrote:

> > Not all HBA drivers implement a mapping to a SCSI transport, we have
> > raid drivers and even an FC driver that has its own lun definition that
> > does not fit any SAM or SCSI spec.
> 
> May I ask you to name those drivers/HBAs, it would be interesting to
> look at how REPORT_LUN results are interpreted there. Actually, the data
> from the  REPORT_LUN response is always treated as proper  8 byte LUN
> and it is converted to int by scsilun_to_int(). What is interesting is
> how those derivers/HBA treat integer "lun" in queuecommand or EH calls.

I didn't look at raid driver code, I mean they can setup and use luns
however they want, as they are not following any scsi transport specs.

In drivers/scsi/qla2xxx/qla_iocb.c qla2x00_start_scsi(), it is swapped as
firmware wants le, and then the firmware has to convert it to a proper 8
byte LUN:

	cmd_pkt->lun = cpu_to_le16(sp->cmd->device->lun);

(I'm not sure where or how they handle 8 byte LUN for qla24xx per Ravin's
email).

> > So, we can't have one "LUN" that fits all, and it makes no sense to call
> > it a LUN when it is really a wtf.
> 
> IMHO one 8 byte LUN is better then wtf. I's kinda obvious :)

Yes :)

-- Patrick Mansfield
