Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269218AbUJFMPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269218AbUJFMPm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 08:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269225AbUJFMPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 08:15:41 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:37612 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269218AbUJFMPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 08:15:39 -0400
Date: Wed, 6 Oct 2004 14:15:34 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Message-ID: <20041006121534.GA8386@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua> <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
X-SA-Exim-Scanned: No; SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 10:43:52 +0200, Geert Uytterhoeven wrote:
> On Wed, 6 Oct 2004, Willy Tarreau wrote:
> > On Wed, Oct 06, 2004 at 12:58:57AM +0300, Denis Vlasenko wrote:
> > > > +		if (open("/dev/null", O_RDWR, 0) == 0)
> > > > +			printk("         Falling back to /dev/null.\n");
> > > > +	}
> > > 
> > > What will happen if /dev is totally empty?
> > 
> > ... Which is the most probable reason causing this trouble.

I have no idea about the probability, but in the one case I worry
about, a console is explicitly disabled because it is not wanted.
/dev does exist and is populated.

> Some debug methods use register_console() to get their print routines
> registered. If people forget to say e.g. `console=tty0' afterwards, the debug
> console without the real device cannot be opened through /dev/console, and they
> get a mysterious error. Usually /dev/console _is_ present in the root fs.

Yes, I thought about doing things at a different level as well.  If
there really is no console, shouldn't /dev/console have the same
behavious as /dev/null?

Point is that above patch is simpler and empiria didn't give me a
reason to worry about anything else.

Jörn

-- 
Time? What's that? Time is only worth what you do with it.
-- Theo de Raadt
