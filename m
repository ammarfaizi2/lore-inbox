Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315629AbSHAQaZ>; Thu, 1 Aug 2002 12:30:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315708AbSHAQaZ>; Thu, 1 Aug 2002 12:30:25 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:54657 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S315629AbSHAQaY>; Thu, 1 Aug 2002 12:30:24 -0400
Date: Thu, 1 Aug 2002 18:33:40 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Kasper Dupont <kasperd@daimi.au.dk>
cc: stas.orel@mailcity.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] vm86: Clear AC on INT
In-Reply-To: <3D493B06.3C20A88@daimi.au.dk>
Message-ID: <Pine.GSO.3.96.1020801182359.8256L-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Aug 2002, Kasper Dupont wrote:

> This sounds a little strange to me. AC is in the upper 16 bit
> of the EFLAGS register, so it is not saved on an interrupt
> where only lower 16 bits is saved. This means that when we
> clear it on the interrupt, the value will be lost for good.

 Indeed.

> I can see the spec says it, so we'd better do that. But does
> the spec make any sense? And does the CPU really loose the
> AC flag on every interrupt in real mode?

 The flag is cleared as on every interrupt regardless of the processor's
mode.  It's unfortunate it gets stored nowhere in the real mode, indeed. 
It leads the Intel's official CPU determination code to fail if interrupts
are enabled and one arrives at a wrong time.  I discovered it in mid-90's
and have some diagnostic code somewhere in my archive -- basically raising
the 8254 timer interrupt rate (actually any IRQ suffices, but that's the
easiest to reconfigure) much enough assures any i486+ processor will get
misidentified as an i386 with high enough probability you may actually see
incorrect reports from programs. 

 The discussion may be available from a Usenet archive; I think there is a
statement on the problem somewhere at the www.x86.org site as well.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

