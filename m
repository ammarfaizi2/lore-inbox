Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267757AbTBRJf7>; Tue, 18 Feb 2003 04:35:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267758AbTBRJf7>; Tue, 18 Feb 2003 04:35:59 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:6157 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S267757AbTBRJf6>;
	Tue, 18 Feb 2003 04:35:58 -0500
Message-ID: <3E5200BD.6000604@pobox.com>
Date: Tue, 18 Feb 2003 04:45:33 -0500
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Stelian Pop <stelian.pop@fr.alcove.com>
CC: sam@ravnborg.org, kai@tp1.ruhr-uni-bochum.de, greg@kroah.com,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [RFC] klibc for 2.5.59 bk
References: <20030209125759.GA14981@kroah.com> <Pine.LNX.4.44.0302162057200.5217-100000@chaos.physics.uiowa.edu> <20030217180246.GA26112@mars.ravnborg.org> <1911.212.181.176.76.1045505249.squirrel@www.zytor.com> <3E512BCB.1010000@pobox.com> <1144.62.20.229.212.1045558700.squirrel@www.zytor.com> <3E51FA1C.7060807@pobox.com> <20030218093601.GA3980@cedar.alcove-fr>
In-Reply-To: <20030218093601.GA3980@cedar.alcove-fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stelian Pop wrote:
> Tested, works ok.

thanks.


> Slighly different patch attached.
> 
> Linus, please apply.

um, please don't...


> ===== arch/i386/Makefile 1.44 vs edited =====
> --- 1.44/arch/i386/Makefile	Fri Feb  7 19:59:54 2003
> +++ edited/arch/i386/Makefile	Tue Feb 18 09:59:16 2003
> @@ -39,12 +39,13 @@
>  cflags-$(CONFIG_MK6)		+= $(call check_gcc,-march=k6,-march=i586)
>  cflags-$(CONFIG_MK7)		+= $(call check_gcc,-march=athlon,-march=i686 -malign-functions=4)
>  cflags-$(CONFIG_MK8)		+= $(call check_gcc,-march=k8,$(call check_gcc,-march=athlon,-march=i686 -malign-functions=4))
> -cflags-$(CONFIG_MCRUSOE)	+= -march=i686 -malign-functions=0 -malign-jumps=0 -malign-loops=0
> +cflags-$(CONFIG_MCRUSOE)	+= -march=i686
>  cflags-$(CONFIG_MWINCHIPC6)	+= $(call check_gcc,-march=winchip-c6,-march=i586)
>  cflags-$(CONFIG_MWINCHIP2)	+= $(call check_gcc,-march=winchip2,-march=i586)
>  cflags-$(CONFIG_MWINCHIP3D)	+= -march=i586
>  cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-march=c3,-march=i486)
>  # The alignment flags change with gcc 3.2
> +cflags-$(CONFIG_MCRUSOE)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
>  cflags-$(CONFIG_MCYRIXIII)	+= $(call check_gcc,-falign-functions=0 -falign-jumps=0 -falign-loops=0,-malign-functions=0 -malign-jumps=0 -malign-loops=0)
>  cflags-$(CONFIG_MVIAC3_2)	+= $(call check_gcc,-march=c3-2,-march=i686)

...because
(a) the Crusoe cflags are no longer together,
(b) Cyrix-3 cflags are suddenly bisected by Crusoe cflags, and
(c) you just dumped a crusoe-specific line in the middle of a bunch of 
Via/Cyrix CPU settings.

None of those choices makes sense.  If you want to improve upon my 
patch, I would suggest consolidating the -f/-m check above the CPU 
cflags section, and then reference the calculated value, rather than 
wholly duplicating the calculation.  The comment line "# The alignment 
flags [...]" is obviously not the start of a new alignment-flags section.

	Jeff



