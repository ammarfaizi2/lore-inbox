Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287944AbSAHG2v>; Tue, 8 Jan 2002 01:28:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287945AbSAHG2b>; Tue, 8 Jan 2002 01:28:31 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:57611 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287944AbSAHG23>; Tue, 8 Jan 2002 01:28:29 -0500
Message-ID: <3C3A9048.CB80061A@zip.com.au>
Date: Mon, 07 Jan 2002 22:23:04 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18pre1 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: David Weinehall <tao@acc.umu.se>
CC: Richard Gooch <rgooch@ras.ucalgary.ca>, Ivan Passos <ivan@cyclades.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Serial Driver Name Question (kernels 2.4.x)
In-Reply-To: <3C38BC19.72ECE86@zip.com.au>, <3C34024A.EDA31D24@zip.com.au> <3C33E0D3.B6E932D6@zip.com.au> <3C33BCF3.20BE9E92@cyclades.com> <200201030637.g036bxe03425@vindaloo.ras.ucalgary.ca> <200201062012.g06KCIu16158@vindaloo.ras.ucalgary.ca> <3C38BC19.72ECE86@zip.com.au> <200201070636.g076asR25565@vindaloo.ras.ucalgary.ca> <3C3A7DA7.381D033D@zip.com.au>,
		<3C3A7DA7.381D033D@zip.com.au>; from akpm@zip.com.au on Mon, Jan 07, 2002 at 09:03:35PM -0800 <20020108071548.J5235@khan.acc.umu.se>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Weinehall wrote:
> 
> On Mon, Jan 07, 2002 at 09:03:35PM -0800, Andrew Morton wrote:
> > [ tty driver name breakage ]
> >
> > Richard, can we please get this wrapped up?
> >
> > My preferred approach is to change the driver naming scheme
> > so that we don't have to put printf control-strings everywhere.
> > We can remove a number of ifdefs that way.
> 
> Wouldn't it be cleaner to have:
> 
> #ifdef CONFIG_DEVFS_FS
>         serial_driver.name = "tts/";
> #else
>         serial_driver.name = "tts";
> #endif
> 
> and
> 
>         sprintf("buf, "%s%d", name, idx + tty->driver.name_base);
> 
> respectively?!
> 

Well, with the scheme I proposed most drivers won't need the
ifdef.  It'll just be:

	serial_driver.name = "cua";

With devfs enabled that expands to cua/42.  Without devfs it expands
to cua42.

Seems that some drivers have had their name changed when used under
devfs (tts/%d versus ttyS%d).  But a lot have not.

-
