Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136327AbRD2UYw>; Sun, 29 Apr 2001 16:24:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136330AbRD2UYo>; Sun, 29 Apr 2001 16:24:44 -0400
Received: from 13dyn119.delft.casema.net ([212.64.76.119]:58117 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S136299AbRD2UXO>; Sun, 29 Apr 2001 16:23:14 -0400
Message-Id: <200104292023.WAA25257@cave.bitwizard.nl>
Subject: Re: Sony Memory stick format funnies...
In-Reply-To: <20010429161544.A17539@xi.linuxpower.cx> from Gregory Maxwell at
 "Apr 29, 2001 04:15:44 pm"
To: Gregory Maxwell <greg@linuxpower.cx>
Date: Sun, 29 Apr 2001 22:23:06 +0200 (MEST)
CC: "H. Peter Anvin" <hpa@transmeta.com>,
        Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Gregory Maxwell wrote:
> On Sun, Apr 29, 2001 at 01:09:22PM -0700, H. Peter Anvin wrote:
> > Rogier Wolff wrote:
> > > 
> > > H. Peter Anvin wrote:
> > > > Followup to:  <200104282236.AAA06021@cave.bitwizard.nl>
> > > > By author:    R.E.Wolff@BitWizard.nl (Rogier Wolff)
> > > > In newsgroup: linux.dev.kernel
> > > > >
> > > > > # l /mnt/d1
> > > > > total 16
> > > > > drwxr-xr-x 512 root     root        16384 Mar 24 17:26 dcim/
> > > > > -r-xr-xr-x   1 root     root            0 May 23  2000 memstick.ind*
> > > > > #
> > > > >
> > > > > Where the *(&#$%& does that "dcim" directory come from????
> > > > >
> > > >
> > > > "dcim" probably stands for "digital camera images".  At least Canon
> > > > digital cameras always put their data in a directory named dcim.
> > > 
> > > Yes. I know. Seems to be standard. The stick is for my Sony camera.
> > > 
> > > However, the question is: how in **** is the Linux kernel seeing that
> > > directory while it's not on the stick? (the root directory has one
> > > MEMSTICK.IND file, and nothing else!)
> > > 
> > 
> > I doubt the kernel is seeing it without it being there (it doesn't have
> > much imagination.)  However, it may very well be there in a funny
> > manner.  You do realize, of course, that it's pretty much impossible for
> > us to help you answer that question without a complete dump of the
> > filesystem on hand, I hope?
> 
> He gave what he thought was a complete dump of the non-null bytes. The
> obvious answer is that he's looking wrong. :)

You think the kernel decodes the 1bit per 16 bytes into a "dcim"
directory? (I filtered out both the lines with 16 0xff bytes as well
as those with 16 0x00 bytes. That leaves one bit per 16 bytes that I
didn't show in that Email)

Feel free to tell me what I'm doing wrong.... I'd like to know. I
could hack the kernel to hexdump the blocks it gets from the disk. I
know I can. I was hoping the linux-kernel crew would be able to tell
me something obvious I was missing or that we're on to something
odd...)

			Roger. 


% hd /dev/hde | grep -v "ff ff ff ff ff ff ff ff   ff ff ff ff ff ff ff ff" | grep -v "00 00 00 00 00 00 00 00   00 00 00 00 00 00 00 00"
001b0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 80 02 ................
001c0  08 00 01 07 d0 dd 27 00   00 00 d9 ee 01 00 00 00 ....P]'...Yn....
001f0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa ..............U*
04e00  e9 00 00 20 20 20 20 20   20 20 20 00 02 20 01 00 i..        .. ..
04e10  02 00 02 00 00 f8 0c 00   10 00 08 00 27 00 00 00 .....x......'...
04e20  d9 ee 01 00 00 00 29 00   00 00 00 00 00 00 00 00 Yn....).........
04e30  00 00 00 00 00 00 46 41   54 31 32 20 20 20 00 00 ......FAT12   ..
04ff0  00 00 00 00 00 00 00 00   00 00 00 00 00 00 55 aa ..............U*
05000  f8 ff ff 00 00 00 00 00   00 00 00 00 00 00 00 00 x...............
06800  f8 ff ff 00 00 00 00 00   00 00 00 00 00 00 00 00 x...............
08000  4d 45 4d 53 54 49 43 4b   49 4e 44 03 00 00 00 00 MEMSTICKIND.....
08010  00 00 00 00 00 00 4f 4c   b7 28 00 00 00 00 00 00 ......OL7(......
% 


-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
