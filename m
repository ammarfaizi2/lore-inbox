Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267219AbTAALhw>; Wed, 1 Jan 2003 06:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267221AbTAALhw>; Wed, 1 Jan 2003 06:37:52 -0500
Received: from stroke.of.genius.brain.org ([206.80.113.1]:62358 "EHLO
	stroke.of.genius.brain.org") by vger.kernel.org with ESMTP
	id <S267219AbTAALhv>; Wed, 1 Jan 2003 06:37:51 -0500
Date: Wed, 1 Jan 2003 06:46:12 -0500
From: "Murray J. Root" <murrayr@brain.org>
To: linux-kernel@vger.kernel.org
Subject: Re: USB-storage and CF reader oddness
Message-ID: <20030101114612.GA1621@Master.Wizards>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030101042407.GA1391@Master.Wizards>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030101042407.GA1391@Master.Wizards>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 11:24:07PM -0500, Murray J. Root wrote:
> 
> kernel 2.5.52 & 53
> 
> ASUS P4S533 (SiS645DX chipset)
> P4 2GHz
> 1G PC2700 RAM
> SanDisk SDDR-77 ImageMate CF reader
> 
> First - I really have no clue how to use this device in linux.
> 
> scsi, scsi disk, scsi CD and scsi generic builtin.
> USB and OHCI-HCD builtin (required for ps/2 mouse - no idea why)
> USB-storage as a module with all devices selected.
> 

New experiments have yielded:
Mandrake's initscript leaves "/bin/true" in /proc/sys/kernel/hotplug.
According to man hotplug the path "/sbin/hotplug" should be there.
Putting "/sbin/hotplug" in there seems to stop the hanging.

Making sd-mod a module and then doing
modprobe usb-storage
modprobe sd-mod
after inserting a card and
modprobe -r sd-mod
modprobe -r usb-storage
after taking the card out seems to work, except in ps I get lines like
 1671 ?        SW     0:00 scsi_eh_3
where the X in scsi_eh_X gets larger each time and the old ones remain
forever.

-- 
Murray J. Root
------------------------------------------------
DISCLAIMER: http://www.goldmark.org/jeff/stupid-disclaimers/
------------------------------------------------
Mandrake on irc.freenode.net:
  #mandrake & #mandrake-linux = help for newbies 
  #mdk-cooker = Mandrake Cooker 
  #cooker = moderated Mandrake Cooker

