Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132773AbRAQLFT>; Wed, 17 Jan 2001 06:05:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132795AbRAQLFK>; Wed, 17 Jan 2001 06:05:10 -0500
Received: from rcum.uni-mb.si ([164.8.2.10]:65296 "EHLO rcum.uni-mb.si")
	by vger.kernel.org with ESMTP id <S132773AbRAQLEv>;
	Wed, 17 Jan 2001 06:04:51 -0500
Date: Wed, 17 Jan 2001 12:04:41 +0100
From: David Balazic <david.balazic@uni-mb.si>
Subject: RE: Linux not adhering to BIOS Drive boot order?
To: "Dr. Kelsey Hudson" <kernel@blackhole.compendium-tech.com>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>
Message-id: <3A657C49.8D556099@uni-mb.si>
MIME-version: 1.0
X-Mailer: Mozilla 4.75 [en] (WinNT; U)
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
X-Accept-Language: en
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dr. Kelsey Hudson (kernel@blackhole.compendium-tech.com) wrote :
>    On Tue, 16 Jan 2001, Venkatesh Ramamurthy wrote:
>           
>    > [Venkatesh Ramamurthy] Dont you think that mounting and booting 
>    > based on disk label names is better, then relying on device nodes which can 
>    > change when a new card is added?. The existing patch for 2.2.xx is quite 
>    > small and it does not bloat the kernel too much either. I think we can port 
>    > it for 2.4.XX with ease.In my words it is worth the effort 
>           
>    Of course that would be better. The only complaint I have with such a
>    system is that of backwards compatibility...as long as the legacy device
>    names are still supported i would have no problem with it at all.

Yes, legacy names are supported. It is 100% backward compatible.
As far as I know ( I'm the author of the patch )

>                     
>    however, this brings up an interesting question: what happens if two disks
>    (presumably from two different machines) have the same disk label?

The first one found will be used. You are dependent on the ordering,
only in this special case, while before you were depending on ordering
every time.

> what
>    happens then? for instance, i have several linux machines both at my
>    workplace and my home. if for some reason one of these machines dies due
>    to hardware failure and i want to get stuff off the drives, i put the disk
>    containing the /home partition on the failed machine into a working
>    machine and reboot. What /home gets mounted then? the original /home or
>    the new one from the dead machine? (and don't say end users wouldn't
>    possibly do that... if they are adding hardware into their systems this is
>    by no means beyond their capabilities)
>   at least with physical device nodes i can say 'computer, you will mount  
>    this partition on this mountpoint!' and be done with it.

You can still do this, nothing is preventing you from it.
If you have /home in your fstab by its label, then you must
change this before you insert the other disk. Possibilities :
( to change in /etc/fstab)
 - use UUID instead of volume-label -> no conflicts ever
 - temporarily relabel your /home
 - temporarily use a device node

>    
>    so tell me then, how would one discern between two partitions with the
>    same label?   

-- 
David Balazic
--------------
"Be excellent to each other." - Bill & Ted
- - - - - - - - - - - - - - - - - - - - - -
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
