Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262738AbUJ1DeZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262738AbUJ1DeZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Oct 2004 23:34:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262741AbUJ1DeY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Oct 2004 23:34:24 -0400
Received: from smtp2.gwu.edu ([128.164.127.227]:43162 "EHLO
	iron1-mx.tops.gwu.edu") by vger.kernel.org with ESMTP
	id S262738AbUJ1DeL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Oct 2004 23:34:11 -0400
X-BrightmailFiltered: true
X-Ironport-AV: i="3.86,108,1096862400"; 
   d="scan'208"; a="58814794:sNHT13941562"
From: Bijoy Thomas <bijoyjth@gwu.edu>
To: Lei Yang <lya755@ece.northwestern.edu>
Cc: linux-kernel@vger.kernel.org, kernelnewbies <kernelnewbies@nl.linux.org>
Message-ID: <55dddd455db643.55db64355dddd4@gwu.edu>
Date: Wed, 27 Oct 2004 23:34:08 -0400
X-Mailer: iPlanet Messenger Express 5.2 HotFix 1.17 (built Jun 23 2003)
MIME-Version: 1.0
Content-Language: en
Subject: Re: set blksize of block device
X-Accept-Language: en
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


You set the blocksize for block device when you format it. For e.g, when you format a device with mkfs.ext2, you specify what block size you wish to use. This gets recorded in the superblock of the device. You can see what blocksize a device is using by running the tune2fs command with the deivce as an argument.

Reading and writing a block on a device in userspace is as simple as opening the device, lseeking to the block in question and doing a read or write. Keep in mind that the filesystem blocksize has nothing to do with the blocksize for the device. The sector size for most block devices is 512 bytes. This means that the unit in which we can communicate with the device is 512bytes. However, the filesystem driver will have it own unit i.e, the blocksize. Hence, usually many sectors will fall in a block. The blocks are held in the buffer cache.The filesystem block size should be a power of 2 and less than the pagesize.

In kernel space, reads and writes to blocks on the device are done through the function bread and block_read. Both functions are used to read blocks from a device. If you modify a block, you can set the buffer as dirty and the kernel will later write it to disk.

Regards,
Bijoy.


----- Original Message -----
From: Lei Yang <lya755@ece.northwestern.edu>
Date: Wednesday, October 27, 2004 10:25 pm
Subject: Re: set blksize of block device

> Or in other words, is there generic routines for block devices such 
> that 
> we could:
> 
> get (set) block size of a block device;
> read an existing block (e.g. block 4);
> write an existing block (e.g. block 5);
> 
> Please help!!!!
> 
> TIA
> Lei
> 
> 
> Lei Yang wrote:
> 
> > If nobody could answer this question, what about another one? Is 
> there 
> > a system call or a kernel interface that would allow me to write 
> a 
> > block of data to block 1 of a certain block device?
> >
> > Thanks for your reply in advance!
> >
> > Lei
> >
> > Lei Yang wrote:
> >
> >> Please cc me if you have answers to this, I am not on the list. 
> >> Thanks a lot!
> >>
> >> Lei Yang wrote:
> >>
> >>> Hello,
> >>>
> >>> I am learning block device drivers and have a newbie question. 
> Given 
> >>> a block device, is there anyway that I could set its block 
> size? For 
> >>> example, I want to write a block device driver that will work 
> on an 
> >>> existing block device.  In this driver, I want block size 
> smaller. 
> >>> (The idea looks confusing but I could explain if anybody is 
> >>> interested :- )  However,  typically the block size is 1KB, now 
> I 
> >>> want to set it to 512 or 256.  Can I do it?
> >>>
> >>> TIA
> >>> Lei
> >>>
> >>
> >>
> >>
> >
> >
> >
> > -- 
> > Kernelnewbies: Help each other learn about the Linux kernel.
> > Archive:       http://mail.nl.linux.org/kernelnewbies/
> > FAQ:           http://kernelnewbies.org/faq/
> >
> >
> 
> 
> 
> --
> Kernelnewbies: Help each other learn about the Linux kernel.
> Archive:       http://mail.nl.linux.org/kernelnewbies/
> FAQ:           http://kernelnewbies.org/faq/
> 
> 

