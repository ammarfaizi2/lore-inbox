Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131032AbRCFROl>; Tue, 6 Mar 2001 12:14:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131033AbRCFROb>; Tue, 6 Mar 2001 12:14:31 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:36364 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S131032AbRCFROW>;
	Tue, 6 Mar 2001 12:14:22 -0500
Date: Tue, 06 Mar 2001 18:14:15 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: Re: scsi vs ide performance on fsync's
To: chromi@cyberspace.org
Cc: linux-kernel@vger.kernel.org
Message-id: <3AA51AE7.29FAC080@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.76 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(( please CC me , not subscribed , david.balazic@uni-mb.si )

Jonathan Morton (chromi@cyberspace.org) wrote :

> The OS needs to know the physical act of writing data has finished before     
> it tells the m/board to cut the power - period. Pathological data sets      
> included - they are the worst case which every engineer must take into  
> account. Out of interest, does Linux guarantee this, in the light of what
> we've uncovered? If so, perhaps it could use the same technique to fix    
> fdatasync() and family...

Linux currently ignores write-cache, AFAICT.
Recently I asked a similar question , about flushing drive caches at shutdown :
Subject : "Flusing caches on shutdown"
message archived at :
http://boudicca.tux.org/hypermail/linux-kernel/2001week08/0157.html
Body attached at end of this message.

The answer ( and only reply ) was :
[ archived at : http://boudicca.tux.org/hypermail/linux-kernel/2001week08/0211.html ]
--- begin quote ---
From: Ingo Oeser (ingo.oeser@informatik.tu-chemnitz.de)

On Mon, Feb 19, 2001 at 01:45:57PM +0100, David Balazic wrote:
> It is a good idea IMO to flush the write cache of storage devices 
> at shutdown and other critical moments. 
     
Not needed. All device drivers should disable write caches of
their devices, that need another signal than switching it off by  
the power button to flush themselves.
     
> Loosing data at powerdown due to write caches have been reported, 
> so this is no a theoretical problems. Also the journaled filesystems 
> are safe only in theory if the journal is not stored on non-volatile 
> memory, which is not guarantied in the current kernel. 
     
Fine. If users/admins have write caching enabled, they either
know what they do, or should disable it (which is the default for
all mass storage drivers AFAIK).
     
Hardware Level caching is only good for OSes which have broken
drivers and broken caching (like plain old DOS).

Linux does a good job in caching and cache control at software
level.
     
Regards

Ingo Oeser
--- end quote ---

My original mail :
--- begin quote ---
   (( CC me the replies, as I'm not subscribed to LKML ))

   Hi! 
     
   It is a good idea IMO to flush the write cache of storage devices
   at shutdown and other critical moments.
   I browsed through linux-2.4.1 and see no use of the SYNCHRONIZE CACHE
   SCSI command ( curiously it is defined in several other files
   besides include/scsi/scsi.h , grep returns :
   drivers/scsi/pci2000.h:#define SCSIOP_SYNCHRONIZE_CACHE 0x35
   drivers/scsi/psi_dale.h:#define SCSIOP_SYNCHRONIZE_CACHE 0x35
   drivers/scsi/psi240i.h:#define SCSIOP_SYNCHRONIZE_CACHE 0x35
   ) 

   I couldn't find evidence to the use of the equivalent ATA command either
   ( FLUSH CACHE , command code E7h ).
   Also add ATAPI to the list. ( and all other interfaces. I checked just SCSI
   and ATA )

   Loosing data at powerdown due to write caches have been reported,
   so this is no a theoretical problems. Also the journaled filesystems
   are safe only in theory if the journal is not stored on non-volatile 
   memory, which is not guarantied in the current kernel.

   What is the official word on this issue ?
   I think this is important to the "enterprise" guys, at the least.
                                           
   Sincerely,
   david 
   
   PS: CC me , as I'm not subscribed to LKML
--- end quote ---

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
