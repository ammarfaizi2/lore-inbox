Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280678AbRKSUNj>; Mon, 19 Nov 2001 15:13:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280680AbRKSUNa>; Mon, 19 Nov 2001 15:13:30 -0500
Received: from 59dyn119.com21.casema.net ([213.17.63.119]:59811 "EHLO
	abraracourcix.bitwizard.nl") by vger.kernel.org with ESMTP
	id <S280678AbRKSUNS>; Mon, 19 Nov 2001 15:13:18 -0500
Message-Id: <200111192013.VAA06391@cave.bitwizard.nl>
Subject: Re: DD-ing from device to device.
In-Reply-To: <20011119130223.K1308@lynx.no> from Andreas Dilger at "Nov 19, 2001
 01:02:23 pm"
To: Andreas Dilger <adilger@turbolabs.com>
Date: Mon, 19 Nov 2001 21:13:16 +0100 (MET)
CC: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
        Linux kernel mailing list <linux-kernel@vger.kernel.org>
From: R.E.Wolff@BitWizard.nl (Rogier Wolff)
X-Mailer: ELM [version 2.4ME+ PL60 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Dilger wrote:
> On Nov 19, 2001  18:28 +0100, Rogier Wolff wrote:
> > > There is another report saying 2.4.14
> > > also "Creating partitions under 2.4.14", and I have read several more
> > > recently but am unsure of the exact kernel version.  What fs are you
> > > using, just in case it matters?
> > 
> > ext2. 
> 
> Well, I just tried this on ext2 instead of ext3 (on my 2.4.13 system)
> and it worked fine as a logged-in non-root user (creates a 16GB sparse file):
> 
> dd if=/dev/zero of=tt bs=1k count=1 seek=16M


 /tmp> dd if=/dev/zero of=tt bs=1k count=1 seek=16M
dd: tt: Invalid argument
1+0 records in
1+0 records out
 /tmp> dd if=/dev/zero of=tt bs=1k seek=2047k
19913+0 records in
19912+0 records out
^C
 /tmp> ls -al tt
ls: tt: Value too large for defined data type
 /tmp> su
Password: 
 /tmp# rm tt
rm: cannot remove `tt': Value too large for defined data type
 /tmp# mv tt xx
mv: tt: Value too large for defined data type
 /tmp# rm -f tt
rm: cannot remove `tt': Value too large for defined data type
 /tmp# dd if=/dev/zero of=uu bs=1k count=2050 seek=2047k
2050+0 records in
2050+0 records out
 /tmp# l uu
ls: uu: Value too large for defined data type
 /tmp# 

> Can you test the "dd" above to ensure it works with your tools and the old
> kernel?  For your next 2.4.14 kernel build, it may be instructive to put
> a printk() inside the 3 checks in generic_file_write() before it outputs
> SIGXFSZ, which tells us limit and RLIM_INIFINITY, pos and count, and pos
> and s_maxbytes are, respectively.  This will also tell us what limit is
> being hit (although it is most likely a ulimit issue).

Grmbl...  I'll see what I can do. 

		Rogier. 

-- 
** R.E.Wolff@BitWizard.nl ** http://www.BitWizard.nl/ ** +31-15-2137555 **
*-- BitWizard writes Linux device drivers for any device you may have! --*
* There are old pilots, and there are bold pilots. 
* There are also old, bald pilots. 
