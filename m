Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288668AbSANC1Y>; Sun, 13 Jan 2002 21:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288677AbSANC1O>; Sun, 13 Jan 2002 21:27:14 -0500
Received: from green.csi.cam.ac.uk ([131.111.8.57]:58600 "EHLO
	green.csi.cam.ac.uk") by vger.kernel.org with ESMTP
	id <S288668AbSANC05>; Sun, 13 Jan 2002 21:26:57 -0500
Message-Id: <5.1.0.14.2.20020114022159.03827db0@pop.cus.cam.ac.uk>
X-Mailer: QUALCOMM Windows Eudora Version 5.1
Date: Mon, 14 Jan 2002 02:27:00 +0000
To: Andrew Morton <akpm@zip.com.au>
From: Anton Altaparmakov <aia21@cam.ac.uk>
Subject: Re: Linux 2.4.18pre3-ac1-aia21 (IDE patches)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3C423E13.8A164D72@zip.com.au>
In-Reply-To: <5.1.0.14.2.20020113232757.04f34ec0@pop.cus.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:10 14/01/02, Andrew Morton wrote:
>Anton Altaparmakov wrote:
> >
> > Alan's -ac series is back! To celebrate this I added in the IDE patches and
> > an NTFS update which dramatically reduces the number of vmalloc()s and have
> > posted the resulting (tested) patch (to be applied on top of
> > 2.4.18pre3-ac1) at below URL.
> >
>
>Is that the NTFS code which produces eighty five quintillion warnings
>with the recommended gcc versions? :-)

Huh? You are referring to ntfs tng perhaps? No, this is just a small update 
to the existing ntfs driver (admittedly taken from ntfs tng but this little 
part shouldn't produce any compiler problems AFAIK).

This update makes ntfs use kmalloc instead of vmalloc for <= PAGE_SIZE 
allocations and since the majority of the allocations are <= PAGE_SIZE this 
is both a performance improvement and a decrease of load on the 128MiB 
vmalloc vm area.

There were people who reported problems under load due to failing vmallocs 
and concurrent ldt allocation problems. This patch should address those 
problems.

Best regards,

Anton


-- 
   "I've not lost my mind. It's backed up on tape somewhere." - Unknown
-- 
Anton Altaparmakov <aia21 at cam.ac.uk> (replace at with @)
Linux NTFS Maintainer / WWW: http://linux-ntfs.sf.net/
ICQ: 8561279 / WWW: http://www-stu.christs.cam.ac.uk/~aia21/

