Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267423AbSLLFnv>; Thu, 12 Dec 2002 00:43:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267424AbSLLFnv>; Thu, 12 Dec 2002 00:43:51 -0500
Received: from h80ad2794.async.vt.edu ([128.173.39.148]:24960 "EHLO
	turing-police.cc.vt.edu") by vger.kernel.org with ESMTP
	id <S267423AbSLLFnt>; Thu, 12 Dec 2002 00:43:49 -0500
Message-Id: <200212120551.gBC5p8k7002633@turing-police.cc.vt.edu>
X-Mailer: exmh version 2.5 07/13/2001 with nmh-1.0.4+dev
To: Doug Ledford <dledford@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.50 - sound driver issues with i810_audio 
In-Reply-To: Your message of "Wed, 11 Dec 2002 17:59:28 EST."
             <20021211225928.GC6513@redhat.com> 
From: Valdis.Kletnieks@vt.edu
References: <200212092124.gB9LOL3J007516@turing-police.cc.vt.edu>
            <20021211225928.GC6513@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_902682968P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Transfer-Encoding: 7bit
Date: Thu, 12 Dec 2002 00:51:08 -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--==_Exmh_902682968P
Content-Type: text/plain; charset=us-ascii

On Wed, 11 Dec 2002 17:59:28 EST, Doug Ledford said:

> This sounds like the problem some chipsets had with wrapping counters in 
> the dma pointer read code.  Basically, when the sg segment is advanced to 
> the next segment, the offset counter would not be simultaneously cleared 
> but instead would be momentarily delayed before the clear occured and a 
> read at just the wrong time could result in us thinking that the buffer 
> was a full sg segment farther than it was.  There were changes made to the 
> oss i810 driver around version 0.18 to solve this problem if I remember 
> correctly.  Similar code may be needed in the alsa driver, I'm not sure 
> because I have looked at it or tried it (my machine with an i810 doesn't 
> run 2.5 kernels).

Ahh... That would exactly explain what I was seeing, and why it worked under
2.4.18 for me, and gives me a good idea where to look (the relevant code in the
alsa and oss drivers is pretty similar, there's only so many ways to code a
ring buffer when the other part is cast in silicon. ;)

/Valdis


--==_Exmh_902682968P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)
Comment: Exmh version 2.5 07/13/2001

iD8DBQE9+CPLcC3lWbTT17ARApG4AKCwxOQr4RzFkw9yZ3/1mKbbZvioKwCeP6ne
OiSR3or7ERGzmhrXPBDekDg=
=VrFk
-----END PGP SIGNATURE-----

--==_Exmh_902682968P--
