Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316437AbSFZIUX>; Wed, 26 Jun 2002 04:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316446AbSFZIUW>; Wed, 26 Jun 2002 04:20:22 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.176.19]:17650 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id <S316437AbSFZIUV>; Wed, 26 Jun 2002 04:20:21 -0400
Date: Wed, 26 Jun 2002 10:20:19 +0200 (CEST)
From: Adrian Bunk <bunk@fs.tum.de>
X-X-Sender: bunk@mimas.fachschaften.tu-muenchen.de
To: Rolf Fokkens <fokkensr@linux06.vertis.nl>,
       Jakob Kemi <jakob.kemi@telia.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] [2.4.19-rc1] w9966 doesn't compile
In-Reply-To: <200206252154.g5PLsFG11517@linux06.vertis.nl>
Message-ID: <Pine.NEB.4.44.0206260958530.18882-100000@mimas.fachschaften.tu-muenchen.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jun 2002, Rolf Fokkens wrote:

> Hi!

Hi Rolf!

> While trying to compile 2.4.19-rc1 the following error occurs:
>
> w9966.c:68: warning: invalid character in macro parameter name
> w9966.c:68: badly punctuated parameter list in `#define'
> w9966.c:69: warning: invalid character in macro parameter name
> w9966.c:69: badly punctuated parameter list in `#define'
> w9966.c: In function `w9966_init':
> w9966.c:329: warning: implicit declaration of function `DPRINTF'
> w9966.c: In function `w9966_setup':
> w9966.c:432: warning: implicit declaration of function `DASSERT'
>
> Relevant config options seem to me:
>
> CONFIG_VIDEO_W9966=m

You are using egcs?

It seems egcs can't handle the following in lines 68-69:

<--  snip  -->

...
#   define DPRINTF(...) do {} while(0)
#   define DASSERT(...) do {} while(0)
...

<--  snip  -->


Since egcs is a supported compiler someone should fix this before
2.4.19-final comes out.


A solution might be something like the patch below (but I don't know for
sure whether this is the correct solution):


--- drivers/media/video/w9966.c.old	Wed Jun 26 10:08:04 2002
+++ drivers/media/video/w9966.c	Wed Jun 26 10:12:56 2002
@@ -65,8 +65,8 @@
 			DPRINTF("Assertion failed at line %d.\n", __LINE__);\
 	} while (0)
 #else
-#   define DPRINTF(...) do {} while(0)
-#   define DASSERT(...) do {} while(0)
+#   define DPRINTF(x...)
+#   define DASSERT(x...)
 #endif

 /*


> Cheers,
>
> Rolf

cu
Adrian

-- 

You only think this is a free country. Like the US the UK spends a lot of
time explaining its a free country because its a police state.
								Alan Cox





