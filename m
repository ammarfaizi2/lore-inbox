Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261151AbVBFLAk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261151AbVBFLAk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Feb 2005 06:00:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261179AbVBFLAk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Feb 2005 06:00:40 -0500
Received: from web26501.mail.ukl.yahoo.com ([217.146.176.38]:30878 "HELO
	web26501.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S261162AbVBFLAB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Feb 2005 06:00:01 -0500
Message-ID: <20050206105958.42872.qmail@web26501.mail.ukl.yahoo.com>
Date: Sun, 6 Feb 2005 10:59:58 +0000 (GMT)
From: Neil Conway <nconway_kernel@yahoo.co.uk>
Subject: Re: 3TB disk hassles
To: 7eggert@gmx.de, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Argh...

--- Neil Conway <nconway_kernel@yahoo.co.uk> wrote:
> Hi...
> 
> --- Bodo Eggert <7eggert@gmx.de> wrote:
> > No common x86 BIOS can understand any partition table. Booting is
> > done by
> > loading the first sector of the boot device and executing it. The
> > common
> 
> D'oh!!  Red-face here.  Can't believe my brainlessness.
> Thanks for putting me straight - that explains a lot.  Now to try it
> ;-)

Ah, if only it was that simple.

Since writing the above, I've been searching for more info.  I
downloaded four different versions of grub (GNU Grub Legacy, GNU Grub2,
gentoo and Fedora Core 3).  NONE of these showed any evidence of GPT
support (I was in a hurry, so I searched for strings EFI, GUID, GPT,
TB).

Mucho confused puppy here.

I fail to see how grub can work on a GPT boot device if it can't parse
the partition table.  I conclude that I'm still missing something. 
Perhaps a layer before grub is supposed to parse the GPT instead?  If
so, isn't that getting us straight back to a GPT-aware BIOS?

Tell me if this logic is broken: even if a special boot sector is used,
which IS GPT-aware (though fitting that into the boot sector would be a
challenge ;-)), once grub loads, it's still going to have to figure out
how to find the root(hdX,Y) partition from which to load the kernel
image.  This surely means it has to have either a GPT-parser
internally, or rely on a pre-parsed list.  No?

Perhaps one of the other several distros (that I didn't check) has a
GPT-aware grub.  But Tomas Carnecky said early in this thread that
gentoo had allowed him to set up a GPT-booting system on x86.  I guess
it's possible that a cheat was used - maybe an old-style partition
table in the MBR was used to define the first (boot) partition, but
surely that's forbidden by the whole EFI spec anyway?

Andries Brouwer kindly wrote a patch which I haven't had time to test
yet (see earlier in thread).  While it would be nice to find a way
around the problem which didn't require deviations from vanilla
distros, I think Andries' patch is looking like the only sane fix right
now.

Anyone with a definitive answer to the question "can I use GPT on a
vanilla x86 mobo", do speak up :-)

Regards,
Neil
PS: I really didn't think that >2TiB disks were quite so far out on the
bleeding edge :-/



		
__________________________________ 
Do you Yahoo!? 
Meet the all-new My Yahoo! - Try it today! 
http://my.yahoo.com 
 

