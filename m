Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276345AbRI1WPW>; Fri, 28 Sep 2001 18:15:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276343AbRI1WPM>; Fri, 28 Sep 2001 18:15:12 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:11268 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S276345AbRI1WPE>; Fri, 28 Sep 2001 18:15:04 -0400
Date: Fri, 28 Sep 2001 15:14:54 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: "Martin J. Bligh" <fletch@aracnet.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Patches to enable ia32 NUMA system (32 proc)
In-Reply-To: <200109282157.OAA07885@gormenghast.vista>
Message-ID: <Pine.LNX.4.33.0109281512280.4166-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 28 Sep 2001, Martin J. Bligh wrote:
>
> I've got rid of a few bugs (including my mail formatter). I think I've changed
> what you wanted changed in here. I've also updated them to go against 2.4.10.
> Please let me know of anything else you want changed.

The only thing I reacted to in these patches is:

> diff -urN virgin-2.4.10/init/main.c numa-2.4.10/init/main.c
> --- virgin-2.4.10/init/main.c	Thu Sep 20 21:02:01 2001
> +++ numa-2.4.10/init/main.c	Thu Sep 27 11:57:21 2001
> @@ -490,9 +490,19 @@
>
>  #else
>
> +/* Where the IO area was mapped on multiquad, always 0 otherwise */
> +void *xquad_portio = NULL;
...

This is _definitely_ the wrong place to have magic x86-only code.

Why don't you just move that into the top of smp_boot_cpus()?

		Linus

