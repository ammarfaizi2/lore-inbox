Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291621AbSBTDN5>; Tue, 19 Feb 2002 22:13:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291620AbSBTDNt>; Tue, 19 Feb 2002 22:13:49 -0500
Received: from harv8.fnal.gov ([131.225.235.7]:24336 "EHLO harv8.fnal.gov")
	by vger.kernel.org with ESMTP id <S291614AbSBTDNl>;
	Tue, 19 Feb 2002 22:13:41 -0500
Message-ID: <3C731460.3060607@huhepl.harvard.edu>
Date: Tue, 19 Feb 2002 21:13:37 -0600
From: Joao Guimaraes da Costa <guima@huhepl.harvard.edu>
Organization: Harvard University
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.8) Gecko/20020204
X-Accept-Language: en-us
MIME-Version: 1.0
To: Andreas Dilger <adilger@turbolabs.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: e2fsck compatibility problem with 2.4.17?
In-Reply-To: <3C725D1C.3060001@huhepl.harvard.edu> <20020219141538.G25713@lynx.adilger.int>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have tried what you suggested.

I tried "dd if=/dev/hdX of=/dev/null bs=4k" under kernel 2.4.3 and got:
dd: reading `/dev/hda7': Input/output error
32792+0 records in
32792+0 records out

After doing this I got the following error with dmesg:
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262336end_request: I/O error, dev 03:07 (hda), sector 262336

This was the only disk error and it was there only after the "dd" command.

---
The same "dd" command under kernel 2.4.17 gives a similar error message 
although with a different record number.

dd: reading `/dev/hda7': Input/output error
32772+0 records in
32772+0 records out

The errors from dmesg are below. The "VFS: Disk change detected on 
device ide1(22,0)" error was there before the "dd" command, and it shows 
continuosly:


VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262176end_request: I/O error, dev 03:07 (hda), sector 262176
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262184end_request: I/O error, dev 03:07 (hda), sector 262184
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262192end_request: I/O error, dev 03:07 (hda), sector 262192
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262200end_request: I/O error, dev 03:07 (hda), sector 262200
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262208end_request: I/O error, dev 03:07 (hda), sector 262208
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262216end_request: I/O error, dev 03:07 (hda), sector 262216
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262224end_request: I/O error, dev 03:07 (hda), sector 262224
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262232end_request: I/O error, dev 03:07 (hda), sector 262232
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262240end_request: I/O error, dev 03:07 (hda), sector 262240
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262248end_request: I/O error, dev 03:07 (hda), sector 262248
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262256end_request: I/O error, dev 03:07 (hda), sector 262256
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262264end_request: I/O error, dev 03:07 (hda), sector 262264
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262272end_request: I/O error, dev 03:07 (hda), sector 262272
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262280end_request: I/O error, dev 03:07 (hda), sector 262280
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262288end_request: I/O error, dev 03:07 (hda), sector 262288
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262296end_request: I/O error, dev 03:07 (hda), sector 262296
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262304end_request: I/O error, dev 03:07 (hda), sector 262304
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262312end_request: I/O error, dev 03:07 (hda), sector 262312
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262320end_request: I/O error, dev 03:07 (hda), sector 262320
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262328end_request: I/O error, dev 03:07 (hda), sector 262328
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)
hda: dma_intr: status=0x51 { DriveReady SeekComplete Error }
hda: dma_intr: error=0x40 { UncorrectableError }, CHS=10793/1/175, 
sector=262336end_request: I/O error, dev 03:07 (hda), sector 262336
VFS: Disk change detected on device ide1(22,0)
VFS: Disk change detected on device ide1(22,0)


It is also interesting that with kernel 2.4.3, I only get one error from 
using the "dd" command. The drive makes some noise and then it stops 
with the error above.
Under 2.4.17, it seems that it tries harder and I get more errors. The 
drive stays there making noise. (BTW, the noise is a set of 4 x runck 
plus 4 x ham! It seems each set corresponds to an error on dmesg.)

Also, I do not really understand what the error "VFS: Disk change 
detected on device ide1(22,0)" means.

The results point to a damaged disk, however, it is still interesting 
that this is not detected by e2fsck under the 2.4.3 kernel.
After doing the "dd" command and getting all this errors, I have checked 
the filesystem again with similar results. It is "clean" if running 
kernel 2.4.3!

Thanks,
	-Joao

Andreas Dilger wrote:
> On Feb 19, 2002  08:11 -0600, Joao Guimaraes da Costa wrote:
> 
>>I am having a problem that might be due to an incompatibility between
>>e2fsck and kernel 2.4.17.
>>
>>My machine has a redhat kernel 2.4.3-12 and a kernel 2.4.17 I have 
>>recently built from source.
>>
>>While doing a routine filesystem check at boot time (running kernel 
>>2.4.17), e2fsck found a problem with one of the partitions (I am using 
>>e2fsck 1.25 from the redhat rawhide rpm  e2fsprogs-1.25-2.i386.rpm).
>>
>>I decided not to fix the problem and checked it with a different kernel
>>and version 1.19 of e2fsck. In both cases, the partition was clean.
>>
>>So, I get:
>>
>>kernel     e2fsck    result
>>2.4.17      1.25     problem
>>2.4.3-12    1.25      OK
>>2.4.3-12    1.19      OK
>>
>>Are there any know incompatibilities between kernel 2.4.17 and e2fsck
>>1.25? Right now, I am not sure if the filesystem is damaged or not!
>>
>>The error I get is the following:
>>1) e2fsck gets stuck after only checking 2.5% of the partition. It stays
>>   there for about 5 minutes doing clik-clak noises until starting giving
>>errors
>>2) First error is:
>>Block 32783 - 32791 (attempt to read block from filesystem resulted in
>>short read) while doing inode scan.
>>3) Then in Pass 2:
>>resources in /src/linux-2.4.3/drivers/acpi (1894) has deleted/unused
>>inode 16435.
>>
> 
> Well, this clik-clak noise sounds like a hardware problem.  I don't know
> why it would only show up under 2.4.17 and not 2.4.3.
> 
> Can you try "dd if=/dev/hdX of=/dev/null bs=4k" to see if this completes
> under both kernels?  Any messages in 'dmesg' that look like IDE errors?
> 
> The one thing I also thought of was that kernels 2.4.10+ have the block
> devices in page cache, and some people have problems with ulimits when
> reading >2GB from the device, but that wouldn't affect block 32783...
> 
> Cheers, Andreas
> --
> Andreas Dilger
> http://sourceforge.net/projects/ext2resize/
> http://www-mddsp.enel.ucalgary.ca/People/adilger/
> 
> .
> 
> 



