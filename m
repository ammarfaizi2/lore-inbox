Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262569AbTDQDUM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Apr 2003 23:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262599AbTDQDUM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Apr 2003 23:20:12 -0400
Received: from cable98.usuarios.retecal.es ([212.22.32.98]:46728 "EHLO
	hell.lnx.es") by vger.kernel.org with ESMTP id S262569AbTDQDUL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Apr 2003 23:20:11 -0400
Date: Thu, 17 Apr 2003 05:31:54 +0200
From: Manuel Estrada Sainz <ranty@debian.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: "'David Gibson'" <david@gibson.dropbear.id.au>,
       "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>,
       "'Linux Kernel Mailing List'" <linux-kernel@vger.kernel.org>
Subject: Re: firmware separation filesystem (fwfs)
Message-ID: <20030417033154.GD31473@ranty.ddts.net>
Reply-To: ranty@debian.org
References: <A46BBDB345A7D5118EC90002A5072C780C262E38@orsmsx116.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A46BBDB345A7D5118EC90002A5072C780C262E38@orsmsx116.jf.intel.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 16, 2003 at 07:00:00PM -0700, Perez-Gonzalez, Inaky wrote:
> 
> > From: David Gibson [mailto:david@gibson.dropbear.id.au]
> > 
> > Incidentally another approach that also avoids nasty ioctl()s would be
> > to invoke the userland helper with specially set up FD 1, which lets
> > the kernel capture the program's stdout. 
> 
> I think this makes too many assumptions specially taking into
> account that most hotplug stuff are shell scripts - they are
> probably going to be writing all kinds of stuff to stdout.

 Well, FD 3 could be used instead and "cat firmware_image >&3". shell
 scripts should not be writing to FD 3.
 
> With the risk of repeating myself (again) and being a PITA,
> I really think it'd be easier to copy the firmware file to a 
> /sysfs binary file registered by the device driver during 
> initialization; then the driver can wait for the file to be
> written with a valid firmware before finishing the init
> sequence. The infrastructure is already there (or isn't ... 
> is it?).

 I don't know that much about sysfs, after a little investigation, it
 seams like sysfs entries are restricted in size to PAGE_SIZE, which on
 i386 is 4K, and ezusb firmware is already 6.9K in size.

 I would really appreciate someone more knowledgeable than myself
 commenting on the possibility of extending sysfs to fill this gap.

 Have a nice day

 	ranty

-- 
--- Manuel Estrada Sainz <ranty@debian.org>
                         <ranty@bigfoot.com>
			 <ranty@users.sourceforge.net>
------------------------ <manuel.estrada@hispalinux.es> -------------------
Let us have the serenity to accept the things we cannot change, courage to
change the things we can, and wisdom to know the difference.
