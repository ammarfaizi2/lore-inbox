Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUGUSPx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUGUSPx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jul 2004 14:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266578AbUGUSPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jul 2004 14:15:53 -0400
Received: from berrymount.xs4all.nl ([82.92.47.16]:9575 "EHLO
	verdi.et.tudelft.nl") by vger.kernel.org with ESMTP id S266573AbUGUSPs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jul 2004 14:15:48 -0400
Date: Wed, 21 Jul 2004 20:15:32 +0200
From: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>
To: Shesha Sreenivasamurthy <shesha@inostor.com>
Cc: Rob van Nieuwkerk <robn@verdi.et.tudelft.nl>, linux-kernel@vger.kernel.org,
       kernelnewbies@nl.linux.org
Subject: Re: O_DIRECT
Message-Id: <20040721201532.7e6161ed.robn@verdi.et.tudelft.nl>
In-Reply-To: <40FEAF70.4070407@inostor.com>
References: <40FD561D.1010404@inostor.com>
	<20040721020520.4d171db7.robn@verdi.et.tudelft.nl>
	<40FEA382.8050700@inostor.com>
	<20040721192042.11f9c3f5.robn@verdi.et.tudelft.nl>
	<40FEAF70.4070407@inostor.com>
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Jul 2004 11:01:20 -0700
Shesha Sreenivasamurthy <shesha@inostor.com> wrote:

Hi Shesha,

> ohhh OK, if the block size is 4096, then the read/write size must be 
> integer multiple of 4096 ??? is it ???
> In general should the read/write length be a multiple of block size?

Yes, see my previous emails.

	greetings,
	Rob van Nieuwkerk

> Rob van Nieuwkerk wrote:
> 
> >On Wed, 21 Jul 2004 10:10:26 -0700
> >Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
> >
> >Hi Shesha,
> >
> >You don't mention what the *size* of your read()/write() is.
> >Besides a requirement on the alignment of the read/write buffer
> >the size of the read()/write() must also be OK.
> >
> >	greetings,
> >	Rob van Nieuwkerk
> >
> >  
> >
> >>This is what I found ....
> >>
> >>Our driver sets the block size to be 4096. so BLKBSZGET will return 
> >>4096. So if I allin the memory at 4096 boundary, I cannot read using 
> >>O_DIRECT. But, if I set the block size to 512.  I can read/write 
> >>successfully. It also works with 1024, but no with 4096
> >>
> >>So the recepie what I am following is ...
> >>
> >>BLKBSZGET -> Get original block size
> >>BLKBSZSET ->  Set the block size to 512
> >>READ | WRITE Successfully ;)
> >>BLKBSZSET ->  Set back to the original block size
> >>
> >>-Shesha
> >>
> >>Rob van Nieuwkerk wrote:
> >>
> >>    
> >>
> >>>On Tue, 20 Jul 2004 10:27:57 -0700
> >>>Shesha Sreenivasamurthy <shesha@inostor.com> wrote:
> >>>
> >>>Hi Shesha,
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >>>>I am having trouble with O_DIRECT. Trying to read or write from a block 
> >>>>device partition.
> >>>>
> >>>>1. Can O_DIRECT be used on a plain block device partition say 
> >>>>"/dev/sda11" without having a filesystem on it.
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>>yes.
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >>>>2. If no file system is created then what should be the softblock size. 
> >>>>I am using the IOCTL "BLKBSZGET". Is this correct?
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>>yes.
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >>>>3. Can we use SEEK_END with O_DIRECT on a partition without filesystem.
> >>>>   
> >>>>
> >>>>        
> >>>>
> >>>yes.
> >>>
> >>>I'm using these exact things in an application.
> >>>
> >>>Note that with 2.4 kernels the "granularity" you can use for offset
> >>>and r/w size is the softblock size (*).  For 2.6 the requirements are
> >>>much more relaxed: it's the device blocksize (typically 512 byte).
> >>>
> >>>(*): actually one of offset or r/w size has a smaller minimum if
> >>>I remember correctly.  Don't remember which one.  But if you assume
> >>>the softblock size as a minimum for both you're allways safe.
> >>>
> >>>	greetings,
> >>>	Rob van Nieuwkerk
> >>>
> >>>--
> >>>Kernelnewbies: Help each other learn about the Linux kernel.
> >>>Archive:       http://mail.nl.linux.org/kernelnewbies/
> >>>FAQ:           http://kernelnewbies.org/faq/
> >>>
> >>>
> >>>.
> >>>
> >>> 
> >>>
> >>>      
> >>>
> >
> >--
> >Kernelnewbies: Help each other learn about the Linux kernel.
> >Archive:       http://mail.nl.linux.org/kernelnewbies/
> >FAQ:           http://kernelnewbies.org/faq/
> >
> >
> >.
> >
> >  
> >
> 
