Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262447AbRENT7C>; Mon, 14 May 2001 15:59:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262455AbRENT6y>; Mon, 14 May 2001 15:58:54 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:40978 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S262447AbRENT6q>; Mon, 14 May 2001 15:58:46 -0400
Message-ID: <3B0038B3.EBB9747A@transmeta.com>
Date: Mon, 14 May 2001 12:57:39 -0700
From: "H. Peter Anvin" <hpa@transmeta.com>
Organization: Transmeta Corporation
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.5-pre1-zisofs i686)
X-Accept-Language: en, sv, no, da, es, fr, ja
MIME-Version: 1.0
To: Jeff Garzik <jgarzik@mandrakesoft.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B002FC6.C0093C18@transmeta.com> <3B0033A4.8BB96F43@mandrakesoft.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> 
> "H. Peter Anvin" wrote:
> > Linus Torvalds has requested a moratorium on new device number
> > assignments. His hope is that a new and better method for device space
> > handing will emerge as a result.
> 
> Here's my suggestion for a solution.
> 
> Once I work through a bunch of net driver problems, I want to release a
> snapshot block device driver (freezes a blkdev in time).  For this, I
> needed a block major.  After hearing about the device number freeze, I
> was wondering if this solution works:
> 
> Register block device using existing API, and obtain a dynamically
> assigned major number.  Export a tiny ramfs which lists all device
> nodes.  Mounted on /dev/snap, /dev/snap/0 would be the first blkdev for
> snap's dynamically assigned major.  (Al Viro said he has skeleton code
> to create such an fs, IIRC)
> 
> This solution
> (a) keeps from grot-ing up /proc even more [I had considered
> proc_mknod() until viro talked me out of it]
> (b) does not require centrally assigned majors and minors.
> (c) does not require devfs.  most distros ship without it afaik, and
> switching to it is not an overnight process, and requires devfsd to be
> useful in the real world.
> 

It does, however, not manage permissions, nor does it provide for a sane
namespace (it exposes too many internal implementation details in the
interface -- in particular, the driver becomes part of the namespace, and
devices move around between drivers regularly.)

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
