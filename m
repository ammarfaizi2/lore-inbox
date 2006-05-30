Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751492AbWE3Vb4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751492AbWE3Vb4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 May 2006 17:31:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932484AbWE3Vbz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 May 2006 17:31:55 -0400
Received: from physics.harvard.edu ([128.103.101.20]:33477 "EHLO
	physics.harvard.edu") by vger.kernel.org with ESMTP
	id S1751492AbWE3Vby (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 May 2006 17:31:54 -0400
Message-ID: <447CB9B4.50700@physics.harvard.edu>
Date: Tue, 30 May 2006 17:31:32 -0400
From: Milan Kupcevic <milan@physics.harvard.edu>
Organization: Harvard University
User-Agent: Debian Thunderbird 1.0.2 (X11/20060423)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Fabian Knittel <fabian.knittel@avona.com>, Jeff Garzik <jgarzik@pobox.com>
CC: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>,
       Stan Seibert <volsung@mailsnare.net>, linux-ide@vger.kernel.org,
       Christiaan den Besten <chris@scorpion.nl>
Subject: Re: [PATCH] sata_promise: Port enumeration order - SATA 150 TX4,
 SATA 300 TX4
References: <43FFAE3D.7010002@physics.harvard.edu> <44000036.7070403@eyal.emu.id.au> <011f01c639f9$8dc86bc0$3d64880a@speedy> <442DB29D.1010102@avona.com>
In-Reply-To: <442DB29D.1010102@avona.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Fabian Knittel wrote:

>In other words: The boards appear to be wired correctly (or maybe just
>uniformly the wrong way) and the bios, the windows driver and the closed
>source promise driver (reportedly) know how to handle it.
>
>We have a SATA 150 TX4 board with the same behaviour and would love to
>see this annoying little bug fixed in linux. :)
>
>  Fabian
>
>Christiaan den Besten wrote:
>  
>
>>We have several of these boards in use [SATA 300 TX4] (bought over time
>>.. not in one batch). All of them have the ordering as described below.
>>So another vote for "Please fix!" :)
>>
>>    
>>
>>>Milan Kupcevic wrote:
>>>
>>>      
>>>
>>>>From: Milan Kupcevic <milan@physics.harvard.edu>
>>>>
>>>>Fix Promise SATAII 150 TX4 (PDC40518) and Promise SATA 300 TX4
>>>>(PDC40718-GP) wrong port enumeration order that makes it (nearly)
>>>>impossible to deal with boot problems using two or more drives.
>>>>
>>>>Signed-off-by: Milan Kupcevic <milan@physics.harvard.edu>
>>>>---
>>>>
>>>>The current kernel driver assumes:
>>>>
>>>>port 1 - scsi3
>>>>port 2 - scsi1
>>>>port 3 - scsi0
>>>>port 4 - scsi2
>>>>        
>>>>
>>>I totally agree with the fact that the Linux driver gets the ports wrong
>>>when compared to the BIOS, Windows and surely contradicts the port
>>>numbers printed on the board. I doubt we all got samples on the one
>>>bad batch...
>>>
>>>It *is* a real problem and if the solution is correct then I support it.
>>>
>>>Maybe we need a quick feedback from current users: do you guys find
>>>that the ports are detected as they are labelled (white silk screen)
>>>on the board or do they show up out of order (as listed above by
>>>Milan)?
>>>      
>>>

This is a list of Promise SATA TX4 and FastTrak TX4xxx controllers, I 
have in my lab, affected with the "wiring" bug:

Retail name: SATAII150 TX4
Chip label: PDC40518  SATAII150
Vendor-Device number: 105a:3d18 (rev 02)
Wiring: NEW

Retail name: FastTrak TX4200
Chip label: PDC40519  RAID  SATAII150
Vendor-Device number: 105a:3519
Wiring: NEW

Retail name: SATA300 TX4
Chip label: PDC40718-GP  SATAII300
Vendor-Device number: 105a:3d17 (rev 02)
Wiring: NEW


