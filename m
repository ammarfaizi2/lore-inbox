Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266278AbUAWRXc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jan 2004 12:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266613AbUAWRXc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jan 2004 12:23:32 -0500
Received: from jurand.ds.pg.gda.pl ([153.19.208.2]:14210 "EHLO
	jurand.ds.pg.gda.pl") by vger.kernel.org with ESMTP id S266278AbUAWRXb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jan 2004 12:23:31 -0500
Date: Fri, 23 Jan 2004 18:23:29 +0100 (CET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Mikael Pettersson <mikpe@csd.uu.se>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] local APIC LVTT init bug
In-Reply-To: <Pine.LNX.4.58.0401230748080.2151@home.osdl.org>
Message-ID: <Pine.LNX.4.55.0401231815300.3223@jurand.ds.pg.gda.pl>
References: <16400.9569.745184.16182@alkaid.it.uu.se>
 <Pine.LNX.4.55.0401231250310.3223@jurand.ds.pg.gda.pl>
 <16401.6720.115695.872847@alkaid.it.uu.se> <Pine.LNX.4.55.0401231419460.3223@jurand.ds.pg.gda.pl>
 <Pine.LNX.4.58.0401230748080.2151@home.osdl.org>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 23 Jan 2004, Linus Torvalds wrote:

> It's entirely possible that the bug isn't in the integrated APIC per se, 
> but migth be in ACPI/SMM getting confused when it reads the LVTT value and
> tries to do something with it. And since the system vendors don't tend
> to test with Linux (or test only with a few standard kernels that may not 
> even have APIC enabled) the code might never have been tested with that 
> behaviour.

 Hmm, but are the timer base selection bits actually flippable in any
integrated APICs?  I've never seen them set to anything but "00" in my P5
APICs despite our initialization code.

> Now quite honestly, I don't know _why_ it would read the value, so that 
> theory is a pretty weak one, but the point being that it's not absolutely 
> necessary that the hardware itself be broken. This is the reason we see
> most SMM/BIOS bugs - the code just assumes certain states.

 It constantly amazes me what imaginative ways to trigger failures the
designers of PC firmware find -- given no coupling of OSes to hardware
vendors one cannot assume any particular state of the hardware.  This is
especially true with the SMM, which may often get entered at any moment,
beyond control of the OS.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
