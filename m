Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266733AbUF3QIq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266733AbUF3QIq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 12:08:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266751AbUF3QIq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 12:08:46 -0400
Received: from pri-dns2.mtco.com ([207.179.200.252]:10887 "HELO
	pri-dns2.mtco.com") by vger.kernel.org with SMTP id S266733AbUF3QIE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 12:08:04 -0400
From: Tom Felker <tcfelker@mtco.com>
To: Sean Champ <gimbal@sdf.lonestar.org>, linux-kernel@vger.kernel.org
Subject: Re: problems with CF card reader, kernel 2.6.7
Date: Wed, 30 Jun 2004 11:08:02 -0500
User-Agent: KMail/1.6.2
References: <20040630101605.GA3568@tokamak.homeunix.net>
In-Reply-To: <20040630101605.GA3568@tokamak.homeunix.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406301108.02618.tcfelker@mtco.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 30 June 2004 5:16 am, Sean Champ wrote:
> Hello,
>
> I'm having some troubles with a USB-based 6-in-1 "smart media" reader,
> in kernel 2.6.7.
>
> While using kernel 2.6.6, a couple of days ago, I was able to mount a
> CF card in the reader, successfully, and to move all of the files off
> of it. Then, I unmounted the chip, removed it from the reader, and
> tried to mount another. That, it seems, is when the problems started.
>
> I've only been able to mount a card in the reader once, in the past
> few days  (and that was done with an install of MSWindows'98, which
> seems to be having its own problems about things, such that it's about
> as useless as ever.)
>
> I've hoped that I might be able to help, at least, in offering som
> debug data, about whatever might be wrong with the software side of
> things.
>
> So, I compiled the usb-storage module, in my 2.6.7 kernel, with the
> extra debugging flag turned on. I started a little debugging session,
> then -- using 'logger' to record notes to the syslog, before each
> action with the reader (e.g.: plugging the reader in; plugging the
> card into the reader; unplugging each). I've included the syslog
> output, below. My own notes were added by user "sc"
>
>
> If I would need to provide any more information (e.g.: boot-time
> 'dmesg' output; other shell-command output; names of motherbord/usb
> components, etc), so that this might make more sense, then I'll be
> more than glad to send it along.
>
>
> Thank you!
>
> --
> Sean Champ
>
>
>
>
> Here's what I can think to include of syslog messages about the
> hardware
>
> (I'd be glad to include more hardware-identification info, if it would
> be of help. I'm not terribly sure of all of what's in the box,
> really, but Gateway should still have a record of it.)


> Here's the syslog output from the debugging session, for when I did
> the following:
>
> 1)  attached the card-reader to the USB root hub
> 2)  put a usable CF card in the reader
> 3)  tried to mount partition 1 from the CF card
> 4)  failed
> 5)  removed the CF card
> 6)  unplugged the reader


> Jun 29 23:20:40 tokamak sc: done: failure: 'mount' message was "mount:
> /dev/sda1 is not a vaid block device"

This is a stab in the dark, but try running "eject /dev/sg0" on the generic 
device coresponding to the card reader (or maybe the disc device, I'm not 
sure), after putting the new card in.  This forces the kernel to reread the 
card's partition table.

-- 
Tom Felker, <tcfelker@mtco.com>
<http://vlevel.sourceforge.net> - Stop fiddling with the volume knob.

"Outlook not so good." That magic 8-ball knows everything! I'll ask about 
Exchange Server next.
