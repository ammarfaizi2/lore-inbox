Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263596AbUFYTjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263596AbUFYTjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 15:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUFYTjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 15:39:15 -0400
Received: from digitalimplant.org ([64.62.235.95]:12188 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S263596AbUFYTjM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 15:39:12 -0400
Date: Fri, 25 Jun 2004 12:39:04 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: "Richard B. Johnson" <root@chaos.analogic.com>
cc: Daniel Jacobowitz <dan@debian.org>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: Re: swsusp.S: meaningfull assembly labels
In-Reply-To: <Pine.LNX.4.53.0406251526580.29587@chaos>
Message-ID: <Pine.LNX.4.50.0406251233550.18105-100000@monsoon.he.net>
References: <20040625115936.GA2849@elf.ucw.cz> <Pine.LNX.4.53.0406250827250.28070@chaos>
 <20040625151858.GA27013@nevyn.them.org> <Pine.LNX.4.53.0406251152580.28750@chaos>
 <20040625184817.GA3939@nevyn.them.org> <Pine.LNX.4.53.0406251526580.29587@chaos>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> > drow@nevyn:~% cat a.s
> > BUF = 0x1
> > code:
> >         mov %eax, 0
> > drow@nevyn:~% as -o a.o a.s
> > drow@nevyn:~% as -o b.o a.s
> > drow@nevyn:~% ld -o a a.o b.o
> > ld: warning: cannot find entry symbol _start; defaulting to 0000000008048074
> > drow@nevyn:~% nm a.o
> > 00000001 a BUF
> > 00000000 t code
> > drow@nevyn:~% nm a
> > 00000001 a BUF
> > 00000001 a BUF
> > 08049084 A __bss_start
> > 08049084 A _edata
> > 08049084 A _end
> > 08048074 t code
> > 0804807c t code
> >
> > LD won't even warn about duplicate absolute symbols unless they have
> > different values.
> >
>
> But they ARE different values. They will probably always be different
> values, and they end up with the same name, that `ld` sees and complains.

No, it doesn't complain, that's the point. According to nm(1):

       For each symbol, nm shows:

          The symbol value, in the  radix  selected  by  options
           (see below), or hexadecimal by default.

          The  symbol  type.   At  least the following types are
           used; others are, as well,  depending  on  the  object
           file  format.   If  lowercase, the symbol is local; if
           uppercase, the symbol is global (external).

Symbols in a source file that are static are tagged with a 't' as well.
Read System.map for more proof of this.

The patch is fine, especially since I think it's based on something I've
posted in the past. :) The one thing I'd always done differently, though,
was to prefix the labels with '.', since I thought that was what kept it
local. But, after I RTFM'd, I find that's not even necessary.


	Pat
