Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131457AbRC0RIn>; Tue, 27 Mar 2001 12:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131459AbRC0RIe>; Tue, 27 Mar 2001 12:08:34 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:2268 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S131457AbRC0RI2>; Tue, 27 Mar 2001 12:08:28 -0500
Message-ID: <3AC0C8AC.4010304@AnteFacto.com>
Date: Tue, 27 Mar 2001 18:06:52 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Richard Smith <ras2@tant.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compact flash disk and slave drives in 2.4.2
In-Reply-To: <Pine.LNX.4.10.10103270838450.16125-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

OK the following assumes CF never have slaves which is just wrong.
The CF should be logically treated as an IDE harddisk. So the fix is
probably have a kernel parameter that causes the following check to
be skipped?

/*
   * Prevent long system lockup probing later for non-existant
   * slave drive if the hwif is actually a flash memory card of some 
variety:
   */
  if (drive_is_flashcard(drive)) {
          ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
          if (!mate->ata_flash) {
                mate->present = 0;
                ide_drive_t *mate = 
&HWIF(drive)->drives[1^drive->select.b.unit]
                mate->noprobe = 1;
          }
  }

But do we need this check? Is it just for speed. If you have an "ordinary"
harddrive as master with no slave, will the check for slave cause the same
"long system lockup", and if not, why.

Padraig.

Andre Hedrick wrote:

> Because in laptops, the primary use of CFA.
> Laptops using CFA do not have slaves.

