Return-Path: <linux-kernel-owner+w=401wt.eu-S932319AbXAISDj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932319AbXAISDj (ORCPT <rfc822;w@1wt.eu>);
	Tue, 9 Jan 2007 13:03:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932320AbXAISDj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Jan 2007 13:03:39 -0500
Received: from turing-police.cc.vt.edu ([128.173.14.107]:57161 "EHLO
	turing-police.cc.vt.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932319AbXAISDi (ORCPT
	<RFC822;linux-kernel@vger.kernel.org>);
	Tue, 9 Jan 2007 13:03:38 -0500
Message-Id: <200701091803.l09I3INT017978@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.2
To: Jens Axboe <jens.axboe@oracle.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.20-rc3-mm1 - git-block.patch causes hard lockups
In-Reply-To: Your message of "Mon, 08 Jan 2007 09:55:24 +0100."
             <20070108085523.GS11203@kernel.dk>
From: Valdis.Kletnieks@vt.edu
References: <20070104220200.ae4e9a46.akpm@osdl.org> <200701061255.l06CtXJq011249@turing-police.cc.vt.edu>
            <20070108085523.GS11203@kernel.dk>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1168365798_17810P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 09 Jan 2007 13:03:18 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1168365798_17810P
Content-Type: text/plain; charset=us-ascii

On Mon, 08 Jan 2007 09:55:24 +0100, Jens Axboe said:
> On Sat, Jan 06 2007, Valdis.Kletnieks@vt.edu wrote:
> > On Thu, 04 Jan 2007 22:02:00 PST, Andrew Morton said:
> > 
> > > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.20-rc
3/2.6.20-rc3-mm1/
> > 
> > With git-block.patch applied, my system locks up *hard* at system
> > shutdown time - even alt-sysrq doesn't do anything.  Need to do the
> > "power button for 5" stunt to get the system back.
> 
> Does this change anything?
> 
> diff --git a/block/ll_rw_blk.c b/block/ll_rw_blk.c
> index ec40e44..bae57e0 100644
> --- a/block/ll_rw_blk.c
> +++ b/block/ll_rw_blk.c
> @@ -1542,7 +1542,7 @@ static inline void queue_sync_plugs(request_queue_t *q)
>  	 * If the current process is plugged and has barriers submitted,
>  	 * we will livelock if we don't unplug first.
>  	 */
> -	blk_unplug_current();
> +	blk_replug_current_nested();
>  
>  	synchronize_qrcu(&q->qrcu);
>  }

Nope, still hangs exactly the same way.  Maybe I need to get the watchdog
timer stuff working, and see if that can kick the system in a way that
produces a backtrace....

--==_Exmh_1168365798_17810P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFFo9jmcC3lWbTT17ARAoEgAKC9iIgvR5kbeAa3DwO/e10LEdS4tgCfYce8
VQ8LA1TNqUDmrekdRIlq/1E=
=Cd6m
-----END PGP SIGNATURE-----

--==_Exmh_1168365798_17810P--
