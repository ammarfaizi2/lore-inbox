Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135223AbRDRSxb>; Wed, 18 Apr 2001 14:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135253AbRDRSxZ>; Wed, 18 Apr 2001 14:53:25 -0400
Received: from perninha.conectiva.com.br ([200.250.58.156]:9998 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S135223AbRDRSxH>; Wed, 18 Apr 2001 14:53:07 -0400
Date: Wed, 18 Apr 2001 15:52:58 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: <riel@duckman.distro.conectiva>
To: Laurent Chavet <lchavet@av.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Very bad behavior of kswapd
In-Reply-To: <3ADD64DD.5D8428BA@av.com>
Message-ID: <Pine.LNX.4.33.0104181551290.17635-100000@duckman.distro.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, Laurent Chavet wrote:

> Try this (my example I've 2GB of ram)
>
> turn all your swap off
>
> dd about 15% of the size of your RAM:
> dd if=/dev/zero of=/local/test count=300 bs=1000000
>
> Run this program with SIZE about 95% of your RAM:
>
> #include <stdlib.h>
> #include <unistd.h>
> #include <assert.h>
>
> #define SIZE (1900 * 1024 * 1024)
> int main()
> {
>   int i;
>   char *p = malloc(SIZE);
>   assert (p != NULL);
>   for (i = 0; i < SIZE; i++)
>  p[i] = 1;
>   printf ("done %p\n", p);
>
>   while (1)
>   {
>  sleep (60);
>   }
>   return 0;
> }
>
>
> Watch top: when this program needs the memory that kswapd keep
> in cache they go both at 100% cpu (on SMP) but still the size of
> the program only grows at about 100KB/s, why is kswapd releasing
> it so slowly and taking so much CPU ?

Because kswapd still has to scan all the (unfreeable) memory
of the big process to determine it isn't freeable.

At the moment kswapd is really stupid about these corner-case
situations, please bear with us while we fix it ...

... and don't forget to fill in a bugzilla item on the
Linux-MM bugzilla ;)

regards,

Rik
--
Linux MM bugzilla: http://linux-mm.org/bugzilla.shtml

Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com/

