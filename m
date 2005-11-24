Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161004AbVKXFj4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161004AbVKXFj4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 00:39:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030608AbVKXFj4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 00:39:56 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:15371 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S1030607AbVKXFjz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 00:39:55 -0500
Date: Thu, 24 Nov 2005 06:39:52 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Andreas Haumer <andreas@xss.co.at>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.4.31 + aic79xx] SCSI error: Infinite interrupt loop, INTSTAT = 0
Message-ID: <20051124053952.GI11266@alpha.home.local>
References: <43838ECC.5060204@xss.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43838ECC.5060204@xss.co.at>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andreas,

On Tue, Nov 22, 2005 at 10:34:04PM +0100, Andreas Haumer wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> Hi!
> 
> I'm in the process of setting up a new fileserver and
> have some troubles with an Adaptec ASC-29320ALP U320
> SCSI card and an external Infortrend EonStor RAID!
> 
> This is a Tyan TA26 barebone system (dual opteron CPU,
> 4GB RAM) with two on-board AIC-7902B SCSI controllers
> (Tyan Thunder K8SD Pro motherboard) for internal system disks
> (SW-RAID1) and two additional Adaptec 29320ALP U320 cards
> for externally connected RAID (Infortrend EonStor A16U-G2421
> RAID subsystem) and backup hardware.
> 
> I'm running linux-2.4.31 in 32 bit mode.

just for the record, I've checked 2.4.32 and the driver is exactly the
same as in 2.4.31.

> root@setup:~ {521} $ lspci
(...)
> 01:03.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
> 01:04.0 SCSI storage controller: Adaptec ASC-29320ALP U320 (rev 10)
> 02:06.0 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
> 02:06.1 SCSI storage controller: Adaptec AIC-7902B U320 (rev 10)
(...)

I've never tried an adaptec U320 yet, only a few 29160 in various servers.

(...) 
> Today I tried to integrate the external EonStor RAID and first
> it seemd to work fine, too. The system did find the devices
> and I could create a new volume group with several logical
> volumes out of them.
> 
> But as soon as I try to create a filesystem on the new logical
> volumes or do some other work with the devices, the SCSI driver
> goes berserk:

So could we say when you have very low traffic (device identification,
write a few sectors to create the volume), everything's OK, and when
you write larger amounts of data, the problem strikes ?

It may be possible that you have a termination and/or cable problem
and that the driver does not correctly recover from such a condition.

> [...]
> 
> And so on, until the external SCSI devices become unusable.
> The system is still running on the internally connected
> SCSI drives, though.
> 
> I found some messages reporting similar problems on this
> list, a few weeks ago (beginning of October 2005). There
> was also a patch for the aic79xx driver mentioned, but I
> haven't found any report about it since then, so I don't
> know the status of the patch (it was for the 2.6 kernel,
> anyway, as far as I remember)

would you please send a link to this patch, or even the
whole thread if there were responses ?

> What can I do to make the external RAID usable?
> Dump the Adaptec cards and replace them with something better?

I've heard several people tell me that they have no problem with LSI
logic cards, but as I don't have problems either with AIC79xx, I don't
know how that should be interpreted.

> Patch the driver?

There is a large patch from the driver's author on his site. In fact,
it's not really a patch, it's the whole driver directory. I've used
it for a long time now (a few years) in my kernels without any problem.
You may want to try it :

  http://people.freebsd.org/~gibbs/linux/

You can also get it as a patch from my tree :

  http://w.ods.org/kernel/2.4-wt/2.4.31-wt1/patches-2.4.31-wt1/pool/aic79xx-20040522-linux-2.4.30-pre3.rediff

> Any help is appreciated!

good luck !

Regards,
Willy
 
> Thanks!
> 
> - - andreas
> 
> - --
> Andreas Haumer                     | mailto:andreas@xss.co.at
> *x Software + Systeme              | http://www.xss.co.at/
> Karmarschgasse 51/2/20             | Tel: +43-1-6060114-0
> A-1100 Vienna, Austria             | Fax: +43-1-6060114-71
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v1.4.2 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org
> 
> iD8DBQFDg47JxJmyeGcXPhERAmHJAKDDneUcGWBG/DO6BmErT+EFm3WDUgCfYrW7
> jjGW+en9tiILjo5XhcFa5Cc=
> =GR+f
> -----END PGP SIGNATURE-----
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