This is the only one Promise TX4 controller, I have in my lab, that is 
working properly regarding the "wiring" bug with the current kernel driver:

Retail name: FastTrak S150 TX4
Chip label: PDC20319 RAID SATA 150
Vendor-Device number: 105a:3319 (rev 02)
Wiring: OLD


This is a list of Promise SATA TX2 and FastTrak TX2xxx controllers, I 
have in my lab, that are working correctly regarding the "wiring" bug 
with the current kernel driver:

Retail name: FastTrak S150 TX2plus
Chip label: PDC20371  SATA 150
Vendor-Device number: 105a:3371 (rev 02)

Retail name: SATA150 TX2plus
Chip label: PDC20375  SATA 150
Vendor-Device number: 105a:3375 (rev 02)

Retail name: FastTrak TX2200
Chip label: PDC20571  SATAII150
Vendor-Device number: 105a:3571 (rev 02)


It seems the problem exists on all newer Promise SATA TX4 and FastTrak 
TX4xxx controllers, so I refer to them as the "new wiring" Promise SATA 
controllers.  All the Promise SATA TX2 and FastTrak TX2xxx I have in my 
lab are working correctly with the current kernel driver, so it seems 
this "wiring" problem does not affect the TX2(xxx) controllers; only 
SATA TX4 and FastTrak TX4xxx are affected.

For driver to be able to distinguish the "new wiring" and the "old 
wiring" Promise TX4(xxx) controllers we need a feedback from the users 
that are aware of this problem.

Q. How to know if a controller has the "new wiring"? 
A. You need to be able to boot your testing machine using a hard drive 
not attached to the controller you are going to test.  Connect 4 
different size/brand/model SATA hard drives to the testing controller so 
you can see the particular order they are recognized by the BIOS and by 
the kernel (not patched for the "new wiring"). 
   Boot the machine and look for the BIOS recognized hard drive order.  
The BIOS recognized hard drive order always matches the order the hard 
drives are connected to, with respect to port number labels.  If you are 
testing FastTrak TX series controller you may need to press Ctrl-F (or 
Ctrl-A) to get into controllers' BIOS and then press "2" to see the BIOS 
recognized order.  Plain SATA models do not have controller specific 
BIOS and they will report the BIOS recognized order without user 
intervention.  You may want to press the "Pause" key on your keyboard to 
have enough time to read the text on the screen.  If you are arguing 
with your machine using a serial terminal, there is a Hold Screen button 
somewhere on the terminal keyboard. 
   When the machine boots up, type "cat /proc/scsi/scsi", it will show 
up the order hard drives are recognized by the kernel.  Make sure the 
kernel you are using is NOT patched for the "new wiring" bug.  If you 
have the "new wiring" case, the order will be 3-2-4-1; that means, the 
drive connected to the "port 3" and recognized as the third drive 
connected to the controller by the BIOS, will be seen by the kernel as 
first hard drive connected to this controller.  The second drive is 
always at second place, the fourth one goes at third place and the first 
one goes at fourth place.


Please respond with this data:

- Your Promise SATA controller retail name
- Chip label (PDCxxxxx)
- PCI vendor and device code as you can get with "lspci -n"
- Say if the controler has the new or the old wiring
 
Your feedback will be appreciated.


NOTE: the patch I have submitted ( 
http://marc.theaimsgroup.com/?l=linux-ide&m=114082978311290&w=2 ) is a 
solution that doesn't know about the older Promise SATA controllers, 
which are not affected with the "new wiring" problem, so the older 
controllers will appear screwed if you use it.

Hopefully we will collect enough info about all the SATA Promise 
controllers to distinguish the new and the old wiring controllers, then 
produce a new patch that will be a correct solution to the "new wiring" 
problem.


The best to all,

Milan

-- 
Milan Kupcevic
System Administrator
Harvard University
Department of Physics

