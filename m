Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262423AbTIOBHc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Sep 2003 21:07:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262424AbTIOBHc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Sep 2003 21:07:32 -0400
Received: from smtp2.us.dell.com ([143.166.85.133]:47009 "EHLO
	smtp2.us.dell.com") by vger.kernel.org with ESMTP id S262423AbTIOBHa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Sep 2003 21:07:30 -0400
Date: Sat, 13 Sep 2003 20:05:33 +1400
From: Matt Domsch <Matt_Domsch@dell.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Jeff Garzik <jgarzik@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: 2.7 block ramblings (was Re: DMA for ide-scsi?)
Message-ID: <20030913060533.GA16668@tux.linuxdev.us.dell.com>
Reply-To: Matt Domsch <Matt_Domsch@dell.com>
References: <1063578413.2479.18.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1063578413.2479.18.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Sep 14, 2003 at 05:26:54PM -0500, Alan Cox wrote:
>    On Sad, 2003-09-13 at 17:11, Matt Domsch wrote:
>    > system-unique disk signature to the boot disk (int13 device 80h)
>    > "BOOT" or something - we've got 4 bytes available in the msdos label
>    > for it
> 
>    int 13 is still available during the 16bit boot up phase of the kernel.
>    It does strike me as playing with fire, but an alternative approach
>    might work. Read the first 4K off the boot disk, stuff it somewhere
>    temporary and then in 32bit compare it with the disk starts..

This is essentially what we are proposing, only instead of reading 4K,
read 1 sector and stash the 4-byte disk signature where we can get at
it later, and export it via edd.o for comparison later.  This much is
easy, as the empty_zero_page has 512 bytes free for reading the sector
in setup.S, and 4 bytes we can use to stash the signature until
setup.c runs where we can copy it somewhere safe.  Then export it via
edd.o through /proc (2.4) or /sys (2.6).

The thing that writes the signature to disk can be anything that can
issue int13 calls.  Right now we do it in a FreeDOS app, but a special
loadlin/syslinux/isolinux used for OS installation may be simpler and
not require a FreeDOS environment be run ever.

-Matt

-- 
Matt Domsch
Sr. Software Engineer, Lead Engineer
Dell Linux Solutions www.dell.com/linux
Linux on Dell mailing lists @ http://lists.us.dell.com
