Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280686AbRKSUvC>; Mon, 19 Nov 2001 15:51:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280684AbRKSUux>; Mon, 19 Nov 2001 15:50:53 -0500
Received: from h24-64-71-161.cg.shawcable.net ([24.64.71.161]:57591 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S280686AbRKSUuq>;
	Mon, 19 Nov 2001 15:50:46 -0500
Date: Mon, 19 Nov 2001 13:50:11 -0700
From: Andreas Dilger <adilger@turbolabs.com>
To: Rogier Wolff <R.E.Wolff@BitWizard.nl>
Cc: Linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: DD-ing from device to device.
Message-ID: <20011119135011.L1308@lynx.no>
Mail-Followup-To: Rogier Wolff <R.E.Wolff@BitWizard.nl>,
	Linux kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <20011119130223.K1308@lynx.no> <200111192013.VAA06391@cave.bitwizard.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.4i
In-Reply-To: <200111192013.VAA06391@cave.bitwizard.nl>; from R.E.Wolff@BitWizard.nl on Mon, Nov 19, 2001 at 09:13:16PM +0100
X-GPG-Key: 1024D/0D35BED6
X-GPG-Fingerprint: 7A37 5D79 BF1B CECA D44F  8A29 A488 39F5 0D35 BED6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 19, 2001  21:13 +0100, Rogier Wolff wrote:
> Andreas Dilger wrote:
> > dd if=/dev/zero of=tt bs=1k count=1 seek=16M
> 
> 
>  /tmp> dd if=/dev/zero of=tt bs=1k count=1 seek=16M
> dd: tt: Invalid argument
> 1+0 records in
> 1+0 records out

Invalid argument is probably from ftruncate.

>  /tmp> dd if=/dev/zero of=tt bs=1k seek=2047k
> 19913+0 records in
> 19912+0 records out
> ^C
>  /tmp> ls -al tt
> ls: tt: Value too large for defined data type
>  /tmp> su
> Password: 
>  /tmp# rm tt
> rm: cannot remove `tt': Value too large for defined data type
>  /tmp# mv tt xx
> mv: tt: Value too large for defined data type
>  /tmp# rm -f tt
> rm: cannot remove `tt': Value too large for defined data type
>  /tmp# dd if=/dev/zero of=uu bs=1k count=2050 seek=2047k
> 2050+0 records in
> 2050+0 records out
>  /tmp# l uu
> ls: uu: Value too large for defined data type
>  /tmp# 

Looks like your fileutils and/or shell and/or glibc are conspiring against
you.

> > Can you test the "dd" above to ensure it works with your tools and the old
> > kernel?  For your next 2.4.14 kernel build, it may be instructive to put
> > a printk() inside the 3 checks in generic_file_write() before it outputs
> > SIGXFSZ, which tells us limit and RLIM_INIFINITY, pos and count, and pos
> > and s_maxbytes are, respectively.  This will also tell us what limit is
> > being hit (although it is most likely a ulimit issue).
> 
> Grmbl...  I'll see what I can do. 

Start by upgrading your tools to largefile aware ones.

Cheers, Andreas
--
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/

