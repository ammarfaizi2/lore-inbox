Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131480AbRC0Swt>; Tue, 27 Mar 2001 13:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131320AbRC0Swa>; Tue, 27 Mar 2001 13:52:30 -0500
Received: from eventhorizon.antefacto.net ([193.120.245.3]:64220 "EHLO
	eventhorizon.antefacto.net") by vger.kernel.org with ESMTP
	id <S131323AbRC0Sw0>; Tue, 27 Mar 2001 13:52:26 -0500
Message-ID: <3AC0E112.6040607@AnteFacto.com>
Date: Tue, 27 Mar 2001 19:50:58 +0100
From: Padraig Brady <Padraig@AnteFacto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux 2.4.0-ac4 i686; en-US; 0.8.1) Gecko/20010326
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>
CC: Richard Smith <ras2@tant.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: Compact flash disk and slave drives in 2.4.2
In-Reply-To: <Pine.LNX.4.10.10103270912130.16125-100000@master.linux-ide.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

How do you activate the walk around you describe
to allow the detection of the slave? hda=ataflash?
Is this sort of stuff documented anywhere?

For those interested you also mention it here:
http://lists.sourceforge.net/archives//linux-usb-devel/2000-August/000929.html

This describes the other combination that causes
a problem where you have a normal disk as master
and the CF as slave:
http://boudicca.tux.org/hypermail/linux-kernel/2000week25/0973.html

Again the problem unresolved:
http://boudicca.tux.org/hypermail/linux-kernel/2000week26/0174.html

cheers,
Padraig.

Andre Hedrick wrote:

> Because 'real' ATA devices use a signature map the detects presense of
> master slave during execute diagnostics.  This is done in the BIOS.
> CFA does no report this correctly and waiting for a 31 second time out is
> not acceptable.  If you have a complain take it to CFA commitee and have
> them fix it.
> 
> I put in a walk around for having 2 CFA's to allow detection.
> This will work also if you call it for a CFA+Disk pair.
> 
> On Tue, 27 Mar 2001, Padraig Brady wrote:
> 
>> OK the following assumes CF never have slaves which is just wrong.
>> The CF should be logically treated as an IDE harddisk. So the fix is
>> probably have a kernel parameter that causes the following check to
>> be skipped?
> 
> Logically treated, is true, but again CFA does not follow the rules of
> what the ATA committee gives them, and I refuse to break rules as the
> standard model.  Rule breaking are exceptions.
> 
> Also show me a case where a laptop will do master/slave in CFA.
> 
>> /*
>>    * Prevent long system lockup probing later for non-existant
>>    * slave drive if the hwif is actually a flash memory card of some 
>> variety:
>>    */
>>   if (drive_is_flashcard(drive)) {
>>           ide_drive_t *mate = &HWIF(drive)->drives[1^drive->select.b.unit];
>>           if (!mate->ata_flash) {
>>                 mate->present = 0;
>>                 ide_drive_t *mate = 
>> &HWIF(drive)->drives[1^drive->select.b.unit]
>>                 mate->noprobe = 1;
>>           }
>>   }
>> 
>> But do we need this check? Is it just for speed. If you have an "ordinary"
>> harddrive as master with no slave, will the check for slave cause the same
>> "long system lockup", and if not, why.
>> 
>> Padraig.
>> 
>> Andre Hedrick wrote:
>> 
>> 
>>> Because in laptops, the primary use of CFA.
>>> Laptops using CFA do not have slaves.
>> 
> 
> Andre Hedrick
> Linux ATA Development
> ASL Kernel Development
> -----------------------------------------------------------------------------
> ASL, Inc.                                     Toll free: 1-877-ASL-3535
> 1757 Houret Court                             Fax: 1-408-941-2071
> Milpitas, CA 95035                            Web: www.aslab.com

