Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263403AbTJVCre (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Oct 2003 22:47:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263422AbTJVCre
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Oct 2003 22:47:34 -0400
Received: from h80ad256b.async.vt.edu ([128.173.37.107]:1921 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id S263403AbTJVCrc (ORCPT <RFC822;linux-kernel@vger.kernel.org>);
	Tue, 21 Oct 2003 22:47:32 -0400
Message-Id: <200310220246.h9M2ko08007330@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.6.3 04/04/2003 with nmh-1.0.4+dev
To: Robert Love <rml@tech9.net>
Cc: Thomas Schlichter <schlicht@uni-mannheim.de>,
       James Simmons <jsimmons@infradead.org>,
       Helge Hafting <helgehaf@aitel.hist.no>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.6.0-test8-mm1 
In-Reply-To: Your message of "Tue, 21 Oct 2003 19:27:25 EDT."
             <1066778844.768.348.camel@localhost> 
From: Valdis.Kletnieks@vt.edu
References: <Pine.LNX.4.44.0310212141290.32738-100000@phoenix.infradead.org> <200310220053.13547.schlicht@uni-mannheim.de>
            <1066778844.768.348.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1296134294P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Tue, 21 Oct 2003 22:46:50 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_1296134294P
Content-Type: text/plain; charset=us-ascii

On Tue, 21 Oct 2003 19:27:25 EDT, Robert Love said:
> On Tue, 2003-10-21 at 18:53, Thomas Schlichter wrote:
> 
> > For me the big question stays why enabling the DEBUG_* options results in a
 
> > corrupt cursor and the false dots on the top of each row... (with both 
> > kernels)
> 
> Almost certainly due to CONFIG_DEBUG_SLAB or CONFIG_DEBUG_PAGEALLOC,
> which debug memory allocations and frees.
> 
> Code that commits the usual memory bugs (use-after-free, etc.) will
> quickly die with these set, whereas without them the bug might never
> manifest.

Right.  DEBUG_SLAB and DEBUG_PAGEALLOC will change where things end up in
memory.  The part that *I* was surprised at was that turning them on did *NOT*
make the code quickly die as expected - but it *did* corrupt the on-screen
image.  That's telling me that the DEBUG stuff is setting canaries that end up
in memory locations that the fbdev code thinks are destined for the display
pixels.  (And conversely, that when you build without those two debug options,
that the fbdev code is parking those now not visibly corrupted pixels on top of
somebody's pointer chains and that's where the memory corruption is coming
from.

Or I could just be full of it as usual.. :)

--==_Exmh_1296134294P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE/le+acC3lWbTT17ARAtcVAKD3y/GoHp6q7tQKe814QFnDCZl3igCg5xPR
8P8D3oLqb4ujlZ/UviIzLOw=
=wWFB
-----END PGP SIGNATURE-----

--==_Exmh_1296134294P--
