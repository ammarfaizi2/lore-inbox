Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282862AbRLBMdg>; Sun, 2 Dec 2001 07:33:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282864AbRLBMd1>; Sun, 2 Dec 2001 07:33:27 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:47573 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S282861AbRLBMdR>; Sun, 2 Dec 2001 07:33:17 -0500
Date: Sun, 2 Dec 2001 13:33:14 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Keith Owens <kaos@ocs.com.au>
Cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux-Kernel list <linux-kernel@vger.kernel.org>
Subject: Re: PATCH 2.4.17.2: make ext2 smaller
Message-ID: <20011202133314.B717@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <3C0A1105.18B76D64@mandrakesoft.com> <25560.1007294074@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <25560.1007294074@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Sun, Dec 02, 2001 at 10:54:34PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 02, 2001 at 10:54:34PM +1100, Keith Owens wrote:
> On Sun, 02 Dec 2001 06:31:17 -0500, 
> Jeff Garzik <jgarzik@mandrakesoft.com> wrote:
> >Simply, all ext2 files are #include'd into a single file, ext2_all.c,
> >and all functions and data structures are declared static.
> 
> I like it.

Me also. Except for the KSTATIC spread all over the Kernel.

> With kbuild 2.5 the generation of ext2_all.c (I prefer
> ext2_static.c) can be automated.
> 
> The code that is normally linked into xxxx.o has to be manually changed
> to add XXXX_STATIC before a make_static(xxxx) command can be added.

Even this doesn't have to be done manually. Everything that is
not covered by EXPORT_SYMBOL() in this case can be static, since
it belongs only to this subsystem and is not oficially exported
to other ones, which is a BUG if something depend on it with
CONFIG_MAKE_STATIC enabled.

Now if GCC had an option to make all symbols static by default,
which are not also declared extern...

Regards

Ingo Oeser
-- 
Science is what we can tell a computer. Art is everything else. --- D.E.Knuth
