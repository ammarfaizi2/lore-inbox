Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964857AbWGSO4i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964857AbWGSO4i (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jul 2006 10:56:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWGSO4h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jul 2006 10:56:37 -0400
Received: from turing-police.cc.vt.edu ([128.173.14.107]:21199 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S964857AbWGSO4h (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jul 2006 10:56:37 -0400
Message-Id: <200607191456.k6JEuW0x004945@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Ian Stirling <tandra@mauve.plus.com>
Cc: yunfeng zhang <zyf.zeroos@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Improvement on memory subsystem
In-Reply-To: Your message of "Wed, 19 Jul 2006 10:18:44 BST."
             <44BDF8F4.30908@mauve.plus.com>
From: Valdis.Kletnieks@vt.edu
References: <4df04b840607180303i3d8c8bd0o4d2a24752ec2e150@mail.gmail.com> <200607181218.k6ICIgeS027067@turing-police.cc.vt.edu>
            <44BDF8F4.30908@mauve.plus.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1153320991_2943P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 19 Jul 2006 10:56:32 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1153320991_2943P
Content-Type: text/plain; charset=us-ascii

On Wed, 19 Jul 2006 10:18:44 BST, Ian Stirling said:

> To paraphrase shakespear - all the world is not a P4 - and all the swap 
> devices are not hard disks.

Been there, done that.  I used to admin a net of Sun 3/50s where /dev/swap
was a symlink to a file on an NFS server, because the "shoebox" local hard
drives for those were so slow that throwing it across the ethernet to a
3/280 with Fujitsu Super-Eagles was faster...

> For example - I've got a 486/33 laptop with 12M RAM that I sometimes use 
> , with swapping to a 128M PCMCIA RAM card that I got from somewhere.

If we go to the effort of writing code that tries to be smart about grouping
swap reads/writes by cost, it's easy enough to flag any sort of ram-disk device
as a 'zero seek time' device.  Remember that I suggested making it dependent
on "how long until the next pass of the elevator" - for a ramdisk that basically
is zero, so the algorithm easily degenerates into "just queue the requests in
expected order you'll need the results".

> 20K instructions wasted on a device with no seek time is just annoying.

On the other hand, how long does it take to move a 4K page across the
PCMCIA interface?  If you're seeing deep queues on it, you may *still*
want to optimize the order of requests...


--==_Exmh_1153320991_2943P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.4 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFEvkgfcC3lWbTT17ARAlz5AJ0emFPMq8xgrD+fOPIWcwsRXzX4zgCeMlYO
cWykv0GtMCKPEDWR4SEvwQ8=
=wuGD
-----END PGP SIGNATURE-----

--==_Exmh_1153320991_2943P--
