Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312498AbSF2Mxe>; Sat, 29 Jun 2002 08:53:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312558AbSF2Mxd>; Sat, 29 Jun 2002 08:53:33 -0400
Received: from mailb.telia.com ([194.22.194.6]:48653 "EHLO mailb.telia.com")
	by vger.kernel.org with ESMTP id <S312498AbSF2Mxc>;
	Sat, 29 Jun 2002 08:53:32 -0400
Message-Id: <200206291255.g5TCtnH25982@d1o849.telia.com>
Content-Type: text/plain; charset=US-ASCII
From: Jakob Kemi <jakob.kemi@telia.com>
To: Adrian Bunk <bunk@fs.tum.de>, Rolf Fokkens <fokkensr@linux06.vertis.nl>
Subject: Re: [BUG] [2.4.19-rc1] w9966 doesn't compile
Date: Sat, 29 Jun 2002 14:54:09 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0206260958530.18882-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0206260958530.18882-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 26 June 2002 10:20, Adrian Bunk wrote:
> On Tue, 25 Jun 2002, Rolf Fokkens wrote:
> > Hi!
>
> Hi Rolf!

Hi Rolf and Adrian!

>
> > While trying to compile 2.4.19-rc1 the following error occurs:
> >
> > w9966.c:68: warning: invalid character in macro parameter name
> > w9966.c:68: badly punctuated parameter list in `#define'
> > w9966.c:69: warning: invalid character in macro parameter name
> > w9966.c:69: badly punctuated parameter list in `#define'
> > w9966.c: In function `w9966_init':
> > w9966.c:329: warning: implicit declaration of function `DPRINTF'
> > w9966.c: In function `w9966_setup':
> > w9966.c:432: warning: implicit declaration of function `DASSERT'
> >
> > Relevant config options seem to me:
> >
> > CONFIG_VIDEO_W9966=m
>
> You are using egcs?
>
> It seems egcs can't handle the following in lines 68-69:
>
> <--  snip  -->
>
> ...
> #   define DPRINTF(...) do {} while(0)
> #   define DASSERT(...) do {} while(0)
> ...
>
> <--  snip  -->
>
>
> Since egcs is a supported compiler someone should fix this before
> 2.4.19-final comes out.
>
>
> A solution might be something like the patch below (but I don't know for
> sure whether this is the correct solution):
>
>
> --- drivers/media/video/w9966.c.old	Wed Jun 26 10:08:04 2002
> +++ drivers/media/video/w9966.c	Wed Jun 26 10:12:56 2002
> @@ -65,8 +65,8 @@
>  			DPRINTF("Assertion failed at line %d.\n", __LINE__);\
>  	} while (0)
>  #else
> -#   define DPRINTF(...) do {} while(0)
> -#   define DASSERT(...) do {} while(0)
> +#   define DPRINTF(x...)
> +#   define DASSERT(x...)
>  #endif
>
>  /*


Unfortunatley I don't have egcs handy. Would this be a fix for egcs?

--- w9966.c.orig	Sat Jun 29 14:23:41 2002
+++ w9966.c	Sat Jun 29 14:50:21 2002
@@ -65,8 +65,8 @@
 			DPRINTF("Assertion failed at line %d.\n", __LINE__);\
 	} while (0)
 #else
-#   define DPRINTF(...) do {} while(0)
-#   define DASSERT(...) do {} while(0)
+#   define DPRINTF(f, a...) do {} while(0)
+#   define DASSERT(f, a...) do {} while(0)
 #endif
 
 /*

> > Cheers,
> >
> > Rolf
>
> cu
> Adrian

Regards,
	Jakob

