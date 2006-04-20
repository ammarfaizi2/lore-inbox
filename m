Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750856AbWDTMYy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750856AbWDTMYy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Apr 2006 08:24:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbWDTMYx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Apr 2006 08:24:53 -0400
Received: from iona.labri.fr ([147.210.8.143]:52884 "EHLO iona.labri.fr")
	by vger.kernel.org with ESMTP id S1750827AbWDTMYw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Apr 2006 08:24:52 -0400
Message-ID: <44477D93.50501@labri.fr>
Date: Thu, 20 Apr 2006 14:24:51 +0200
From: Emmanuel Fleury <emmanuel.fleury@labri.fr>
User-Agent: Mail/News 1.5 (X11/20060228)
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: linux-kernel@vger.kernel.org
Subject: [libata] atapi_enabled problem
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I'm a bit puzzled, I have a Fujistu-Siemens P7120 (see: 
http://www.labri.fr/perso/fleury/index.php?page=p7120) and the DVD-ROM 
wasn't detected at all at boot time.

After googling a bit I found this page: 
http://www.thinkwiki.org/wiki/Problems_with_SATA_and_Linux

So, I tried to compile the kernel with built-in ATAPI and S-ATA support 
(not as modules but embedded in the kernel) and I tried to pass 
libata.atapi_enabled=1 at boot time through kernel options. The 
DVD-drive was recognized at boot but generate tons of errors:

ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
sr0: CDROM (ioctl) error, command: <6>Test Unit Ready 00 00 00 00 00 00
sr: Current [descriptor]: sense key: Medium Error
     Additional sense: Unrecovered read error - auto reallocate failed
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51
ata1: translated ATA stat/err 0x51/20 to SCSI SK/ASC/ASCQ 0x3/11/04
ata1: no sense translation for error 0x20
ata1: no sense translation for status: 0x51

Then I decided to just modify drivers/scsi/libata-core.c changing the 
line "atapi_enabled = 0" into "atapi_enabled = 1". Then everything 
worked as a charm.

I have no explanation yet for this behaviour (passing kernel options 
should behave the same than changing the code the way I did I suppose).

Does anyone has an idea ?

Regards
--
Emmanuel Fleury
