Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312031AbSDJJ5m>; Wed, 10 Apr 2002 05:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312178AbSDJJ5l>; Wed, 10 Apr 2002 05:57:41 -0400
Received: from mailhost.mipsys.com ([62.161.177.33]:64210 "EHLO
	mailhost.mipsys.com") by vger.kernel.org with ESMTP
	id <S312031AbSDJJ5k>; Wed, 10 Apr 2002 05:57:40 -0400
From: <benh@kernel.crashing.org>
To: Peter Horton <pdh@berserk.demon.co.uk>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Radeon frame buffer driver
Date: Wed, 10 Apr 2002 11:57:31 +0100
Message-Id: <20020410105731.28774@mailhost.mipsys.com>
In-Reply-To: <20020410094055.GA789@berserk.demon.co.uk>
X-Mailer: CTM PowerMail 3.1.2 F <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>Please look at code.

Ok, I may have been confused by looking only at the patch file

>In 32bpp mode user space can set all 256 palette indices.
>
>In 15 bit mode user space can set all 32 palette indices.
>
>In 16bpp mode user space can set all 32 palette indices for red and
>blue, and all 64 palette indices for green.

Fine, though I noticed the get_cmap_len got changed to
+	return var->bits_per_pixel == 8 ? 256 : 16;

>The reason 16bpp mode fails when using "fbtv" is that "fbtv" only
>initialises the first 32 palette indices for green, but the captured
>video uses all 64 values. I patched "fbtv" to initialise all 64 indices
>and it worked fine. I think this is a bug in "fbtv" (and other such
>apps).
>
>There is a hack in the code to support "fbtv" in 16bpp mode, but it is
>only used if you pass the driver the "fb16fix" flag, and it limits the
>green component to 5 bits. I used it for testing but it doesn't need to
>live any longer. If people want to use "fbtv" they should use 15 or 32
>bit mode.

Ok use a fixed fbtv, I agree.

>Test it, in all modes, I have.
>
>The other hack is one that sets the top indices in the palette to white
>when palette index 0 is set. This is needed for the soft cursor to work
>as the soft cursor just flips all the bits in each pixel, which doesn't
>work in DIRECTCOLOR modes. Other drivers do similiar things. I've
>started to look at using the accelerator engine for flipping the cursor
>but there are locking issues involved which I want to get right.

Maybe we should use the HW cursor. Setting the top indice will cause
problem with MacOnLinux as MacOS don't use the same color layout as
most unix apps.

Anyway, I'll look at your patch more closely and test it asap,

Ben.


