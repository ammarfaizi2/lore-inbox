Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261645AbTADWiR>; Sat, 4 Jan 2003 17:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261644AbTADWiR>; Sat, 4 Jan 2003 17:38:17 -0500
Received: from packet.digeo.com ([12.110.80.53]:29897 "EHLO packet.digeo.com")
	by vger.kernel.org with ESMTP id <S261645AbTADWiQ>;
	Sat, 4 Jan 2003 17:38:16 -0500
Message-ID: <3E17644D.59E3F205@digeo.com>
Date: Sat, 04 Jan 2003 14:46:37 -0800
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.54 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Steven Barnhart <sbarn03@softhome.net>
CC: linux-kernel@vger.kernel.org, linux-kernel-mm@vger.kernel.org
Subject: Re: 2.5.54-mm3
References: <3E16A2B6.A741AE17@digeo.com> <pan.2003.01.04.15.47.43.915841@softhome.net> <3E174FBB.9065575A@digeo.com> <002401c2b441$4e03eff0$18df9641@steven>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Jan 2003 22:46:42.0425 (UTC) FILETIME=[26A98E90:01C2B443]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Barnhart wrote:
> 
> > autofsv4 has been working fine across the 2.5 series.  You'll need to
> > send a (much) better report.
> 
> I don't really know what the problem is..everything seems to be working
> right except when it goes to mount the system from ro mode to rw mode.
> Therefore well everything goes down hill after that. I looked through the
> /var/log/messages and all those files but nothing specific to the problem.
> If I disable fsck and append rw mode kernel boots fine. One minor note, boot
> also fails during Mounting other filesystems and gives the typical mount
> error about bad superblock, or to many mounted filesystems. My .config was
> attached before(?) and that's all I have..anything paticular you are looking
> for?

Your .config was not attached.

There is a devfs mounting problem in 2.5.54.  If you're using devfs
you may find that
http://www.zip.com.au/~akpm/linux/patches/2.5/2.5.54/2.5.54-mm3/broken-out/devfs-mount-fix.patch
will help

> > You could try statically linking it, yes.  More details are needed,
> > such as a description of what hardware you have and what driver you're
> > using.
> 
> I have a i810 Intel graphics card/motherboard, intel celeron 1.06 GHz
> processor, and agp 3 enabled, could that be the problem? I have enabled the
> intel i810 driver in the graphics area as you can see in the .config. The
> intel driver seems to be enabled fine as in the Xfree/GDM log it says
> something about Intel. Only error is it can't find device /dev/agpgart even
> though it *is* there. Any more info you would need?

The device node exists in /dev.  It sounds like no kernel driver
has registered itself against tht node's major/minor.   Make really
sure that you have compiled the appropriate driver for your hardware;
things may have changed.  All else fails, send lspci and dmesg output
to this list and/or davej@codemonkey.org.uk
