Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129344AbQKFUrJ>; Mon, 6 Nov 2000 15:47:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129388AbQKFUq7>; Mon, 6 Nov 2000 15:46:59 -0500
Received: from c151957-a.chmpgn1.il.home.com ([24.22.21.162]:29711 "EHLO
	utrek.dhs.org") by vger.kernel.org with ESMTP id <S129344AbQKFUqq>;
	Mon, 6 Nov 2000 15:46:46 -0500
Message-Id: <200011062046.OAA10302@utrek.dhs.org>
To: "James A. Sutherland" <jas88@cam.ac.uk>
cc: linux-kernel@vger.kernel.org, hobbes@utrek.dhs.org
Subject: Re: Persistent module storage [was Linux 2.4 Status / TODO page] 
In-Reply-To: Your message of "Mon, 06 Nov 2000 17:53:16 GMT."
             <00110617560604.24534@dax.joh.cam.ac.uk> 
Date: Mon, 06 Nov 2000 14:46:42 -0600
From: Evan Jeffrey <hobbes@utrek.dhs.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> On Mon, 06 Nov 2000, David Woodhouse wrote:
> > 
> > No. You have to reset the hardware fully each time you load the module. 
> > Although you _expect_ it to be in the state in which you left it, you can't
>  
> > be sure of that. 
> 
> If a reset is needed, I think it should come explicitly from userspace.
 
Take Alan's example of a USB device, say USB audio.  If it is disconnected
and reconnected to add a hub, or anything else, the device may shut itself
down, go to an undefined state, or even power cycle (if it draws power from 
the USB +5V).  Same with hot-swap PCI cards.  The driver *MUST* reset the 
device on load.  If saving mixer levels through this kind of transition is 
desired (which it evidentally is), the module load/unload code must save and 
restore the settings.

This is exactly equivelent to reseting hardware after a warm boot.  Who knows
what the Windows driver did to your card in the mean time.  A device driver
can only guarantee that nobody horkes with its hardware while it is loaded--
In the interim, the driver may have been connected to another computer,
accessed by another driver, or accessed from userspace (say, VMWare doing
a pass through driver).

I personally like the idea of having insmod/rmmod do copy-out/copy-in from
a cache file in userspace.  That way, if we need large data sets (a ROM
image for something.)  they don't take up kernel space when not in use.
Also, it allows people to have persistant settings across reboot through
the same mechanism--avoiding duplicating information in shutdown/startup 
scripts.

Evan
---
Fear is the mind killer.   -- Frank Herbert, "Dune"
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
