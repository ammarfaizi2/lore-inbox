Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751535AbWA0RBk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751535AbWA0RBk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 12:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751534AbWA0RBj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 12:01:39 -0500
Received: from linux01.gwdg.de ([134.76.13.21]:40862 "EHLO linux01.gwdg.de")
	by vger.kernel.org with ESMTP id S1751519AbWA0RBi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 12:01:38 -0500
Date: Fri, 27 Jan 2006 18:01:01 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: James Courtier-Dutton <James@superbug.co.uk>
cc: Joerg Schilling <schilling@fokus.fraunhofer.de>,
       no To-header on input 
	<"unlisted-recipients:; "@pop3.mail.demon.net>,
       mrmacman_g4@mac.com, matthias.andree@gmx.de,
       linux-kernel@vger.kernel.org, acahalan@gmail.com
Subject: Re: CD writing in future Linux (stirring up a hornets' nest)
In-Reply-To: <43DA4DDA.7070509@superbug.co.uk>
Message-ID: <Pine.LNX.4.61.0601271753430.11702@yvahk01.tjqt.qr>
References: <787b0d920601241858w375a42efnc780f74b5c05e5d0@mail.gmail.com>
 <43D7A7F4.nailDE92K7TJI@burner> <8614E822-9ED1-4CB1-B8F0-7571D1A7767E@mac.com>
 <43D7B1E7.nailDFJ9MUZ5G@burner> <20060125230850.GA2137@merlin.emma.line.org>
 <43D8C04F.nailE1C2X9KNC@burner> <20060126161028.GA8099@suse.cz>
 <43DA2E79.nailFM911AZXH@burner> <43DA4DDA.7070509@superbug.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> This are the three most important Linux kernel bugs:
>> 
>> -	ide-scsi does not do DMA if the DMAsize is not a multiple of 512
>> A person who knows internal Linux structures shoule be able
>> to fix this (and allow any multiple of 4) in less than one hour.
>> If we sum up the time spend on this discussoion, I really cannot
>> understand why this has not been fixed earlier.

Unfortunately, ide-scsi is deemed obsolete in 2.6, so it looks like no one 
seems to be willing to do that. About 2.4 I'm just as unsure, because it's 
in it's way to deep freeze. It might go through as a bugfix, though.

>> -	/dev/hd* artificially prevents the ioctls SCSI_IOCTL_GET_IDLUN
>> SCSI_IOCTL_GET_BUS_NUMBER from returning useful values.
>> As long as this bug is present, there is no way to see SG_IO via
>> /dev/hd* as integral part of the Linux SCSI transport concept.

Now you're talking shop ;-)

Hm, this ATAPI stuff makes me a headache. Well, anyway, out of 
curiosity, what is an ATAPI drive (IDE-ATAPI) supposed to return when asked 
for bus number, id or lun - independent of OS and/or cdrecord?

>> -	If sending SCSI sia ATAPI, Linux under certain unknown conditions
>> bastardizes the content of SCSI commands. A possible reason may be
>> that it sends random data in the remainder between the actual SCSI
>> cdb size and the ATAPI SCSI cdb size.

Not so good (the content freakup). IMO, if one can play around with the 
scsi tunnel (SG_IO) from userspace, commands should get through unmodified.
If it's not cdrecord/libscg making my writer do coffee, it must be this 
modification step.

> I think it might also be useful to make a list of all the SCSI commands that
> cdrecord uses. Including all the vendor specific ones. One could then verify
> that the Linux kernel is passing them onto the device correctly.

Or not, for that matter. There is surely a reason for the OS to do 
something to userspace-provided SG_IO packets to prevent the worst.


Jan Engelhardt
-- 
