Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271800AbRJJAo5>; Tue, 9 Oct 2001 20:44:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271741AbRJJAor>; Tue, 9 Oct 2001 20:44:47 -0400
Received: from mercury.ccmr.cornell.edu ([128.84.231.97]:63750 "EHLO
	mercury.ccmr.cornell.edu") by vger.kernel.org with ESMTP
	id <S271800AbRJJAoe>; Tue, 9 Oct 2001 20:44:34 -0400
From: Daniel Freedman <freedman@ccmr.cornell.edu>
Date: Tue, 9 Oct 2001 20:45:05 -0400
To: linux-kernel@vger.kernel.org
Cc: Daniel Freedman <freedman@ccmr.cornell.edu>
Subject: Re: 'set_blocksize' & 'nr_blocks changed' during Raid1 mount... (more info)
Message-ID: <20011009204505.D15093@ccmr.cornell.edu>
In-Reply-To: <20011009181319.C15093@ccmr.cornell.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <20011009181319.C15093@ccmr.cornell.edu>; from freedman@ccmr.cornell.edu on Tue, Oct 09, 2001 at 06:13:20PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 09, 2001, Daniel Freedman wrote:
> 
> Hi,
> 
> I'm looking for clarification on the following kernel messages that I
> received during a mount of a recently-created raid1 device.  I'm using
> a 2.2.19 kernel (close to stock, actually Debian's Potato kernel,
> which is stock +~ BigPhysArea patch), which I've then patched with
> Ingo Molnar's 0.90 RAID layer (I used the correct 2.2.19 patches).
> 
> Here's what I did to create the /dev/md0 device:
> 
> # partition /dev/sda5 and /dev/sdb5 to participate in raid1
> # create appropriate /etc/raidtab (listed at end of email)
> mkraid /dev/md0
> # following commands were executing while partitions were
> # still re-syncing (if that's relevant)
> mke2fs /dev/md0
> # /dev/md0 is configured as /home as listed in fstab (at end of email)
> mount /home
> 
> I then received the following kernel messages on mounting /dev/md0:
> 
> Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058688, from 00000900
> Oct  9 15:56:49 newton kernel: set_blocksize: b_count 1, dev md(9,0), block 31058692, from 00000900
>  <snip>
> Oct  9 15:56:49 newton kernel: set_blocksize: b_count 2, dev md(9,0), block 31058815, from 00000900
> Oct  9 15:56:49 newton kernel: md0: blocksize changed during read
> Oct  9 15:56:49 newton kernel: nr_blocks changed to 32 (blocksize 4096, j 7764672, max_blocks 15868160)
> 
> Interestingly enough, I now no longer get any kernel messages when I
> mount or unmount the raid1 partition.  Could this possibly be because
> md0's no longer in the resync process?  I did a linux-kernel and


(responding to my own message):
Hi,

I experimented further with mounting my raid1 partitions during the
resync process (this is allowed, according to the linuxdoc HOWTO) and
I receive the above kernel messages whenever I do so.  I've not yet
ever seen these messages on mounting one of my raid1 partitions when
it is not resyncing.

I'd be happy to try further suggestions to give additional info.

Thanks so much,

Daniel



> Thanks,
> Daniel
> 
> ps: kindly cc me on replies if possible.
> 

-- 
Daniel A. Freedman
Laboratory for Atomic and Solid State Physics
Department of Physics
Cornell University
