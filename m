Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261534AbVDNQ1l@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261534AbVDNQ1l (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Apr 2005 12:27:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbVDNQ1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Apr 2005 12:27:40 -0400
Received: from pne-smtpout2-sn2.hy.skanova.net ([81.228.8.164]:45523 "EHLO
	pne-smtpout2-sn2.hy.skanova.net") by vger.kernel.org with ESMTP
	id S261531AbVDNQ0O convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Apr 2005 12:26:14 -0400
X-Mailer: exmh version 2.7.2 04/02/2003 (gentoo 2.7.2) with nmh-1.1
To: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: DVD writer and IDE support... 
In-reply-to: <20050414143420.GR521@csclub.uwaterloo.ca> 
References: <20050413181421.5C20E240480@latitude.mynet.no-ip.org> <20050413183722.GQ17865@csclub.uwaterloo.ca> <20050413190756.54474240480@latitude.mynet.no-ip.org> <20050413193924.GN521@csclub.uwaterloo.ca> <20050413205949.E987A240480@latitude.mynet.no-ip.org> <20050414124226.GQ521@csclub.uwaterloo.ca> <20050414133523.6D747240480@latitude.mynet.no-ip.org> <20050414143420.GR521@csclub.uwaterloo.ca>
Comments: In-reply-to lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
   message dated "Thu, 14 Apr 2005 10:34:20 -0400."
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Date: Thu, 14 Apr 2005 18:25:39 +0200
From: aeriksson@fastmail.fm
Message-Id: <20050414162539.4F963240480@latitude.mynet.no-ip.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu, Apr 14, 2005 at 03:35:22PM +0200, aeriksson@fastmail.fm wrote:
> Well there is a cdwrite mailing list hosted on lists.debian.org which is
> a great place to figure out what weird errors are and such, and the
> authors of the programs used for writing discs are on thoses lists too,
> so you may want to ask for advice there.
> 
Thanks, I'll get myself onto that list...

> Did you try writing using ide-scsi mode with growisofs ?  Any
> difference?  Does dvd+rw-media return anything with a disc in the drive?
> 
With this array of modules:
sg                     34112  0 
sr_mod                 17700  0 
ide_scsi               15556  0 
scsi_mod              126952  3 sg,sr_mod,ide_scsi
ide_cd                 40004  0 

Where ide_cd was told to ignore hdc (inspired from the dvd+rw-tools 
web), I got this:
tippex root # dvd+rw-mediainfo /dev/sr0
INQUIRY:                [AOPEN   ][DUW1608/ARR     ][A060]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         14h, DVD-RW Sequential
 Media ID:              CMCW02      
 Current Write Speed:   2.0x1385=2770KB/s
 Write Speed #0:        2.0x1385=2770KB/s
GET [CURRENT] PERFORMANCE:
 Write Performance:     2.0x1385=2770KB/s@[0 -> 2298496]
 Speed Descriptor#0:    02/2298496 R@3.3x1385=4617KB/s W@2.0x1385=2770KB/s
READ DVD STRUCTURE[#10h]:
 Media Book Type:       32h, DVD-RW book [revision 2]
 Legacy lead-out at:    2298496*2KB=4707319808
READ DVD STRUCTURE[#0h]:
 Media Book Type:       32h, DVD-RW book [revision 2]
 Last border-out at:    2285854*2KB=4681428992
READ DISC INFORMATION:
 Disc status:           complete
 Number of Sessions:    1
 State of Last Session: complete
 Number of Tracks:      1
READ TRACK INFORMATION[#1]:
 Track State:           complete
 Track Start Address:   0*2KB
 Free Blocks:           0*2KB
 Track Size:            4294770688*2KB
 Last Recorded Address: 2285853*2KB
FABRICATED TOC:
 Track#1  :             14@0
 Track#AA :             14@2298496
 Multi-session Info:    #1@0
READ CAPACITY:          2298496*2048=4707319808

Not sure what it says, but I see one sesssion there. I guess that's 
from my previos burn attempt. I seemed to be successful with:

tippex root # dvd+rw-format -blank /dev/sr0
* DVD±RW/-RAM format utility by <appro@fy.chalmers.se>, version 4.10.
* 4.7GB DVD-RW media in Sequential mode detected.
* blanking |

No errors reported! Now I get:
tippex root # dvd+rw-mediainfo /dev/sr0
INQUIRY:                [AOPEN   ][DUW1608/ARR     ][A060]
GET [CURRENT] CONFIGURATION:
 Mounted Media:         14h, DVD-RW Sequential
 Media ID:              CMCW02      
 Current Write Speed:   2.0x1385=2770KB/s
 Write Speed #0:        2.0x1385=2770KB/s
GET [CURRENT] PERFORMANCE:
 Write Performance:     2.0x1385=2770KB/s@[0 -> 2297888]
 Speed Descriptor#0:    02/2297888 R@3.3x1385=4617KB/s W@2.0x1385=2770KB/s
READ DVD STRUCTURE[#10h]:
 Media Book Type:       32h, DVD-RW book [revision 2]
 Legacy lead-out at:    2298496*2KB=4707319808
READ DVD STRUCTURE[#0h]:
 Media Book Type:       32h, DVD-RW book [revision 2]
 Last border-out at:    2298496*2KB=4707319808
READ DISC INFORMATION:
 Disc status:           blank
 Number of Sessions:    1
 State of Last Session: empty
 Number of Tracks:      1
READ TRACK INFORMATION[#1]:
 Track State:           invisible incremental
 Track Start Address:   0*2KB
 Next Writable Address: 0*2KB
 Free Blocks:           2297888*2KB
 Track Size:            2297888*2KB
READ CAPACITY:          1*2048=2048

... which seems consistent with expectations. Now another try with 
the burner:
tippex root # growisofs -Z /dev/sr0 -R -J /tmp/quilt-0.32/
Executing 'mkisofs -R -J /tmp/quilt-0.32/ | builtin_dd of=/dev/sr0 obs=32k seek=0'
Using SNAPS000.TES;1 for  /tmp/quilt-0.32/test/snapshot.test (snapshot2.test)
/dev/sr0: FEATURE 21h is not on, engaging DAO...
/dev/sr0: reserving 432 block, warning for short DAO recording
/dev/sr0: "Current Write Speed" is 2.0x1385KBps.
:-( unable to WRITE@LBA=0h: Input/output error
:-( attempt to re-run with -dvd-compat -dvd-compat to engage DAO or apply full blanking procedure
:-( write failed: Input/output error

and the kernel log has:
Apr 14 18:12:54 tippex hdc: DMA timeout retry
Apr 14 18:12:54 tippex hdc: timeout waiting for DMA
Apr 14 18:12:54 tippex hdc: ATAPI reset complete
Apr 14 18:13:14 tippex scsi: Device offlined - not ready after error recovery: host 0 channel 0 id 8 lun 0
Apr 14 18:13:14 tippex SCSI error : <0 0 8 0> return code = 0x6000000
Apr 14 18:13:14 tippex scsi0 (8:0): rejecting I/O to offline device


> > I noticed a firmware upgrade on the web page (.exe) will try to
> > get a dos disk running... Sigh...

> It might require windows.  Certainly their firmware updates mostly
> seem to cover 'improved media coverage'.
 
Yep. I get the feeling my media and the drive as-is don't like each
other. What are the chances that the device is faulty but i can still 
blank the media (btw where can I read up on blanking vs. formating?)

> I have only been buying the plextor drives personally, since I have
> never had a problem with a plextor drive yet, and I like not needing
> windows to update the firmware and I find I save time by spending a bit
> more on getting the best hardware I can reasonably afford.
> 
Starting to seem like a wise choice...

> Len Sorensen
> 
/Anders

