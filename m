Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751095AbWCZHIA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751095AbWCZHIA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 02:08:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751136AbWCZHIA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 02:08:00 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:5314 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S1751095AbWCZHIA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 02:08:00 -0500
Message-Id: <200603260706.k2Q76thB030947@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1-RC3
To: Linda Walsh <lkml@tlinx.org>
Cc: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Block I/O Schedulers: Can they be made selectable/device? @runtime? 
In-Reply-To: Your message of "Sat, 25 Mar 2006 22:41:00 PST."
             <4426377C.7000605@tlinx.org> 
From: Valdis.Kletnieks@vt.edu
References: <4426377C.7000605@tlinx.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1143356815_4291P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Sun, 26 Mar 2006 02:06:55 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1143356815_4291P
Content-Type: text/plain; charset=us-ascii

On Sat, 25 Mar 2006 22:41:00 PST, Linda Walsh said:
> Is it still the case that block I/O schedulers (AS, CFQ, etc.)
> are only selectable at boot time?

Hasn't been for quite some time.  CPU schedulers are stuck at boot time, even
if you have the 'plugsched' patch (and if you don't, you're stuck with the one
scheduler in-tree currently).  There was a patch posted a few days ago
that allowed on-the-fly changing of plugsched, but that's still too bleeding
edge even for me... ;)

> How difficult would it be to allow multiple, concurrent I/O
> schedulers running on different block devices?

>From my /etc/rc.local:

echo cfq > /sys/block/hda/queue/scheduler
echo noop > /sys/block/hdb/queue/scheduler

(hda is a real disk with ext3 partitions on it, hdb is a DVD/CD/RW that almost
always has exactly one process reading or writing to it at a given time, so doing
things in the order requested is just fine).

Simple enough? ;)

(This *does* require that you built more than one scheduler, and possibly
to make sure they're loaded if you managed to build them modular...)

--==_Exmh_1143356815_4291P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEJj2PcC3lWbTT17ARAli1AJ94YSrsQB7UZfFgErq7Hg7wq2KspwCfZ7G4
Eb5HakwjUhEtLo8swxT6pfs=
=czS+
-----END PGP SIGNATURE-----

--==_Exmh_1143356815_4291P--
