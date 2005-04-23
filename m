Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261578AbVDWNe6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261578AbVDWNe6 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 09:34:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbVDWNe6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 09:34:58 -0400
Received: from anchor-post-35.mail.demon.net ([194.217.242.85]:56846 "EHLO
	anchor-post-35.mail.demon.net") by vger.kernel.org with ESMTP
	id S261578AbVDWNez (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 09:34:55 -0400
Message-ID: <426A5D85.5060306@superbug.demon.co.uk>
Date: Sat, 23 Apr 2005 15:36:53 +0100
From: James Courtier-Dutton <James@superbug.demon.co.uk>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050416)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ron Gage <ron@rongage.org>
CC: linux-kernel@vger.kernel.org, daniel.ritz@gmx.ch, jonas.oreland@mysql.com
Subject: Re: Continuing woes - Yenta PCMCIA and USB 2.0 Cardbus Card
References: <200503291906.19890.ron@rongage.org>
In-Reply-To: <200503291906.19890.ron@rongage.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ron Gage wrote:
> Greetings:
> 
> I am trying to get a generic cardbus based USB 2.0 card working with an 
> external USB hard drive.  Even though I have received some good help to date, 
> things are still not going well.
> 
> The original problem was that inserting the cardbus card into my laptop would 
> cause the entire PCMCIA system to die instantly.  This problem is fixed - 
> inserting the card no longer kills the PCMCIA system.
> 
> What appears to be happening now is that there are codepath problems in the 
> EHCI/UHCI/OHCI code as they relate to the SCSI Disk driver.  All this is 
> tested against 2.6.11.6 on a Slackware 9.1 based laptop.
> 
> The USB drive works perfectly (albiet very slowly) when plugged directly into 
> the laptop's USB 1.1 port.
> 
> When the USB drive is plugged into the USB 2.0 cardbus card, the drive is ID'd 
> correctly (make/model), but the driver can not read the partition table.  
> Attempting to mount the drive doesn't work.  Unplugging the USB drive causes 
> the lockup to unlock.
> 
> Plugging a USB keydrive into the USB 2.0 card causes no problems.  Drive is 
> ID'd, make/model read, partition table read, can read/write/mount the key 
> drive without issue.  Same when plugging the keydrive into the laptop's 
> USB1.1 port.
> 
> Laptop is an HP Pavilion N5150, Intel USB chipset (UHCI).  Cardbus card is 
> generic ALI based USB chipset (EHCI/OHCI).  USB drive is a Sony VAIO external 
> case for a 2.5" drive.  The chip in the usb drive has no manufacturer 
> markings on it, just the following character sequences: CS881BAG, 0451B0C104, 
> 107
> 
> HELP!!!!
> 
> 

I have a similar problem.
I have a HP NC6000. It uses the Yenta PCMCIA kernel driver.
If I insert a PCMCIA card that uses cardmgr, it all works fine.
If I insert a Cardbus PCMCIA card it instead shows up as a PCI card, and
cardmgr does not even see it.
Now, here is the real problem. I can activate the card, and read PCI
information from it, but as soon as I do something like this:
value = inb(port);

I.e. The first inb/inw/inl command that the driver tries to do, locks up
the PC.

Does anyone have any ideas how to fix this?

James

