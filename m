Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312296AbSD0KQQ>; Sat, 27 Apr 2002 06:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312302AbSD0KQP>; Sat, 27 Apr 2002 06:16:15 -0400
Received: from freedom.icomedias.com ([193.154.7.22]:54338 "EHLO
	freedom.icomedias.com") by vger.kernel.org with ESMTP
	id <S312296AbSD0KQP> convert rfc822-to-8bit; Sat, 27 Apr 2002 06:16:15 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.0.5762.3
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: AW: 160gb disk showing up as 137gb
Date: Sat, 27 Apr 2002 12:16:06 +0200
Message-ID: <D143FBF049570C4BB99D962DC25FC2D2159B3A@freedom.icomedias.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: 160gb disk showing up as 137gb
Thread-Index: AcHt0HOzQP7CAsq7SUyaA+gaWDA5OAAAsaUA
From: "Martin Bene" <martin.bene@icomedias.com>
To: "Wakko Warner" <wakko@animx.eu.org>,
        "Jeff V. Merkey" <jmerkey@vger.timpanogas.org>
Cc: "Randy.Dunlap" <rddunlap@osdl.org>, <linux-kernel@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> It's not on a raid controller.  The machine has a PIIX3 ide 
> controller and a
> AHA-2940UW scsi controller.  Both exibit the same problem.

Actually, no: To fully use 160GB ATA drives, whatever device is on the other end of the ATA bus needs to actively support 48-bit address mode. In for the two cases you tried, that means 

IDE: The kernel IDE driver needs to support 48-bit addresseing to support 160GB.

SCSI: The firmware in your IDE<->SCSI Adapter needs to support 48-bit addressing.

So, while the symptoms are the same in both cases the problem is actually in two completely different places.

Most probably, you can't do anything about the IDE<->SCSI adapters firmware; however, you can do something about the linux ATA driver: code is in the 2.4.19-pre tree, it went in with 2.4.19-pre3.

Bye, Martin
