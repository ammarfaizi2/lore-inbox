Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315619AbSECJ2d>; Fri, 3 May 2002 05:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315620AbSECJ2c>; Fri, 3 May 2002 05:28:32 -0400
Received: from mole.bio.cam.ac.uk ([131.111.36.9]:48646 "EHLO
	mole.bio.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S315619AbSECJ2a>; Fri, 3 May 2002 05:28:30 -0400
Message-Id: <5.1.0.14.2.20020503101657.041ceab0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Fri, 03 May 2002 10:29:07 +0100
To: Pavel Machek <pavel@ucw.cz>
From: Anton Altaparmakov <aia21@cantab.net>
Subject: Re: kdev_t_to_struct_blockdevice?
Cc: kernel list <linux-kernel@vger.kernel.org>
In-Reply-To: <20020503081432.GA595@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 09:14 03/05/02, Pavel Machek wrote:
>Hi!
>
>How do I do (above)?

include/linux/fs.h declares:

         extern struct block_device *bdget(dev_t).

(you of course need to bdput(struct block_device *) when finished with it)

Along the way you may also need include/linux/kdev_t.h defining:

static inline int kdev_t_to_nr(kdev_t dev)
{
         return MKDEV(major(dev), minor(dev));
}

static inline kdev_t to_kdev_t(int dev)
{
         return mk_kdev(MAJOR(dev),MINOR(dev));
}

Hope this helps.

Best regards,

Anton


>[I really need it for resume; user pases resume=hda3 on command line
>and I need to access that device...]
>                                                                         Pavel
>--
>(about SSSCA) "I don't say this lightly.  However, I really think that the 
>U.S.
>no longer is classifiable as a democracy, but rather as a plutocracy." --hpa
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/

-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cantab.net> (replace at with @)
Linux NTFS Maintainer / IRC: #ntfs on irc.openprojects.net
WWW: http://linux-ntfs.sf.net/ & http://www-stu.christs.cam.ac.uk/~aia21/

