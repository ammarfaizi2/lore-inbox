Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267687AbTAHFtN>; Wed, 8 Jan 2003 00:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267690AbTAHFtN>; Wed, 8 Jan 2003 00:49:13 -0500
Received: from adsl-67-121-154-100.dsl.pltn13.pacbell.net ([67.121.154.100]:4832
	"EHLO localhost") by vger.kernel.org with ESMTP id <S267687AbTAHFtM>;
	Wed, 8 Jan 2003 00:49:12 -0500
Date: Tue, 7 Jan 2003 21:56:30 -0800
From: Joshua Kwan <joshk@ludicrus.ath.cx>
To: dhinds@sonic.net
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.5.54-dj1-bk] Some interesting experiences...
Message-Id: <20030107215630.6f8bd876.joshk@ludicrus.ath.cx>
In-Reply-To: <20030107204303.2dd901ca.joshk@ludicrus.ath.cx>
References: <20030107172147.3c53efa8.joshk@ludicrus.ath.cx>
	<20030107175801.A23794@sonic.net>
	<20030107204303.2dd901ca.joshk@ludicrus.ath.cx>
X-Mailer: Sylpheed version 0.8.8claws65 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="pgp-sha1"; boundary="=.PltjiIf2sJljfy"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.PltjiIf2sJljfy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Ok, the problem is with scsi.h.
In a typedef for SCSI LUNs 'u8' is used, but not defined - either
'typedef u_int8_t u8' outside of the struct, or changing the
declaration to u_int8_t works. Thanks Misha...

Not sure whose repository this bug belongs to, it's either
linux-dj/linux-2.5 or linux/linux-2.5. The error is at line 185 of
scsi.h.

Regards
Josh

Rabid cheeseburgers forced Joshua Kwan<joshk@ludicrus.ath.cx> to write
this on Tue, 7 Jan 2003 20:43:03-0800:	

> No, it's not fixed...
> 
> joshk@fuuma:~/pcmcia-cs-3.2.4$ make all
> cc  -MD -O3 -Wall -Wstrict-prototypes -pipe -Wa,--no-warn
> -I../include/static -I/usr/src/linux-2.5/include -I../include
> -I../modules -c cardmgr.c In file included from cardmgr.c:200:
> /usr/src/linux-2.5/include/scsi/scsi.h:185: parse error before "u8"
> /usr/src/linux-2.5/include/scsi/scsi.h:185: warning: no semicolon at
> end of struct or union
> /usr/src/linux-2.5/include/scsi/scsi.h:186: warning: type defaults to
> `int' in declaration of `ScsiLun'
> /usr/src/linux-2.5/include/scsi/scsi.h:186: warning: data
> definition has no type or storage class
> make[1]: *** [cardmgr.o] Error 1
> make[1]: Leaving directory `/home/joshk/pcmcia-cs-3.2.4/cardmgr'
> 
> But is this a problem with scsi.h itself?
> 
> Regards
> Josh
> 
> Rabid cheeseburgers forced dhinds <dhinds@sonic.net> to write this on
> Tue, 7 Jan 2003 17:58:01 -0800:	
> 
> > On Tue, Jan 07, 2003 at 05:21:46PM -0800, Joshua Kwan wrote:
> > 
> > > 2. [linux-2.5] pcmcia-cs 3.2.3 will no longer build: here is the
> > > build log, pertinent details only.
> > > 
> > > cc  -MD -O3 -Wall -Wstrict-prototypes -pipe -Wa,--no-warn
> > > -I../include/static -I/usr/src/linux-2.5/include -I../include
> > > -I../modules -c cardmgr.c
> > > In file included from cardmgr.c:200:
> > > /usr/src/linux-2.5/include/scsi/scsi.h:185: parse error before
> > > "u8"
> > 
> > This should be fixed in the current beta for 3.2.4 available from
> > http://pcmcia-cs.sourceforge.net/ftp/NEW.
> > 
> > -- Dave
> > -
> > To unsubscribe from this list: send the line "unsubscribe
> > linux-kernel" in the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > Please read the FAQ at  http://www.tux.org/lkml/
> > 
> 
> 
> -- 
> Joshua Kwan
> joshk@mspencer.net
> pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
>  
> It's hard to keep your shirt on when you're getting something off your
> chest.
> 


-- 
Joshua Kwan
joshk@mspencer.net
pgp public key at http://joshk.mspencer.net/pubkey_gpg.asc
 
It's hard to keep your shirt on when you're getting something off your
chest. 

--=.PltjiIf2sJljfy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+G72Q6TRUxq22Mx4RAqYNAKCLh10xmlxJbCH2HsDPr9qHH/r9vQCgpSux
ungyRDxnURi1Y3uoXZTMPAU=
=FIOI
-----END PGP SIGNATURE-----

--=.PltjiIf2sJljfy--
