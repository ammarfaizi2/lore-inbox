Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316106AbSFJUWl>; Mon, 10 Jun 2002 16:22:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316127AbSFJUWk>; Mon, 10 Jun 2002 16:22:40 -0400
Received: from cpe-24-221-152-185.az.sprintbbd.net ([24.221.152.185]:20176
	"EHLO opus.bloom.county") by vger.kernel.org with ESMTP
	id <S316106AbSFJUVy>; Mon, 10 Jun 2002 16:21:54 -0400
Date: Mon, 10 Jun 2002 13:15:10 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Thunder from the hill <thunder@ngforever.de>
Cc: Andrew Morton <akpm@zip.com.au>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.21 kill warnings 4/19
Message-ID: <20020610201510.GO14252@opus.bloom.county>
In-Reply-To: <Pine.LNX.4.44.0206101403010.6159-100000@hawkeye.luckynet.adm> <Pine.LNX.4.44.0206101408380.6159-100000@hawkeye.luckynet.adm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 10, 2002 at 02:10:23PM -0600, Thunder from the hill wrote:
> Hi,
> 
> On Mon, 10 Jun 2002, Thunder from the hill wrote:
> > #define __FUNCTION__ __func__
> 
> Hmmm... that's just logical. If they just remove the __FUNCTION__ 
> constant, there's nothing to complain about if we redefine it. Even my 
> chaos brain sees that.

What?  __FUNCTION__ and __func__ can't be used interchangably.  But for
older compilers which lack __func__, you can do:
#define __func__ __FUNCTION__

And provided that __func__ is only used like this:
printk("Something bad happened in %s\n", __func__);

egcs-1.1.2 will be happy, gcc-2.95.x will be happy and gcc-3.x will be
happy and we won't be doing the now 'bad' thing of:
printk("Something bad happened in " __FUNCTION__ "\n");

(And if gcc-3.x ever drops __FUNCTION__, which I have nfc if they will,
we'll be ok still).

-- 
Tom Rini (TR1265)
http://gate.crashing.org/~trini/
