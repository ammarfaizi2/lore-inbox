Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266097AbUAUTUt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Jan 2004 14:20:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266099AbUAUTUt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Jan 2004 14:20:49 -0500
Received: from [128.173.54.129] ([128.173.54.129]:6528 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S266097AbUAUTUr (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Wed, 21 Jan 2004 14:20:47 -0500
Message-Id: <200401211920.i0LJKZ2a003504@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: "Prakash K. Cheemplavam" <PrakashKC@gmx.de>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: 2.6.1-mm4 
In-Reply-To: Your message of "Wed, 21 Jan 2004 19:46:32 +0100."
             <400EC908.4020801@gmx.de> 
From: Valdis.Kletnieks@vt.edu
References: <20040115225948.6b994a48.akpm@osdl.org> <4007B03C.4090106@gmx.de>
            <400EC908.4020801@gmx.de>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_668682134P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Wed, 21 Jan 2004 14:20:35 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_668682134P
Content-Type: text/plain; charset=us-ascii

On Wed, 21 Jan 2004 19:46:32 +0100, "Prakash K. Cheemplavam" said:
> Ok, here is the stack backtrace:
> 
> I hope it helps, otherwise I could try compiling in frame-pointers. (I 
> used another logger to get this...)
> 
> Is it nvidia driver doing something bad (which earlier kernels didn't do)?
> 
> Jan 21 19:25:39 tachyon Badness in pci_find_subsys at 
> drivers/pci/search.c:132
> Jan 21 19:25:39 tachyon Call Trace:
> Jan 21 19:25:39 tachyon [<c027a7f8>] pci_find_subsys+0xe8/0xf0
> Jan 21 19:25:39 tachyon [<c027a82f>] pci_find_device+0x2f/0x40
> Jan 21 19:25:39 tachyon [<c027a6e8>] pci_find_slot+0x28/0x50

If this is the NVidia graphics driver, it's been doing it at least since 2.5.6something,
at least that I've seen.  It's basically calling pci_find_slot in an interrupt context,
which ends up calling pci_find_subsys which complains about it.  One possible
solution would be for the code to be changed to call pci_find_slot during module
initialization and save the return value, and use that instead.  Yes, I know this
prevents hotplugging.  Who hotplugs graphics cards? ;)

--==_Exmh_668682134P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQFADtEDcC3lWbTT17ARAkolAKC0Bsttm2gn8U8maWRfuHx2Ji+uCwCeI/Pw
4uUuV6n8lRoncT+qbO7W0Bw=
=j/My
-----END PGP SIGNATURE-----

--==_Exmh_668682134P--
