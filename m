Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266986AbTAIP6A>; Thu, 9 Jan 2003 10:58:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267732AbTAIP57>; Thu, 9 Jan 2003 10:57:59 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:29624 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S266986AbTAIP56>; Thu, 9 Jan 2003 10:57:58 -0500
Date: Thu, 9 Jan 2003 11:06:33 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB CF reader reboots PC - DEVFS did it
Message-ID: <20030109160633.GA1175@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030108165130.GA1181@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108165130.GA1181@Master.Wizards>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 08, 2003 at 11:51:30AM -0500, Murray J. Root wrote:
> ASUS P4S533 (SiS645DX chipset)
> P4 2GHz
> 1G PC2700 RAM
> SanDisk SDDR-77 ImageMate Dual Card Reader (using only CF cards)
> 
> ----------------------------
> devfs compiled in to kernel, devfs=nomount in lilo.conf
>   
> Insert CF card. mount it. cd to it, do reads and/or writes
> umount card. remove card.
> insert a different card (does not happen if the same card is used)
> mount it. system reboots. logs are corrupted
> 
> Doesn't happen every time for read - sometimes I can read 2 or 3 cards first
> Happens every time for write - if I write to a card then changing cards
> causes a reboot
> 
> ----------------------------
> devfs=mount in lilo.conf
>               
> Insert CF card. 
> ls /dev shows sda and sda1
> mount it. 
> ls /dev shows sda - no sda1
> cd to mounted CF card
> process hangs, sd-mod & usb-storage "busy"
> rmmod -f usb-storage or sd-mod causes PC to stop
> (keyboard & mouse unresponsive, wmfire frozen, net disconnects)
> 
> reboot
> Insert CF card. 
> ls /dev shows sda & sda1
> mount it. 
> ls /dev shows sda - no sda1
> umount it
> ls /dev shows sda - no sda1
> modprobe -r sd-mod && modprobe sd-mod 
> ls /dev shows sda & sda1
> 

New - 2.5.55
No more reboot - just a seg fault when trying to mount a new card
and process hangs if I try again (not surprising).

Removed devfs completely from build - everything works fine.
Can mount, read, write, umount many cards without a problem.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker
  #cooker = moderated Mandrake Cooker

