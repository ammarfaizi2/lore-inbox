Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293007AbSCORhR>; Fri, 15 Mar 2002 12:37:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293002AbSCORhJ>; Fri, 15 Mar 2002 12:37:09 -0500
Received: from petkele.almamedia.fi ([194.215.205.158]:33237 "HELO
	petkele.almamedia.fi") by vger.kernel.org with SMTP
	id <S292981AbSCORgt>; Fri, 15 Mar 2002 12:36:49 -0500
Message-ID: <3C923120.B3AF105E@pp.inet.fi>
Date: Fri, 15 Mar 2002 19:36:32 +0200
From: Jari Ruusu <jari.ruusu@pp.inet.fi>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.2.20aa1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Herbert Valerio Riedel <hvr@hvrlab.org>
CC: Andrea Arcangeli <andrea@suse.de>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        linux-kernel@vger.kernel.org, linux-crypto@nl.linux.org
Subject: Re: 2.4.19pre3aa2
In-Reply-To: <20020314032801.C1273@dualathlon.random> 
			<3C912ACF.AF3EE6F0@pp.inet.fi> <1016194785.5713.200.camel@janus.txd.hvrlab.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Valerio Riedel wrote:
> the patch I sent to andrea is quite minimal, it only changes the IV
> metric, and adds a few #define's to loop.h in order to recognize the IV
> metric when compiling filter modules against it; as to jari's patch, if
> the following def's were added, it can be used instead of my minimal
> patch...
> 
> /* definitions for IV metric */
> #define LOOP_IV_SECTOR_BITS 9
> #define LOOP_IV_SECTOR_SIZE (1 << LOOP_IV_SECTOR_BITS)
> 
> typedef int loop_iv_t;
> 
> ...except maybe for when backward compatibility is needed. As it is a
> major concern to some of us to be able to convert their old iv-metric
> encrypted volumes to the new "atomic"-IV-metric, it can be usefull to be
> able to have both IV metrics available on the same system...

Not changing IV parameter type in 2.4 kernels is important. Break that in
2.5/2.6 kernels, but not in stable 2.4, ok? Older 2.4 kernels dont't have
loop_iv_t, and being able to compile _existing_ modules for them is
important. 512 byte IV is nothing new, you know that, and all sane systems
have used 512 byte IV for a long time already. So the 'block size IV' change
to '512 byte IV' is nothing new, but changing the parameter type is evil and
should be avoided for compatibility sake.

> ps: just to make one thing clear (again), I don't care too much whether
> my loop-fix or jari's goes in; I primarily care for a fixed IV situation
> (including the above mentioned #define's/typedef) and if possible anyhow
> to allow for limited compatibility to the old metric...

So the choice here is either break (or at least cause need to modify) all
other implementations or cryptoapi implementation.

Herbert, if this loop_iv_t type goes into mainline kernel, I will have to
reverse that on loop-AES patches for backward compatibility.

Dependency on above mentioned #define's/typedef on kernel include files is
silly, as cryptoapi can define them on any of its own include files.

Regards,
Jari Ruusu <jari.ruusu@pp.inet.fi>
