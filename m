Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317329AbSFGT1E>; Fri, 7 Jun 2002 15:27:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317335AbSFGT1D>; Fri, 7 Jun 2002 15:27:03 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:3205 "EHLO
	opus.bloom.county") by vger.kernel.org with ESMTP
	id <S317329AbSFGT1C>; Fri, 7 Jun 2002 15:27:02 -0400
Date: Fri, 7 Jun 2002 12:26:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Cleanup i386 <linux/init.h> abuses
Message-ID: <20020607192614.GN14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.33.0206021853030.1383-100000@penguin.transmeta.com> <20020605163614.GF1335@opus.bloom.county> <20020607110145.GA9975@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 07, 2002 at 01:01:45PM +0200, Pavel Machek wrote:
> Hi!
> 
> > The following patch cleans up the i386 usage of <linux/init.h>.
> > This remove <linux/init.h> from <asm-i386/system.h> which did not need
> > it, <asm-i386/highmem.h> which only had it due to an extern using
> > __init, which is not needed.
> > This adds <linux/init.h> to <asm-i386/bugs.h> which actually has
> > numerous __init functions and adds <linux/init.h> to 9 files inside of
> > arch/i386 which were indirectly including <linux/init.h> previously.
> 
> 
> @@ -33,7 +32,7 @@
>  extern pgprot_t kmap_prot;
>  extern pte_t *pkmap_page_table;
> 
> -extern void kmap_init(void) __init;
> +extern void kmap_init(void);
> 
>  /*
>   * Right now we initialize only a single pte table. It can be
> extended
> 
> 
> __init is usefull as a documentation... Perhaps adding /* This is
> __init function */ would be good.

The use of __init in externs is done very infrequently right now, and is
probably causing <linux/init.h> to be included in a few more headers
that probably don't need it and thus masking the bugs in some .c files.

I also think it makes very poor documentation right now since it's done
a total of 24 times, and should probably be removed for consistency.  Or
left alone since <linux/init.h> mentions you can do it.

But personally, I'm against doing it.

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
