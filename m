Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262772AbUFQTg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262772AbUFQTg2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jun 2004 15:36:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262766AbUFQTg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jun 2004 15:36:28 -0400
Received: from witte.sonytel.be ([80.88.33.193]:20216 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S262772AbUFQTgO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jun 2004 15:36:14 -0400
Date: Thu, 17 Jun 2004 21:36:11 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
cc: Finn Thain <ft01@webmastery.com.au>, Andreas Schwab <schwab@suse.de>,
       Linux/m68k <linux-m68k@lists.linux-m68k.org>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: make checkstack on m68k
In-Reply-To: <Pine.GSO.4.58.0406172115050.1495@waterleaf.sonytel.be>
Message-ID: <Pine.GSO.4.58.0406172130130.1495@waterleaf.sonytel.be>
References: <Pine.GSO.4.58.0406161845490.1249@waterleaf.sonytel.be>
 <je3c4uqum0.fsf@sykes.suse.de> <Pine.LNX.4.58.0406180048180.13963@bonkers.disegno.com.au>
 <20040617182658.GB29029@wohnheim.fh-wedel.de> <Pine.GSO.4.58.0406172115050.1495@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jun 2004, Geert Uytterhoeven wrote:
> On Thu, 17 Jun 2004, [iso-8859-1] Jörn Engel wrote:
> > On Fri, 18 June 2004 01:17:31 +1000, Finn Thain wrote:
> > > On Thu, 17 Jun 2004, Andreas Schwab wrote:
> > > >
> > > >   $re = qr/.*(?:linkw %fp,|addw )#-([0-9]{1,4})(?:,%sp)?$/o;
> > >
> > > I think that should be addaw, not addw. And it may be necessary to remove
> > > the $ anchor at the end.
> >
> > Changed, updated patch below.  Thanks.
> >
> > Can anyone test?
>
> Doesn't work ;-(
>
> I also tried with
>
>     $re = qr/.*(?:linkw %fp,|addaw )#-([0-9]{1,4})(?:,%sp)?$/o;
>
> but still didn't work ;-(

*bummer*

why doesn't checkstack.pl complain if I forget to specify `m68k'?!?

So it works with the above regex, if I undo the `my $size = $2;' change as
well.

To avoid mistakes/confusion, here is a patch against pristine 2.6.7:

--- linux-2.6.7/scripts/checkstack.pl	2004-06-09 14:51:23.000000000 +0200
+++ linux-m68k-2.6.7/checkstack.pl	2004-06-17 21:31:45.000000000 +0200
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
