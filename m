Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312453AbSCUTDn>; Thu, 21 Mar 2002 14:03:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312455AbSCUTDc>; Thu, 21 Mar 2002 14:03:32 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:18637 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S312453AbSCUTDW>; Thu, 21 Mar 2002 14:03:22 -0500
Date: Thu, 21 Mar 2002 19:58:49 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: linux-kernel@vger.kernel.org
Subject: Re: boot_cpu_data.x86_vendor corruption on dual AMD
In-Reply-To: <200203132129.WAA08883@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020321192522.22279F-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Mar 2002, Mikael Pettersson wrote:

> I'm involved with debugging a driver problem which only appears
> on dual AMD systems. When the driver's module_init() is called,
> boot_cpu_data.x86_vendor is 0 (Intel) instead of 2 (AMD), causing
> incorrect code to be selected and eventually an oops.
> 
> We've so far traced it to the call to smp_init() in init/main.c.
> Before this call, boot_cpu_data.x86_vendor is 2 (correct), but
> after the call, the field is 0.

 Code in arch/i386/kernel/head.S (look below checkCPUtype) clears
boot_cpu_data.x86_vendor and it does not get reconstructed after secondary
bootstraps.  A common x86_vendor does not make sense anyway, at least in
principle (the whole cpu_data handling needs a rework but I have no time
to continue what I started last year and nobody else seems to work on it
either).  Wouldn't current_cpu_data.x86_vendor suffice?  That will work
for sure. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

