Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317304AbSHAW5M>; Thu, 1 Aug 2002 18:57:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317306AbSHAW5M>; Thu, 1 Aug 2002 18:57:12 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:24580 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317304AbSHAW5L>;
	Thu, 1 Aug 2002 18:57:11 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 2 Aug 2002 01:00:21 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, mingo@elte.hu
X-mailer: Pegasus Mail v3.50
Message-ID: <CF309A2B3C@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 18:52, Alexander Viro wrote:
> On Fri, 2 Aug 2002, Petr Vandrovec wrote:
> 
> > > Uh-oh...
> > > 
> > > Let me see if I got it straight:
> > > 
> > > a) your disk doesn't work with half-Kb requests
> > > b) you have a partition with odd number of sectors
> > > c) hardsect_size is set to half-Kb
> > > d) old code worked since it rounded size to multiple of kilobyte.
> > > 
> > > Correct?
> > 
> > Yes, exactly. Replacing disk is not an option...
> 
> OK.  At the very least we need a way for driver to tell what the sector
> size is.  And that can be a problem - AFAICS IDE shares the queue for
> master and slave and sector size is queue property.
> 
> BTW, what type of partition table do you have there?

Normal DOS partition, with 512 byte block size, as this is 512B block
device, at least I believed to it until now. As start=63, it apparently
also handles 1024B requests on odd address (I believe that sfdisk -d dumps
start 0-based).

# partition table of /dev/hdc
unit: sectors

/dev/hdc1 : start=       63, size=12685617, Id=83, bootable
/dev/hdc2 : start=        0, size=       0, Id= 0
/dev/hdc3 : start=        0, size=       0, Id= 0
/dev/hdc4 : start=        0, size=       0, Id= 0

                                                      Petr Vandrovec
                                                      
                                                            
