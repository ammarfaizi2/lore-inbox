Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287436AbSBKHXz>; Mon, 11 Feb 2002 02:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287487AbSBKHXp>; Mon, 11 Feb 2002 02:23:45 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:59404 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S287436AbSBKHXg>;
	Mon, 11 Feb 2002 02:23:36 -0500
Message-ID: <3C677127.FC047CE2@zip.com.au>
Date: Sun, 10 Feb 2002 23:22:15 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: vda@port.imtp.ilyichevsk.odessa.ua
CC: Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, Hugh Dickins <hugh@veritas.com>,
        Marcelo Tosatti <marcelo@conectiva.com.br>,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG preserve registers
In-Reply-To: <3C660517.AAA7FA8@zip.com.au> <3C6612FE.3AD035E@zip.com.au> <3C6637F3.9CDA7278@zip.com.au>,
		<3C6637F3.9CDA7278@zip.com.au> <200202110710.g1B7A5t28328@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko wrote:
> 
> On 10 February 2002 07:05, Andrew Morton wrote:
> > Andrew Morton wrote:
> > > I think I'm done with this now.
> >
> > Famous last words.  There's a slightly updated version at
> > http://www.zip.com.au/~akpm/linux/2.4/2.4.18-pre9/
> >
> > CONFIG_DEBUG_BUGVEROSE has been retained - it's now used to enable
> > BUG() in a couple of bloaty places.  But BUG() now always
> > reports file-and-line.
> >
> > Also, here's the kill-BUG-in-headers patch.  With this, the
> > kernel image is in fact a few kbytes smaller than stock
> > 2.4.18-pre9 with CONFIG_DEBUG_BUGVERBOSE=n, and we get full
> > file-and-line and the registers aren't trashed, so everyone's
> > happy.
> 
> I downloaded BUG.patch and inline-BUG.patch and compiled 2.4.18-pre9
> bzImage with and without these patches:
> 
> 2.4.18-pre9:         bzImage 996963  vmlinux 2440880
> 2.4.18-pre9+patches: bzImage 997531  vmlinux 2441182
> 
> .config is the same, you may find it below.
> "# CONFIG_DEBUG_BUGVERBOSE is not set"
> Andrew, are these numbers expected?

Pretty much.  In adding the patch, you've added six more bytes
to each BUG() call site and numerous filenames.  For me, the
kernel came out a little smaller, but for you, it grew a bit.  I
wonder why.  From a quick test it seems that gcc-3.0.3 and
recent binutils do fold common strings between compilation
units.  But I need to double-check that.  Maybe it's due to
that somehow.

Of course, for the extra 300 bytes of kernel you've gained
file-and-line info in all the BUG calls.

-
