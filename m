Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316580AbSGYWJ0>; Thu, 25 Jul 2002 18:09:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316578AbSGYWJ0>; Thu, 25 Jul 2002 18:09:26 -0400
Received: from [195.223.140.120] ([195.223.140.120]:58687 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S316580AbSGYWJY>; Thu, 25 Jul 2002 18:09:24 -0400
Date: Fri, 26 Jul 2002 00:13:28 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Lars Marowsky-Bree <lmb@suse.de>
Cc: Cort Dougan <cort@fsmlabs.com>, Christoph Hellwig <hch@infradead.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cheap lookup of symbol names on oops()
Message-ID: <20020725221328.GU1180@dualathlon.random>
References: <20020725110033.G2276@host110.fsmlabs.com> <20020725181126.A17859@infradead.org> <20020725112142.I2276@host110.fsmlabs.com> <20020725190445.GO1180@dualathlon.random> <20020725142716.N2276@host110.fsmlabs.com> <20020725205910.GR1180@dualathlon.random> <20020725211225.GG10033@marowsky-bree.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020725211225.GG10033@marowsky-bree.de>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 25, 2002 at 11:12:25PM +0200, Lars Marowsky-Bree wrote:
> On 2002-07-25T22:59:10,
>    Andrea Arcangeli <andrea@suse.de> said:
> 
> > One thing is if you have ksymall ala kdb and you can resolve to
> > something where you don't need the system.map to guess what happened,
> > but without the ksymall you need the system.map or vmlinux anyways.
> 
> I am still not convinced that this isn't the better approach overall; yes, the
> full ksymall table takes a few kb in memory, which can be avoided if one has a
> full vmlinux / System.map archive (as it would in theory be possible for a
> distribution for all shipped kernels), but having the fully decoded Oops - or
> at least, as far as possible - would certainly be more useful in the general
> case, and for self-compiled kernels.

depends how deep you need to go into the oops. I would say I find myself
going into the asm of the vmlinux 9 times out of 10 (basically every
time I cannot guess the problem by just looking at the oops without
doing any real debugging). so yes kksymoops may help once in a while,
but all other times I would probably be faster asking gdb to disasm a
certain fixed hex address (that will give me the symbol too of course :).

So I don't feel the need of kksymoops, at least given I can find out
what kernel the user was running, that will be possible by printing the
uname -a information in the oops too. So with a "featured oops" with
uname -a + module start info + database we'll have all we need to decode
whatever oops usually without significant slowdown compared to
kksymoops, but nevertheless if we're ok to waste some hundred kbyte of
ram (and mbytes of space on disk for the numerous modules) also
kksymoops will be fine. But nevertheless kksymoops should be a config
option, so when disabled my "featured oops" wish still apply :)

Andrea
