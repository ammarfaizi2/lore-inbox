Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284590AbRLETR0>; Wed, 5 Dec 2001 14:17:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284588AbRLETRS>; Wed, 5 Dec 2001 14:17:18 -0500
Received: from t2.redhat.com ([199.183.24.243]:45562 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S284590AbRLETRE>; Wed, 5 Dec 2001 14:17:04 -0500
Date: Wed, 5 Dec 2001 13:16:59 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Michael Smith" <smithmg@agere.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Unresolved symbol memset
Message-Id: <20011205131659.3af1bafa.reynolds@redhat.com>
In-Reply-To: <00a501c17dbe$7a6fa580$4d129c87@agere.com>
In-Reply-To: <Pine.LNX.4.33L2.0112051024340.22241-100000@dragon.pdx.osdl.net>
	<00a501c17dbe$7a6fa580$4d129c87@agere.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.B/wcCO..sRzKww"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.B/wcCO..sRzKww
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

More important activities lacking, "Michael Smith" <smithmg@agere.com> wrote:

> That particular header is included.  As I mentioned, I am using memset
> in other areas of the code, as well as the same file.  If I take this
> one call out of the source, it compiles, links and I am able to perform
> and insmod correctly.  Below are the headers that are included in the
> file, and the area of the code that is causing the problem.  Let me say
> that the code, even with this particular call in, compiles and links.
> The problem happens when I go to perform the insmod on it.
> 
> #include <memory.h>
> #include <string.h>
> #include "myownheaders.h"
> 
> 
> void myfunction( void *a, int len )
> {
> ....
> Mymemmove() //used because NdisMoveMemory can not be used
> memset( &a->WORD[NUMWORDS-len], 0, len*4);
> ...
> }

Inside a driver (or module) file, any include reference that doesn't begin with
either <linux/foo.h> or <asm/foo.h> should always raise a red flag.  There are
user-land header files ("/usr/include") and kernel header files
("/usr/src/linux/include") and never the twain shall meet.

Mixing includes is always a bad idea.

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- + -- -- -- -- -- -- -- -- -- --
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.B/wcCO..sRzKww
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjwOcq8ACgkQWEn3bOOMcup7sQCdG4Zr4DAMAy5lJ4QvEsy+uHw+
bBMAn1PG7gYvYbIYlLJvRLVsFyNzNvS2
=z9l7
-----END PGP SIGNATURE-----

--=.B/wcCO..sRzKww--

