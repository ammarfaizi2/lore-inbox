Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262417AbRENTgc>; Mon, 14 May 2001 15:36:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262431AbRENTgW>; Mon, 14 May 2001 15:36:22 -0400
Received: from panic.ohr.gatech.edu ([130.207.47.194]:5563 "HELO havoc.gtf.org")
	by vger.kernel.org with SMTP id <S262417AbRENTgJ>;
	Mon, 14 May 2001 15:36:09 -0400
Message-ID: <3B0033A4.8BB96F43@mandrakesoft.com>
Date: Mon, 14 May 2001 15:36:04 -0400
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.5-pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: Re: LANANA: To Pending Device Number Registrants
In-Reply-To: <3B002FC6.C0093C18@transmeta.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. Peter Anvin" wrote:
> Linus Torvalds has requested a moratorium on new device number
> assignments. His hope is that a new and better method for device space
> handing will emerge as a result.

Here's my suggestion for a solution.

Once I work through a bunch of net driver problems, I want to release a
snapshot block device driver (freezes a blkdev in time).  For this, I
needed a block major.  After hearing about the device number freeze, I
was wondering if this solution works:

Register block device using existing API, and obtain a dynamically
assigned major number.  Export a tiny ramfs which lists all device
nodes.  Mounted on /dev/snap, /dev/snap/0 would be the first blkdev for
snap's dynamically assigned major.  (Al Viro said he has skeleton code
to create such an fs, IIRC)

This solution
(a) keeps from grot-ing up /proc even more [I had considered
proc_mknod() until viro talked me out of it]
(b) does not require centrally assigned majors and minors.
(c) does not require devfs.  most distros ship without it afaik, and
switching to it is not an overnight process, and requires devfsd to be
useful in the real world.

-- 
Jeff Garzik      | Game called on account of naked chick
Building 1024    |
MandrakeSoft     |
