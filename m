Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265868AbUAEDuq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 22:50:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265869AbUAEDuq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 22:50:46 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:54683 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265868AbUAEDui
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 22:50:38 -0500
Date: Mon, 5 Jan 2004 03:50:37 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Linus Torvalds <torvalds@osdl.org>
Cc: Daniel Jacobowitz <dan@debian.org>, Andries Brouwer <aebr@win.tue.nl>,
       Rob Love <rml@ximian.com>, rob@landley.net,
       Pascal Schmidt <der.eremit@email.de>, linux-kernel@vger.kernel.org,
       Greg KH <greg@kroah.com>
Subject: Re: udev and devfs - The final word
Message-ID: <20040105035037.GD4176@parcelfarce.linux.theplanet.co.uk>
References: <20040104000840.A3625@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031802420.2162@home.osdl.org> <20040104034934.A3669@pclin040.win.tue.nl> <Pine.LNX.4.58.0401031856130.2162@home.osdl.org> <20040104142111.A11279@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041302080.2162@home.osdl.org> <20040104230104.A11439@pclin040.win.tue.nl> <Pine.LNX.4.58.0401041847370.2162@home.osdl.org> <20040105030737.GA29964@nevyn.them.org> <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0401041918260.2162@home.osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jan 04, 2004 at 07:33:16PM -0800, Linus Torvalds wrote:
> Ahh. I'll buy into that, and yes, this is an example of something that 
> needs to be fixed. 
> 
> It shouldn't be fixed by saying "device numbers have to be stable across 
> reboots", because the fact is, we're most likely going to have storage 
> that is really really hard to enumerate in a repeatable fashion.
> 
> So the _proper_ thing to do is to have the NFS server not use the device 
> number as part of fsid. It should use the _stable_ UUID of the filesystem 
> or some similar label.

... and we already have a way to specify it explicitly.  Which, BTW, allows
to take server down, copy exported fs from failing IDE disk to SCSI one and
reexport.  With clients remaining happy with you.  Remember discussions
circa 2.5.50 or so about that stuff?

So we have tools for that.  And it's 100% OK to say "if you are doing NFS
export of filesystem that lives on $new_weird_device, explicit fsid= is
not just a good idea, it's a must-have".

What is _not_ OK, though, is to have folks suddenly see /dev/hda3 changing
its device number - then we would break existing setups that worked all
along; even if admin can fix the breakage, it's not a good thing to do.
