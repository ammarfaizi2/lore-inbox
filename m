Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317300AbSHAWjw>; Thu, 1 Aug 2002 18:39:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317302AbSHAWjw>; Thu, 1 Aug 2002 18:39:52 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:9732 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S317300AbSHAWjv>;
	Thu, 1 Aug 2002 18:39:51 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alexander Viro <viro@math.psu.edu>
Date: Fri, 2 Aug 2002 00:42:49 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: IDE from current bk tree, UDMA and two channels...
CC: martin@dalecki.de, linux-kernel@vger.kernel.org, mingo@elte.hu
X-mailer: Pegasus Mail v3.50
Message-ID: <CEE6114682@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  1 Aug 02 at 18:39, Alexander Viro wrote:
> On Fri, 2 Aug 2002, Marcin Dalecki wrote:
> 
> > > I'd like to apologize to Ingo, his changes were completely innocent.
> > > Problem was triggered by Al's 'block device size cleanups' (currently
> > > cset 1.403.160.5 on bkbits).
> > > 
> > > Before this change, my system was using 4KB block size when reading
> > > from /dev/hdc1, because of blk_size[][] (which is in 1kB units) of this 
> > > partition was multiple of 2, and so i_size % 4096 was 0.  But after
> > > Al's change partition size is read from gendisk, and not from blk_size,
> > > and gendisk partition size is in 512 bytes units: and, as you can
> > > probably guess, now my partition had i_size % 4096 == 512, and so only
> > > 512 byte block size was choosen. And with 512 bytes block size my
> > > harddisk refuses to cooperate.
> 
> Uh-oh...
> 
> Let me see if I got it straight:
> 
> a) your disk doesn't work with half-Kb requests
> b) you have a partition with odd number of sectors
> c) hardsect_size is set to half-Kb
> d) old code worked since it rounded size to multiple of kilobyte.
> 
> Correct?

Yes, exactly. Replacing disk is not an option...
                                            Petr Vandrovec
                                            
