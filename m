Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313070AbSF2QpZ>; Sat, 29 Jun 2002 12:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313181AbSF2QpZ>; Sat, 29 Jun 2002 12:45:25 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:10485 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S313070AbSF2QpY>; Sat, 29 Jun 2002 12:45:24 -0400
Date: Sat, 29 Jun 2002 18:47:41 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Jakob Kemi <jakob.kemi@telia.com>
cc: Rolf Fokkens <fokkensr@linux06.vertis.nl>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] [2.4.19-rc1] w9966 doesn't compile
In-Reply-To: <200206291255.g5TCtnH25982@d1o849.telia.com>
Message-ID: <Pine.NEB.4.44.0206291843040.10459-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 29 Jun 2002, Jakob Kemi wrote:

> Hi Rolf and Adrian!

Hi Jakob,

> > > While trying to compile 2.4.19-rc1 the following error occurs:
> > >
> > > w9966.c:68: warning: invalid character in macro parameter name
> > > w9966.c:68: badly punctuated parameter list in `#define'
>...
> > You are using egcs?
> >
> > It seems egcs can't handle the following in lines 68-69:
> >
> > <--  snip  -->
> >
> > ...
> > #   define DPRINTF(...) do {} while(0)
> > #   define DASSERT(...) do {} while(0)
> > ...
> >
> > <--  snip  -->
> >
> >
> > Since egcs is a supported compiler someone should fix this before
> > 2.4.19-final comes out.
>...
> Unfortunatley I don't have egcs handy. Would this be a fix for egcs?
>
> --- w9966.c.orig	Sat Jun 29 14:23:41 2002
> +++ w9966.c	Sat Jun 29 14:50:21 2002
> @@ -65,8 +65,8 @@
>  			DPRINTF("Assertion failed at line %d.\n", __LINE__);\
>  	} while (0)
>  #else
> -#   define DPRINTF(...) do {} while(0)
> -#   define DASSERT(...) do {} while(0)
> +#   define DPRINTF(f, a...) do {} while(0)
> +#   define DASSERT(f, a...) do {} while(0)
>  #endif
>
>  /*


yes, this patch fixes the compilation for egcs.


> Regards,
> 	Jakob


Thanks for your fast response and patch
Adrian


--- drivers/media/video/w9966.c.old	Sat Jun 29 18:43:39 2002
+++ drivers/media/video/w9966.c	Sat Jun 29 18:43:42 2002
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

