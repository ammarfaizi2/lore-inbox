Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131693AbRCOM5E>; Thu, 15 Mar 2001 07:57:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131683AbRCOM4z>; Thu, 15 Mar 2001 07:56:55 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:10760 "HELO
	postfix.conectiva.com.br") by vger.kernel.org with SMTP
	id <S131415AbRCOM4m>; Thu, 15 Mar 2001 07:56:42 -0500
Date: Thu, 15 Mar 2001 09:36:24 -0300 (BRST)
From: Rik van Riel <riel@conectiva.com.br>
To: Anton Blanchard <anton@linuxcare.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: Only one memory zone for sparc64
In-Reply-To: <20010315191352.D1598@linuxcare.com>
Message-ID: <Pine.LNX.4.21.0103150933210.4165-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Mar 2001, Anton Blanchard wrote:

> On sparc64 we dont care about the different memory zones and iterating
> through them all over the place only serves to waste CPU. I suspect
> this would be the case with some other architectures but for the
> moment I have just enabled it for sparc64.
> 
> With this patch I get close to a 1% improvement in dbench on the dual
> ultra60.

1% ... I didn't expect Linux to take THIS much of a hit due to
not using the zones on some architectures ...

I guess this is enough of a difference to make sure we don't do
these extra iterations when they're not needed.

> +#ifdef __sparc_v9__
> +#define MAX_NR_ZONES		1
> +#define ZONE_NAMES		{ "DMA" }
> +#define ZONE_BALANCE_RATIO	{ 32 }
> +#define ZONE_BALANCE_MIN	{ 10 }
> +#define ZONE_BALANCE_MAX	{ 255 }
> +#else

I guess it may be better to just have include/asm-<foo>/mmzone.h
files for each architecture. Maybe even optionally behind an
IFNDEF so we could start with almost empty files for each
architecture and only fill in something when the values really
need to be different ...

regards,

Rik
--
Virtual memory is like a game you can't win;
However, without VM there's truly nothing to lose...

		http://www.surriel.com/
http://www.conectiva.com/	http://distro.conectiva.com.br/

