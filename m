Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbTEQKip (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 May 2003 06:38:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbTEQKip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 May 2003 06:38:45 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:2454 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S261399AbTEQKio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 May 2003 06:38:44 -0400
Date: Sat, 17 May 2003 12:51:30 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: Greg KH <greg@kroah.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
       Simon Kelley <simon@thekelleys.org.uk>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       "Downing, Thomas" <Thomas.Downing@ipc.com>, jt@hpl.hp.com,
       Pavel Roskin <proski@gnu.org>
Subject: Re: request_firmware() hotplug interface, third round.
Message-ID: <20030517105130.GA17998@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <20030515200324.GB12949@ranty.ddts.net> <20030516223624.GA16759@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030516223624.GA16759@kroah.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 16, 2003 at 03:36:24PM -0700, Greg KH wrote:
> On Thu, May 15, 2003 at 10:03:24PM +0200, Manuel Estrada Sainz wrote:
[snip]
> >  Attached:
> >  	firmware.h
> > 	firmware_class.c:
> > 		The firmware support itself.
> 
> Can you just send this as a patch to the current kernel next time?  It's
> much easier to read and test with that way :)

 When I updated my tree (via bk cvs gateway) to make the patch I noticed
 some changes in sysfs's binary support.

 In general, they look good, but the size of files is set in
 sysfs_create_bin_file and not changeable later.  This breaks
 firmware_class.c :(

 With current request_firmware(), the drivers don't tell the size of the
 firmware, and in some cases they don't even know, so changing the
 interface is no good.

 I also don't understand why sysfs needs to keep a copy of the data in
 it's own buffer. It has to ask the driver for any read/write anyway,
 the previous approach of one page at a time looked better to me and
 saves some kernel memory :-).

 And the size checks could be skipped in case of zero size.

 I'll include a change proposal to sysfs/bin.c next time.

 Have a nice day

 	Manuel

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
