Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267928AbTAHWFh>; Wed, 8 Jan 2003 17:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267932AbTAHWFh>; Wed, 8 Jan 2003 17:05:37 -0500
Received: from mailout10.sul.t-online.com ([194.25.134.21]:36811 "EHLO
	mailout10.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S267928AbTAHWFg>; Wed, 8 Jan 2003 17:05:36 -0500
From: Marc-Christian Petersen <m.c.p@wolk-project.de>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm/slab.c, kernel <2.4.20>
Date: Wed, 8 Jan 2003 23:12:32 +0100
User-Agent: KMail/1.4.3
Cc: markhe@nextd.demon.co.uk, Shangc <shangcs@yahoo.com>
References: <20030108220316.83003.qmail@web10005.mail.yahoo.com>
In-Reply-To: <20030108220316.83003.qmail@web10005.mail.yahoo.com>
Organization: WOLK - Working Overloaded Linux Kernel
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_WO1FUJ41H4WHHM5P7KTC"
Message-Id: <200301082312.32961.m.c.p@wolk-project.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_WO1FUJ41H4WHHM5P7KTC
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

On Wednesday 08 January 2003 23:03, Shangc wrote:

Hi Shangc,

> --- slab.c=092003-02-08 04:26:50.000000000 -0500
> +++ slab.c=092003-02-08 04:26:14.000000000 -0500
> @@ -397,7 +397,7 @@
>  =09=09base =3D sizeof(slab_t);
>  =09=09extra =3D sizeof(kmem_bufctl_t);
>  =09}
> -=09i =3D 0;
> +=09i =3D (wastage - base) / (size + extra);
>  =09while (i*size + L1_CACHE_ALIGN(base+i*extra) <=3D> wastage)
>  =09=09i++;
>  =09if (i > 0)
if you use this you may also want this.

ciao, Marc
--------------Boundary-00=_WO1FUJ41H4WHHM5P7KTC
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="slab-other.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="slab-other.patch"

diff -Naurp a/mm/slab.c b/mm/slab.c
--- a/mm/slab.c	Wed Jul 17 12:25:04 2002
+++ b/mm/slab.c	Wed Jul 17 12:25:04 2002
@@ -399,10 +399,10 @@
 		base = sizeof(slab_t);
 		extra = sizeof(kmem_bufctl_t);
 	}
-	i = 0;
+       i = (wastage - base)/(size + extra);
 	while (i*size + L1_CACHE_ALIGN(base+i*extra) <= wastage)
 		i++;
-	if (i > 0)
+       while (i*size + L1_CACHE_ALIGN(base+i*extra) > wastage)
 		i--;
 
 	if (i > SLAB_LIMIT)

--------------Boundary-00=_WO1FUJ41H4WHHM5P7KTC--


