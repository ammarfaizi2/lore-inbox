Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318348AbSH0Cpd>; Mon, 26 Aug 2002 22:45:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318355AbSH0Cpd>; Mon, 26 Aug 2002 22:45:33 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:21511 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S318348AbSH0Cpc>; Mon, 26 Aug 2002 22:45:32 -0400
Date: Tue, 27 Aug 2002 10:49:13 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
Message-ID: <Pine.LNX.4.44.0208271038450.25059-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/27/2002
 10:49:45 AM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/27/2002
 10:49:48 AM,
	Serialize complete at 08/27/2002 10:49:48 AM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Alan,

Who else can help with this problem? I tried to write to Werner
Almesberger <werner.almesberger@epfl.ch> (no such email) and Hans Lermen
<lermen@fgan.de>, but no response from either.

I'm suspecting that somehow part of initrd is being corrupted during boot
up or may be ungzip is not working properly, because I can definitely
gzip/ungzip on all versions of running Linux for the ram.gz filesystem I
created.  Again, the only difference between ram-18mb.gz (6MB) and
ram-24mb.gz (8MB) is ram24.gz contains one extra file to fill up the
filesystem to 90%.

Same bzImage, same ramdisk_size=28000, just different initrd files.
ram-18mb.gz boots, ram-24mb.gz hangs.

gzip 1.3.3

I noticed that lib/inflate.c says gzip is based on gzip-1.0.3

Thanks,
Jeff
[ jchua@fedex.com ]

---------- Forwarded message ----------
Date: Tue, 27 Aug 2002 08:05:14 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption


On 26 Aug 2002, Alan Cox wrote:

> > 	RAMDISK: Compressed image found at block 0 ... then stuck!
> Force a 1K block size when you make the fs

That was the default for mke2fs.

Tried compress instead of gzip. Same problem. I guess the compressed file
is too big for the kernel. The 8MB compressed (from 24MB) didn't work. 6MB
compressed from 18MB worked. The 24MB filesystem has just one extra junk
file in /tmp to fill up the filesystem to 90% and this caused the system
to hang.

I'm thinking it could be the ungzip function in the kernel that's causing
the problem.


Jeff.


