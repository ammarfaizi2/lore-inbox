Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264095AbTDJQW1 (for <rfc822;willy@w.ods.org>); Thu, 10 Apr 2003 12:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTDJQWW (for <rfc822;linux-kernel-outgoing>);
	Thu, 10 Apr 2003 12:22:22 -0400
Received: from verdi.et.tudelft.nl ([130.161.38.158]:3715 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S264092AbTDJQWU (for <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Apr 2003 12:22:20 -0400
Message-Id: <200304101633.h3AGXs314320@verdi.et.tudelft.nl>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.0.4
X-Exmh-Isig-CompType: repl
X-Exmh-Isig-Folder: inbox
To: Joel Becker <Joel.Becker@oracle.com>
cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: O_DIRECT alignment requirements ? 
In-Reply-To: Message from Joel Becker <Joel.Becker@oracle.com> 
   of "Wed, 09 Apr 2003 16:27:15 PDT." <20030409232715.GE31739@ca-server1.us.oracle.com> 
Mime-Version: 1.0
Content-Type: text/plain
Date: Thu, 10 Apr 2003 18:33:54 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Apr 09, 2003 at 11:09:23PM +0200, Rob van Nieuwkerk wrote:
> > But a friend of mine uses O_DIRECT with 2.4 kernels to read *individual*
> > single harddisk sectors of 512 bytes !  He claims that my original
> > theory is the right one and that you can read 512 byte chunks on 512
> > byte bounderies (he uses the complete device eg. /dev/hda).
> 
> 	Well, how does your friend access /dev/hda?  Is he using raw
> devices?

Hi all,

OK, I checked again with him.  It turns out there was some confusion.
He does read in *1024* byte chunks after all (accessing /dev/hdX
directly) ..

But I still need to do 512 byte chunks myself (*).
I understand that this can be done with the the raw device construction ?

Would it also be possible to change the device blocksize with a BLKBSZSET
ioctl() to 512 and do 512 byte transfers after that ?

	greetings,
	Rob van Nieuwkerk


*: you might wonder why I'm so obsessed with 512 transfers ..
   The reason is that I'm working with a USB device (driver) that
   dies when there is too much CompactFlash IDE access (because
   of data-records logged to the CF).  I want to have the absolute
   minimum amount of disk-access.
