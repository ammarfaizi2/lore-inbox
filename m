Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275826AbRJKBtB>; Wed, 10 Oct 2001 21:49:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275570AbRJKBsp>; Wed, 10 Oct 2001 21:48:45 -0400
Received: from roc-24-169-102-121.rochester.rr.com ([24.169.102.121]:51614
	"EHLO roc-24-169-102-121.rochester.rr.com") by vger.kernel.org
	with ESMTP id <S275841AbRJKBsc>; Wed, 10 Oct 2001 21:48:32 -0400
Date: Wed, 10 Oct 2001 21:48:41 -0400
From: Chris Mason <mason@suse.com>
To: Richard Gooch <rgooch@ras.ucalgary.ca>,
        Andreas Dilger <adilger@turbolabs.com>
cc: Doug McNaught <doug@wireboard.com>,
        Lew Wolfgang <wolfgang@sweet-haven.com>, linux-kernel@vger.kernel.org
Subject: Re: Dump corrupts ext2?
Message-ID: <1160370000.1002764921@tiny>
In-Reply-To: <200110110133.f9B1XtN28012@vindaloo.ras.ucalgary.ca>
In-Reply-To: <Pine.LNX.4.33.0110101558210.7049-100000@train.sweet-haven.com><m3elob3xao.fsf@belphigor.mcnaught.org><20011010173449.Q10443@turbolinux.com> <200110110133.f9B1XtN28012@vindaloo.ras.ucalgary.ca>
X-Mailer: Mulberry/2.1.0 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Wednesday, October 10, 2001 07:33:55 PM -0600 Richard Gooch <rgooch@ras.ucalgary.ca> wrote:

> Andreas Dilger writes:

>> In Linus kernels 2.4.11+ the block devices and filesystems all use
>> the page cache, so no more coherency issues.
> 
> Um, I thought that there wasn't going to be coherency? For example, if
> you open /dev/sda and /dev/sda1, they each have a separate cache. I
> remember some debate about this, and Linus pointed out how hard it was
> to make things coherent.

They all use the page cache, but they still use different address spaces.

The block device and getblk share the same address space, so the metadata
and the block device are on the same cache, except for ext2 directories,
which act like files do.  Each file has its own address space, so that
isn't coherent with the block device.

In other words, block device reads with the FS mounted will probably
never give consistent results.

The bug where dump could corrupt things was when getblk and the
block device both used the buffer cache.  That issue hasn't changed.

-chris

