Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269127AbUJFIon@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269127AbUJFIon (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 04:44:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269121AbUJFIom
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 04:44:42 -0400
Received: from witte.sonytel.be ([80.88.33.193]:10626 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S269127AbUJFIoc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 04:44:32 -0400
Date: Wed, 6 Oct 2004 10:43:52 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Willy Tarreau <willy@w.ods.org>,
       =?ISO-8859-15?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
cc: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is
 availlable
In-Reply-To: <20041006043458.GB19761@alpha.home.local>
Message-ID: <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de>
 <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua>
 <20041006043458.GB19761@alpha.home.local>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Oct 2004, Willy Tarreau wrote:
> On Wed, Oct 06, 2004 at 12:58:57AM +0300, Denis Vlasenko wrote:
> > > +		if (open("/dev/null", O_RDWR, 0) == 0)
> > > +			printk("         Falling back to /dev/null.\n");
> > > +	}
> > 
> > What will happen if /dev is totally empty?
> 
> ... Which is the most probable reason causing this trouble.

Indeed, but there are other known cases.

Some debug methods use register_console() to get their print routines
registered. If people forget to say e.g. `console=tty0' afterwards, the debug
console without the real device cannot be opened through /dev/console, and they
get a mysterious error. Usually /dev/console _is_ present in the root fs.

Perhaps a better fix is to modify the /dev/console demux code to fall back to
`/dev/null' (quotes to indicate this has nothing to do with a present /dev/null
on your root fs or ramdisk, but that it's the virtual null device) if the
struct console corresponding to /dev/console is not an existing tty device.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
