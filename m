Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266528AbRGGVk7>; Sat, 7 Jul 2001 17:40:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265431AbRGGVks>; Sat, 7 Jul 2001 17:40:48 -0400
Received: from barbados.bluemug.com ([63.195.182.101]:19460 "EHLO
	barbados.bluemug.com") by vger.kernel.org with ESMTP
	id <S262288AbRGGVkc>; Sat, 7 Jul 2001 17:40:32 -0400
Date: Sat, 7 Jul 2001 14:40:32 -0700
To: linux-kernel@vger.kernel.org
Subject: Re: [Acpi] Re: ACPI fundamental locking problems
Message-ID: <20010707144032.C19529@mayotte>
Mail-Followup-To: miket, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33.0107040956310.1668-100000@penguin.transmeta.com> <9i6oga$jk1$1@pccross.average.org> <3B46F3CE.9002ABAB@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3B46F3CE.9002ABAB@mandrakesoft.com>
X-PGP-ID: 5C09BB33
X-PGP-Fingerprint: C518 67A5 F5C5 C784 A196  B480 5C97 3BBD 5C09 BB33
From: Mike Touloumtzis <miket@bluemug.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jul 07, 2001 at 07:34:38AM -0400, Jeff Garzik wrote:
> Eugene Crosser wrote:
> > 
> > Doesn't the approach "treat a chunk of data built into bzImage as
> > populated ramfs" look cleaner?  No need to fiddle with tar format,
> > no copying data from place to place.
> 
> So tell me, how do you populate ramfs without a format which tells you
> what path and which permissions to assign each file?  That's exactly
> what tar is.

Would it be possible to use a cramfs image in vmlinux (i.e. real
filesystem image, not an in-kernel-structures fs like ramfs), and map
it directly from the kernel image (it would have to be suitably aligned,
of course)?

This would allow demand paging of files in the image (not too important
for a minimal boot fs, admittedly), and would allow text pages to be
dropped under VM pressure (nice for a fs which holds substantial amounts
of boot-time-only code).

miket
