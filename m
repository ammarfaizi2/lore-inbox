Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263470AbTJBUec (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 16:34:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263479AbTJBUec
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 16:34:32 -0400
Received: from quake.mweb.co.za ([196.2.45.76]:31159 "EHLO quake.mweb.co.za")
	by vger.kernel.org with ESMTP id S263470AbTJBUea (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 16:34:30 -0400
Date: Thu, 2 Oct 2003 22:35:45 +0200
From: Bongani Hlope <bonganilinux@mweb.co.za>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test6-mm2
Message-Id: <20031002223545.55611ef6.bonganilinux@mweb.co.za>
In-Reply-To: <20031002022341.797361bc.akpm@osdl.org>
References: <20031002022341.797361bc.akpm@osdl.org>
X-Mailer: Sylpheed version 0.9.5claws (GTK+ 1.2.10; i586-mandrake-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="Multipart_Thu__2_Oct_2003_22_35_45_+0200_=.YJ'OLca7lsu)9l"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Multipart_Thu__2_Oct_2003_22_35_45_+0200_=.YJ'OLca7lsu)9l
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

On Thu, 02 Oct 2003 02:23:41 -0700
Andrew Morton <akpm@osdl.org> wrote:

> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0-test6/2.6.0-test6-mm2/
> 
> . A large series of VFS patches from Al Viro which replace usage of
>   file->f_dentry->d_inode->i_mapping with the new file->f_mapping.
> 
>   This is mainly so we can get disk hot removal right.
> 
> . More work on the O_DIRECT-vs-buffered data coherency problem.  It's
>   still not quite there.
> 

-mm1 had a lot of events/0 zombies, and vanilla 2.6.0-test6 does not. I will test -mm2 and let you know how it goes. Alt-SysRq shows this:

events/0      Z 77361907  1834      3          1836  1831 (L-TLB)
c46abfc4 00000046 cf901940 77361907 00000058 c5dfa080 00000011 77361907
       00000058 cf901940 cf901960 00011d32 77361907 00000058 cffeeaf8 00000000
       c5dfa080 00000000 c0124b60 c5dfa080 00000000 00000000 00000000 c01322f0
Call Trace:
 [do_exit+560/1040] do_exit+0x230/0x410
 [<c0124b60>] do_exit+0x230/0x410
 [wait_for_helper+0/224] wait_for_helper+0x0/0xe0
 [<c01322f0>] wait_for_helper+0x0/0xe0
 [kernel_thread_helper+11/12] kernel_thread_helper+0xb/0xc
 [<c010ae5f>] kernel_thread_helper+0xb/0xc

events/0      Z 77F25CBA  1836      3          2189  1834 (L-TLB)
c46bffc4 00000046 cf901940 77f25cba 00000058 c4691940 00000011 77f25cba
       00000058 cf901940 cf901960 000108dc 77f25cba 00000058 cffeeaf8 00000000
       c4691940 00000000 c0124b60 c4691940 00000000 00000000 00000000 c01322f0
Call Trace:
 [do_exit+560/1040] do_exit+0x230/0x410
 [<c0124b60>] do_exit+0x230/0x410
 [wait_for_helper+0/224] wait_for_helper+0x0/0xe0
 [<c01322f0>] wait_for_helper+0x0/0xe0
 [kernel_thread_helper+11/12] kernel_thread_helper+0xb/0xc
 [<c010ae5f>] kernel_thread_helper+0xb/0xc

events/0      Z CF386CA1  2189      3          2191  1836 (L-TLB)
c172ffc4 00000046 c5dfa6b0 cf386ca1 000006f9 c172cce0 00000011 cf386ca1
       000006f9 c5dfa6b0 c5dfa6d0 0001402b cf386ca1 000006f9 cffeeaf8 00000000
       c172cce0 00000000 c0124b60 c172cce0 00000000 00000000 00000000 c01322f0
Call Trace:
 [do_exit+560/1040] do_exit+0x230/0x410
 [<c0124b60>] do_exit+0x230/0x410
 [wait_for_helper+0/224] wait_for_helper+0x0/0xe0
 [<c01322f0>] wait_for_helper+0x0/0xe0
 [kernel_thread_helper+11/12] kernel_thread_helper+0xb/0xc
 [<c010ae5f>] kernel_thread_helper+0xb/0xc

--Multipart_Thu__2_Oct_2003_22_35_45_+0200_=.YJ'OLca7lsu)9l
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/fIwn+pvEqv8+FEMRAvCiAJ0V0D3W4leI/ZrYz4aVDMc0EkJROwCghVAN
VNoCD90kUHoBN/HWXIoW7/o=
=NMG7
-----END PGP SIGNATURE-----

--Multipart_Thu__2_Oct_2003_22_35_45_+0200_=.YJ'OLca7lsu)9l--
