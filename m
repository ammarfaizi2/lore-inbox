Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130490AbRBQIun>; Sat, 17 Feb 2001 03:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130619AbRBQIud>; Sat, 17 Feb 2001 03:50:33 -0500
Received: from msp-65-25-214-194.mn.rr.com ([65.25.214.194]:59088 "EHLO
	msp-65-25-214-194.mn.rr.com") by vger.kernel.org with ESMTP
	id <S130490AbRBQIub>; Sat, 17 Feb 2001 03:50:31 -0500
Date: Sat, 17 Feb 2001 02:49:48 -0600
From: Rick Richardson <rickr@mn.rr.com>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Whats the rvmalloc() story?
Message-ID: <20010217024948.A1726@mn.rr.com>
In-Reply-To: <20010210220808.A18488@mn.rr.com> <20010217184633.A2484@linuxcare.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010217184633.A2484@linuxcare.com>; from anton@linuxcare.com.au on Sat, Feb 17, 2001 at 06:46:34PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 17, 2001 at 06:46:34PM +1100, Anton Blanchard wrote:
>  
> > I note that at least 5 device drivers have similar implementations
> > of rvmalloc()/rvfree() et al:
> > 
> > 	ieee1394/video1394.c
> > 	usb/ibmcam.c
> > 	usb/ov511.c
> > 	media/video/bttv-driver.c
> > 	media/video/cpia.c
> > 
> > rvmalloc()/rvfree() are functions that are used to allocate large
> > amounts of physically non-contiguous kernel virtual memory that will
> > then be mmap()'ed into a user process.
> 
> I had to rewrite rvmalloc and friends in the bttv driver to support the
> new pci dynamic mapping interface. This sounds like a good time to clean
> up all these multiple definitions.
> 
> Anton

If you are offering to do this work now, here is a thread worth
reading which includes a patch to start from...

	http://www.uwsg.iu.edu/hypermail/linux/kernel/0002.1/0586.html

BTW, Alan Cox sent me the following additional information in a
private email.  Might as well get this in the mailing list archives
for posterity so that the terms "rvmalloc" and "kiovecs" actually
appear in the same post.  This way, at least, we all know what the
plan for 2.6 should be.

On Tue, Feb 13 2001 at 14:21:50 -0500 (EST), Alan Cox wrote:
> > Whats the story behind rvmalloc() et al? From what I could tell,
> > about a year ago there were some patches to move rvmalloc() into
> > vmalloc() as a blessed feature of the kernel. But it looks to
> > me like these patches didn't "take".
>  
> The plan was to move to kiovecs for this but that didnt make 2.4.
>  
> > Is there some other way of doing this now? If so, does somebody
> > need to go into these drivers and patch them for the blessed way?
> > If not, is there some plan in place to bless these functions and
> > remove the code duplication?
>  
> I have no problem with someone verifying they are duplicates and doing
> that work.

-Rick

-- 
Rick Richardson  rickr@mn.rr.com      http://home.mn.rr.com/richardsons/
Twins Cities traffic animations are at http://members.nbci.com/tctraffic/#1

High oil prices encourage drilling and alternative energy research.
