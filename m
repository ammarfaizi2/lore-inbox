Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263040AbTC1QoS>; Fri, 28 Mar 2003 11:44:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263041AbTC1QoS>; Fri, 28 Mar 2003 11:44:18 -0500
Received: from [81.2.110.254] ([81.2.110.254]:24315 "EHLO lxorguk.ukuu.org.uk")
	by vger.kernel.org with ESMTP id <S263040AbTC1QoR>;
	Fri, 28 Mar 2003 11:44:17 -0500
Subject: Re: hdparm and removable IDE?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jeremy Jackson <jerj@coplanar.net>
Cc: Ron House <house@usq.edu.au>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1048860279.1615.13.camel@contact.skynet.coplanar.net>
References: <Pine.LNX.3.96.1030326130640.8110B-100000@gatekeeper.tmr.com>
	 <3E83BFC8.70901@usq.edu.au>
	 <1048860279.1615.13.camel@contact.skynet.coplanar.net>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1048870533.5055.13.camel@dhcp22.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 28 Mar 2003 16:55:34 +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2003-03-28 at 14:04, Jeremy Jackson wrote:
> It might be better to say not supported fully, or support not complete. 
> Most chipsets and their linux drivers have the ability to tristate-off
> the IDE bus, making it work safely on the electrical level.  Switching
> off the power to the drive has to be provided by the swap bay in
> question.  I can get that for $17 CDN.  But...

Hardly "most", I think its two

> This is another piece of the puzzle.  The kernel buffer-cache can be
> flushed by a simple sync command.  I've only seen the IDE write cache

And on umount by 2.5, or always on 2.4 as well if the device is marked
removable

> What can be done at boot... correct.  However, the BIOS does part of the
> BOOT init, the linux kerenel IDE driver does some more.  So changing the
> drive without rebooting through BIOS can be a problem.  The PIO modes
> are the issue here.  Perhaps a script can do hdparm -X somehow, but
> nobody is certain if it will be reliable, because who knows what the
> bios does.  With LinuxBIOS there is hope though.

Not really the PIO modes. In fact the PIO modes are generally just fine.
The problems are mostly at the DMA and UDMA end of things where there
is complex setup or interactions involved.

> IMHO the ide driver is a real mess.  statically allocated structures,

You bet.

> because the kernel command line parameters have to be read early because
> they're so wierd, no wonder the hdparm -U / -R stuff is busted.  It
> should take the PCI ID of the interface, not the io ports.  Fixing this
> is on my hit list, in about a month.

2.7 at the earliest, and only if there is a general buy in about such a
change to the init handling. Similarly the big issues with hdparm -U and
-R are the same as with hotplug races, and will take a lot more than
quick hacks to fix.

Alan

