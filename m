Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261861AbTJGGDL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Oct 2003 02:03:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261863AbTJGGDL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Oct 2003 02:03:11 -0400
Received: from h80ad25f1.async.vt.edu ([128.173.37.241]:17806 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S261861AbTJGGDI (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 7 Oct 2003 02:03:08 -0400
Message-Id: <200310070603.h97631Yl011804@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Daniel B." <dsb@smart.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Whynot re-do failed op? 
In-Reply-To: Your message of "Tue, 07 Oct 2003 01:24:19 EDT."
             <3F824E03.C309F2BE@smart.net> 
From: Valdis.Kletnieks@vt.edu
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com> <3F81CE9A.851806B8@smart.net> <200310062045.h96KjxJP008005@turing-police.cc.vt.edu> <3F81D995.D9C13F33@smart.net> <3F81DE1D.6070304@pobox.com>
            <3F824E03.C309F2BE@smart.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_867867771P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 07 Oct 2003 02:03:01 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_867867771P
Content-Type: text/plain; charset=us-ascii

On Tue, 07 Oct 2003 01:24:19 EDT, "Daniel B." said:

> So if some command/batch/etc. wasn't acknowledged, why can't the 
> kernel retry the command/batch/etc.?

The problem is that the disk ack'ed the command when the block went into the
write cache.  You *DONT* in general get back another ack when the block
actually hits the platters.

> Given the serious of disk data corruption, why isn't the Linux kernel
> more reliable here?  Hasn't this family of IDE problems been around
> for a couple of years now?

It's hard for the kernel to be more reliable unless you just disable the write cache.

The biggest reason we don't see more issues like this is that the average MTBF
really is up in the 100K hours and up range, and most drives probably get
around to actually writing all the blocks out every minute or so - so you're
looking at literally a 1 in a million shot at corruption.  Most of the time,
it's writing back in-order enough that no badness happens - and with the rise
of journaled file systems like ext3 and jfs and resierfs, the chance of
actually getting bit by it drops even more (you'd have to hit a case where the
blocks were re-ordered *and* the corresponding journal blocks didn't get
written either).

Yes, this family of problems has been around ever since write caches were
introduced. It's just taken until now that we've got file system code that's
rock solid enough that the write cache is a major reliability issue - for the
longest time, one kernel bug or another has been more of a concern.
See the IDE corruption in early 2.5 kernels that scared a LOT of people
away - I believe that one was done all by the kernel, without any help
from the disk's write cache. ;)

--==_Exmh_867867771P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/glcVcC3lWbTT17ARAnUrAJwLpEfIrEwxTAZ7dxngdkdH2ppeTwCcD9Zp
DUtumwT88NBupkkCS4n1sI4=
=3U17
-----END PGP SIGNATURE-----

--==_Exmh_867867771P--
