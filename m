Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316608AbSHTIky>; Tue, 20 Aug 2002 04:40:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSHTIky>; Tue, 20 Aug 2002 04:40:54 -0400
Received: from k100-159.bas1.dbn.dublin.eircom.net ([159.134.100.159]:55044
	"EHLO corvil.com.") by vger.kernel.org with ESMTP
	id <S316608AbSHTIky>; Tue, 20 Aug 2002 04:40:54 -0400
Message-ID: <3D62015A.4000707@corvil.com>
Date: Tue, 20 Aug 2002 09:44:10 +0100
From: Padraig Brady <padraig.brady@corvil.com>
Organization: Corvil Networks
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020408
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Heater, Daniel (IndSys, GEFanuc, VMIC)" <Daniel.Heater@gefanuc.com>
CC: "'Linux Kernel'" <linux-kernel@vger.kernel.org>,
       "'andre@linux-ide.org'" <andre@linux-ide.org>,
       "Warner, Bill (IndSys, GEFanuc, VMIC)" <Bill.Warner@gefanuc.com>
Subject: Re: IDE-flash device and hard disk on same controller
References: <A9713061F01AD411B0F700D0B746CA6802FC1463@vacho6misge.cho.ge.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Heater, Daniel (IndSys, GEFanuc, VMIC) wrote:
> The IDE driver, file ide-probe.c currently contains this test do prevent
> hard drives and IDE-flash devices (ex CompactFlash) from co-existing on the
> same IDE controller. 
> 
>         /*
>          * Prevent long system lockup probing later for non-existant
>          * slave drive if the hwif is actually a flash memory card of some
> variety:
>          */
>         if (drive_is_flashcard(drive)) {
>                 ide_drive_t *mate =
> &HWIF(drive)->drives[1^drive->select.b.unit];
>                 if (!mate->ata_flash) {
>                         mate->present = 0;
>                         mate->noprobe = 1;
>                 }
>         }
> 
> This test's assumption that a spinning hard drive cannot coexist on the same
> controller as an IDE-flash device is incorrect.  I have a working setup with
> such a configuration.  I don't think that the IDE subsystem should punish
> everyone because _some_ hardware cannot tolerate this configuration.
> 
> One solution may be to remove this test from the IDE subsystem and force
> users with buggy hardware to explicitly  disable probing for a second
> device.  I think the parameters hdx=none or hdx=noprobe should work for
> them.
> 
> Comments??

Mentioned several times (and there is a workaround), see:
http://marc.theaimsgroup.com/?l=linux-kernel&m=100446144028502&w=2

I really think some of the default CF logic is bogus.

Pádraig.

