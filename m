Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280916AbRKOPlz>; Thu, 15 Nov 2001 10:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280915AbRKOPlq>; Thu, 15 Nov 2001 10:41:46 -0500
Received: from t2.redhat.com ([199.183.24.243]:46075 "EHLO
	dhcp-177.hsv.redhat.com") by vger.kernel.org with ESMTP
	id <S280916AbRKOPla>; Thu, 15 Nov 2001 10:41:30 -0500
Date: Thu, 15 Nov 2001 09:41:16 -0600
From: Tommy Reynolds <reynolds@redhat.com>
To: "Jackie Meese" <jackie.m@vt.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 32 Groups Maximum in 2.4
Message-Id: <20011115094116.290282cc.reynolds@redhat.com>
In-Reply-To: <3BF3DF31.4010707@vt.edu>
In-Reply-To: <3BF3DF31.4010707@vt.edu>
Organization: Red Hat Software, Inc. / Embedded Development
X-Mailer: Sylpheed version 0.6.5cvs3 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: Nr)Jjr<W18$]W/d|XHLW^SD-p`}1dn36lQW,d\ZWA<OQ/XI;UrUc3hmj)pX]@n%_4n{Zsg$ t1p@38D[d"JHj~~JSE_udbw@N4Bu/@w(cY^04u#JmXEUCd]l1$;K|zeo!c.#0In"/d.y*U~/_c7lIl 5{0^<~0pk_ET.]:MP_Aq)D@1AIQf.juXKc2u[2pSqNSi3IpsmZc\ep9!XTmHwx
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 boundary="=.gdR0q3llCwJpPR"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--=.gdR0q3llCwJpPR
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

It was a dark and stormy night.  Suddenly
"Jackie Meese" <jackie.m@vt.edu> began to type furiously:

> I've been looking for some time on how to raise the maximum number of 
> groups for the 2.4 kernel.  I've discovered how to do this kernel, with 
> a discussion a few months ago on this 
> list.http://www.cs.helsinki.fi/linux/linux-kernel/2001-13/0807.html
> 
> However the follow up of "You gotta change the task struct..." means 
> nothing to me.
> 
> Can someone be more specific as to the changes that need to be made to 
> accomplish this?  Change the task struct where?  I can find lots of 
> references to task_struct in the sources simply by grepping them, but I 
> can't since any that point to a 32 limit.  I'm not a kernel hacker, but 
> I've read and edited a fair bit of source code in my time, so I thik I 
> just need a bit more of a clue in here.

Look at the file "include/asm-<proc>/param.h to find the symbol "NGROUPS".
Change that to whatever value you like.

The "task_struct" is the per-process descriptor.  You can find it in
"/usr/src/linux/include/linux/sched.h", but you shouldn't need to change
anything there.

Once you've changed "NGROUPS", then "make clean oldconfig dep bzImage modules"
as usual.  That will change the kernel's idea how how many groups you can have. 
You will probably need to recompile the userland stuff, from LIBC to the shells
because "NGROUPS" can be pervasive.

Your mileage may vary.

---------------------------------------------+-----------------------------
Tommy Reynolds                               | mailto: <reynolds@redhat.com>
Red Hat, Inc., Embedded Development Services | Phone:  +1.256.704.9286
307 Wynn Drive NW, Huntsville, AL 35805 USA  | FAX:    +1.256.837.3839
Senior Software Developer                    | Mobile: +1.919.641.2923

--=.gdR0q3llCwJpPR
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)

iEYEARECAAYFAjvz4iAACgkQWEn3bOOMcurvvACcDgS1p72WJOiK79ThunjZL0nu
EfMAmwSyPx86wqpl3YGy9iPbg8OkXaaH
=7f/P
-----END PGP SIGNATURE-----

--=.gdR0q3llCwJpPR--

