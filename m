Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269091AbUJFNdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269091AbUJFNdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 09:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269132AbUJFNdf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 09:33:35 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:27785 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S269091AbUJFNdO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 09:33:14 -0400
Date: Wed, 6 Oct 2004 15:33:10 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Willy Tarreau <willy@w.ods.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Message-ID: <20041006133310.GD8386@wohnheim.fh-wedel.de>
References: <20041005185214.GA3691@wohnheim.fh-wedel.de> <200410060058.57244.vda@port.imtp.ilyichevsk.odessa.ua> <20041006043458.GB19761@alpha.home.local> <Pine.GSO.4.61.0410061038590.20160@waterleaf.sonytel.be> <20041006121534.GA8386@wohnheim.fh-wedel.de> <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.61.0410061504140.20160@waterleaf.sonytel.be>
User-Agent: Mutt/1.3.28i
Subject: Re: [PATCH] Console: fall back to /dev/null when no console is availlable
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
X-SA-Exim-Rcpt-To: geert@linux-m68k.org, willy@w.ods.org, vda@port.imtp.ilyichevsk.odessa.ua, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: joern@wohnheim.fh-wedel.de
X-SA-Exim-Version: 3.1 (built Son Feb 22 10:54:36 CET 2004)
X-SA-Exim-Scanned: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 October 2004 15:07:05 +0200, Geert Uytterhoeven wrote:
> On Wed, 6 Oct 2004, [iso-8859-1] Jörn Engel wrote:
> > 
> > Point is that above patch is simpler and empiria didn't give me a
> > reason to worry about anything else.
> 
> I'll give you another reason :-)
> 
> If I do have multiple active struct consoles registered (e.g. normal tty0 or
> ttyS0 and a debug console without a real tty), and the /dev/console demux
> thinks the debug console is the real one (the one opened if you open
> /dev/console), printk() messages will appear on both active consoles, but
> /dev/console cannot be opened.
> 
> To avoid this problem, the /dev/console demux should walk the list of active
> consoles until it finds one that can be opened, or fall back to /dev/null if
> none is found.
> 
> Does that sound reasonable?

Not to me, no.  But I was wrong before.

Having no console at all is a valid design.  It used to cause
problems, my patch fixes them.  A command-line option like
"console=/dev/null" doesn't fix it because it doesn't do what it
appears to do at first glance, so the patch is needed.

Having a non-working console, esp. for debug, is a rather odd design.
My approach would be to either explicitly tell the kernel to use the
other as default console via "console=/dev/ttyS0" or not have the
debug thing in the kernel in the first place.  Either way, no patch is
needed.

Worse, a kernel patch would paper over what is an underlying problem
in my book.  Fix the first problem, don't live with it as good as
possible.

Is this reasonable?

Jörn

-- 
The competent programmer is fully aware of the strictly limited size of
his own skull; therefore he approaches the programming task in full
humility, and among other things he avoids clever tricks like the plague. 
-- Edsger W. Dijkstra
