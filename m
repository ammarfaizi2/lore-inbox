Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279588AbRKFO75>; Tue, 6 Nov 2001 09:59:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279589AbRKFO7v>; Tue, 6 Nov 2001 09:59:51 -0500
Received: from t2.redhat.com ([199.183.24.243]:36341 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S279588AbRKFO7h>; Tue, 6 Nov 2001 09:59:37 -0500
Date: Tue, 6 Nov 2001 08:59:35 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Amit Kulkarni" <amitncsu@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Insmod gives unsresolved symbol
Message-Id: <20011106085935.1888af63.reynolds@redhat.com>
In-Reply-To: <20011106081744.40294.qmail@web12208.mail.yahoo.com>
In-Reply-To: <20011106081744.40294.qmail@web12208.mail.yahoo.com>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.4cvs13 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.n,KHufgQHi5pSy"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.n,KHufgQHi5pSy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It was a dark and stormy night.  Suddenly "Amit Kulkarni" <amitncsu@yahoo.com> wrote:

> Hi 
> 
> I am trying to write a device driver which calls
> certain functions/variables from the kernel 
> (e.g. ipv4_explicit_null from
> /usr/src/linux/net/mpls/mpls_init.c )
> 
> But when I try to insert the module using insmod it
> gives me an error saying unresolved symbol
> ipv4_explicit_null
> 
> thinking the kernel did not export the said symbol  I
> added EXPORT_SYMBOL(ipv4_explicit_null) in the file
> mpls_init.c 
> Now I can see the symbol in System.map
> but my problem still persists. 
> 
> Am I exporting symbols properly or is there anything
> else that needs to be done .

I assume that you're trying to build a module outside the regular kernel build
system.  You can do this if you are carefull.

Look carefully at the symbol in the System.map file.  Is it EXACTLY the
"ipv4_explicit_null" symbol? Are the extra characters after the "...null" part
of the name?  Any extra characters mean that you've got module versioning turned
on in your kernel, so exported symbols have their name mangled somewhat as C++
would do (this is to implement some protection since modules from one kernel
version probably won't work with another kernel version).  The easiest solution
to this is to recompile your kernel with module versioning turned off.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.n,KHufgQHi5pSy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjvn+tcACgkQWEn3bOOMcuqv2gCeL4toevgrtfSydwe76FCi41aD
LcwAniMjbxVEp+Z0v78SHUMJSHZmQb+7
=0iE1
-----END PGP SIGNATURE-----

--=.n,KHufgQHi5pSy--

