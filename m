Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265608AbSLSP1W>; Thu, 19 Dec 2002 10:27:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbSLSP1W>; Thu, 19 Dec 2002 10:27:22 -0500
Received: from linux.kappa.ro ([194.102.255.131]:4775 "EHLO linux.kappa.ro")
	by vger.kernel.org with ESMTP id <S265608AbSLSP1V>;
	Thu, 19 Dec 2002 10:27:21 -0500
Date: Thu, 19 Dec 2002 17:35:16 +0200
From: Teodor Iacob <Teodor.Iacob@astral.kappa.ro>
To: Igmar Palsenberg <i.palsenberg@jdimedia.nl>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Invalidate: busy buffer + MD RAID 1
Message-ID: <20021219153516.GA10968@linux.kappa.ro>
References: <Pine.LNX.4.44.0212181905500.4421-100000@jdi.jdimedia.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0212181905500.4421-100000@jdi.jdimedia.nl>
User-Agent: Mutt/1.3.25i
X-RAVMilter-Version: 8.3.0(snapshot 20011220) (linux)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I get the same behaviour on several machines .. but I sleep well at night :P

On Wed, Dec 18, 2002 at 07:45:00PM +0100, Igmar Palsenberg wrote:
> 
> Hi,
> 
> I get a 'invalidate: busy buffer' about 20 times at reboot. Only at 
> reboot however.
> 
> Setup :
> 
> linux-2.4.19 + grsecurity-1.9.7d + acl+xattr 0.8.53 + freeswan (inc. aes 
> and that kind of stuff)
> 
> The machine (Compaq ML350) has 2 scsi devices (sda, sdb) and a RAID 1 
> setup :
> 
> md0 : sda1 + sdb1
> md1 : sda3 + sdb3
> swap is done on sda2 + sdb2, using default prio's.
> 
> Triggering the 'invalidate: busy buffer' is easiest done by letting squid 
> create it's cache dirs and then rebooting.
> 
> No data corruption is occuring (at last not any that a force fsck can 
> detect), but I removed the RAID1 setup to make sure I sleep well tonight 
> :)
> 
> Looking at the md.c code, line 1708 :
> 
>     ITERATE_RDEV(mddev,rdev,tmp) {
>         if (rdev->faulty)
>             continue;
>         invalidate_device(rdev->dev, 1);
>         if (get_hardsect_size(rdev->dev)
>             > md_hardsect_sizes[mdidx(mddev)])
>             md_hardsect_sizes[mdidx(mddev)] =
>                 get_hardsect_size(rdev->dev);
>     }
> 
> Looks like it is invalidating the underlying devices (sda[13], sdb[13] in 
> my case.
> 
> Since my RAID array doesn't get screwed I suspect that the md code does 
> the above again on a do_md_stop(), but I can't find it.
> 
> Anyone got any comments on this ?? 
> 
> 
> 
> 	Regards,
> 
> 
> 		Igmar
> 
> 
> Please CC all responses.
> 
> 
> 
> -- 
> 
> Igmar Palsenberg
> JDI Media Solutions
> 
> Helhoek 30
> 6923PE Groessen
> Tel: +31 (0)316 - 596695
> Fax: +31 (0)316 - 596699
> The Netherlands
> 
> mailto: i.palsenberg@jdimedia.nl
> PGP/GPG key : http://www.jdimedia.nl/formulier/pgp/igmar
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
      Teodor Iacob,
Network Administrator
Astral TELECOM Internet
