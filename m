Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbTJUCzZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Oct 2003 22:55:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262738AbTJUCzZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Oct 2003 22:55:25 -0400
Received: from h80ad25a4.async.vt.edu ([128.173.37.164]:3968 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S262613AbTJUCzX (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Mon, 20 Oct 2003 22:55:23 -0400
Message-Id: <200310210254.h9L2slUX001593@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Andrew Morton <akpm@osdl.org>
Cc: schlicht@uni-mannheim.de, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       James Simmons <jsimmons@infradead.org>
Subject: Re: 2.6.0-test8-mm1 
In-Reply-To: Your message of "Mon, 20 Oct 2003 18:56:13 PDT."
             <20031020185613.7d670975.akpm@osdl.org> 
From: Valdis.Kletnieks@vt.edu
References: <20031020020558.16d2a776.akpm@osdl.org> <200310201811.18310.schlicht@uni-mannheim.de> <20031020144836.331c4062.akpm@osdl.org> <200310210001.08761.schlicht@uni-mannheim.de> <200310210014.h9L0EZFP003073@turing-police.cc.vt.edu> <20031020172732.6b6b3646.akpm@osdl.org> <200310210046.h9L0kHFg001918@turing-police.cc.vt.edu>
            <20031020185613.7d670975.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_-690250736P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Mon, 20 Oct 2003 22:54:46 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_-690250736P
Content-Type: text/plain; charset=us-ascii

On Mon, 20 Oct 2003 18:56:13 PDT, Andrew Morton said:

> Has anyone tried CONFIG_DEBUG_SLAB and CONFIG_DEBUG_PAGEALLOC, see if that
> turns anything up?

Well, I built two test kernels, which hopefully tell us something.. ;)

1) I did a 'patch -R' and backed out the two fbdev patches - and a -test8-mm1
with them removed boots and runs fine with a framebuffer console.

2) Kernel *with* fbdev patch, but no 'vga=794' parm at boot works OK as well.  So
it can be in the kernel and not used, and works OK.

3) With fbdev patch and DEBUG_SLAB and DEBUG_PAGEALLOC, it got weird.
It booted semi-OK (sort of - some funkyness mounting filesystems) but suffered some
truly horrid bit-droppings as stuff scrolled. Basically, most character cells that were
"blank" had light grey in the top 2 pixes of the cell, and many non-blanks that didn't
have ascenders had them as well.  Not all the pixels were the same grey, either..
Looks like the debugging changed the layout in memory enough for things to almost
work (so less stuff was getting overlaid and we lived longer?), but didn't catch any
memory corruption (or at least neither console nor 'dmesg' saw any messages).

I'm wondering if it's stomping on some memory because the vga=794
parameter tells it to use 1280x1024x16, when the underlying card is really 1600x1200x32? 
(Yes, I know this means the vesa is using a small corner of the card's memory)...

--==_Exmh_-690250736P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/lJ/2cC3lWbTT17ARAth7AJ0bSUNvHSBK0RL9PtuhJNCeSFfnDgCfYByo
J9cgxwsDxMJ7nvqyCyxlZVs=
=PlgF
-----END PGP SIGNATURE-----

--==_Exmh_-690250736P--
