Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265139AbUFRNjp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265139AbUFRNjp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 09:39:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265140AbUFRNjp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 09:39:45 -0400
Received: from witte.sonytel.be ([80.88.33.193]:48845 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S265139AbUFRNjn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 09:39:43 -0400
Date: Fri, 18 Jun 2004 15:39:38 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Finn Thain <ft01@webmastery.com.au>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Matt Mackall <mpm@selenic.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: Subject: Re: make checkstack on m68k
In-Reply-To: <20040618121813.GB18258@wohnheim.fh-wedel.de>
Message-ID: <Pine.GSO.4.58.0406181537210.11779@waterleaf.sonytel.be>
References: <200406161930.VAA16618@pfultra.phil.uni-sb.de>
 <Pine.LNX.4.58.0406171812440.8197@bonkers.disegno.com.au>
 <20040617183616.GC29029@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406172127150.1495@waterleaf.sonytel.be>
 <20040618121813.GB18258@wohnheim.fh-wedel.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> On Thu, 17 June 2004 21:27:35 +0200, Geert Uytterhoeven wrote:
> > On Thu, 17 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> > >
> > > It's not as ugly as my hack.  Can I get a success report from m68k?
> > > Thanks!
>
> Good.  Finn, can you resend to me with a signed-off-by: comment?  If
> you grow bored, you could seperate the i386 regexes (sub..., add...)
> as well.

If you insist...

Add m68k support to checkstack.pl

Regular expression combination by Andres Schwab

Signed-off-by: geert@linux-m68k.org

--- linux-2.6.7/scripts/checkstack.pl	2004-06-09 14:51:23.000000000 +0200
+++ linux-m68k-2.6.7/scripts/checkstack.pl	2004-06-17 21:31:45.000000000 +0200
@@ -40,6 +40,10 @@
 	} elsif ($arch =~ /^ia64$/) {
 		#e0000000044011fc:       01 0f fc 8c     adds r12=-384,r12
 		$re = qr/.*adds.*r12=-(([0-9]{2}|[3-9])[0-9]{2}),r12/o;
+	} elsif ($arch =~ /^m68k$/) {
+		#    2b6c:       4e56 fb70       linkw %fp,#-1168
+		#  1df770:       defc ffe4       addaw #-28,%sp
+		$re = qr/.*(?:linkw %fp,|addaw )#-([0-9]{1,4})(?:,%sp)?$/o;
 	} elsif ($arch =~ /^mips64$/) {
 		#8800402c:       67bdfff0        daddiu  sp,sp,-16
 		$re = qr/.*daddiu.*sp,sp,-(([0-9]{2}|[3-9])[0-9]{2})/o;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
