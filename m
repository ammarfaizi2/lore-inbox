Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267275AbTAPVNc>; Thu, 16 Jan 2003 16:13:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267273AbTAPVNc>; Thu, 16 Jan 2003 16:13:32 -0500
Received: from kweetal.tue.nl ([131.155.2.7]:14760 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id <S267275AbTAPVN3>;
	Thu, 16 Jan 2003 16:13:29 -0500
Date: Thu, 16 Jan 2003 22:21:09 +0100
From: Andries Brouwer <aebr@win.tue.nl>
To: Michael Dreher <dreher@math.tu-freiberg.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: hda has changed heads
Message-ID: <20030116212109.GB22359@win.tue.nl>
References: <200301112249.11624.dreher@math.tu-freiberg.de> <20030111221617.GA20341@win.tue.nl> <200301162151.34206.dreher@math.tu-freiberg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200301162151.34206.dreher@math.tu-freiberg.de>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2003 at 09:51:34PM +0100, Michael Dreher wrote:
> Hello,
> 
> 
> Am Samstag, 11. Januar 2003 23:16 schrieb Andries Brouwer:
> > On Sat, Jan 11, 2003 at 10:49:11PM +0100, Michael Dreher wrote:
> > > Basically, I dont care about the new number of heads,
> >
> > Right
> >
> > > but now lilo complains like this (it did not complain before):
> >
> > Try giving LILO the keyword linear or lba32.
> > Then it does not need any idea about the geometry at bootloader
> > install time.
> 
> I tried, and it does not work. 
> 
> 
> karpfen:/home/dreher # lilo
> Added testing *
> Added linux
> Added failsafe
> Added linux-2.5.56
> Added linux-2.5.54
> Device 0x0300: Invalid partition table, 2nd entry
>   3D address:     1/0/20 (20160)
>   Linear address: 1/12/318 (321300)
> 
> Contrary to what it prints here, lilo has added nothing.
> 
> It should write the boot sector for windows on /dev/hda5, but can not
> do that because it does not understand the partition table anymore.
> 
> My box is running 2.5.56 at the moment.
> I wanted to install 2.5.58. But lilo refuses to change the MBR, because 
> of the number of changed heads. Even if I start it as lilo -L. 
> 
> 
> My solution is: reboot into 2.5.54. run lilo there. reboot into 2.5.58.
> Repeat for 2.5.59.
> 
> This is annoying. Any ideas how to solve this ?

You have not revealed your lilo version.
The above error message does not occur in a recent lilo,
so probably you have some older version. Looking at a
random older source I see

    if ((lin_3d > part_table[part].start_sect || (lin_3d <
      part_table[part].start_sect && cyl != BIOS_MAX_CYLS-1)) && !nowarn) {
        fflush(stdout);
        fprintf(stderr,"Device 0x%04X: Invalid partition table, %d%s entry\n",
          dev_nr & ~PART_MASK,part+1,!part ? "st" : part == 1 ? "nd" : part ==
          2 ? "rd" : "th");
...
        if (!cfg_get_flag(cf_options,"fix-table") && !cfg_get_flag(cf_options,
          "ignore-table")) exit(1);

So, there is a warning here that is fatal unless nowarn or ignore-table is set.
The nowarn is set by the lilo -w option.
So, try giving lilo the -w flag. Or upgrade to a more recent lilo.

Andries
