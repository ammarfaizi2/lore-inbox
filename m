Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310468AbSCUXjg>; Thu, 21 Mar 2002 18:39:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310469AbSCUXj0>; Thu, 21 Mar 2002 18:39:26 -0500
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:30673 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP
	id <S310468AbSCUXjO>; Thu, 21 Mar 2002 18:39:14 -0500
Date: Fri, 22 Mar 2002 00:36:02 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Mikael Pettersson <mikpe@csd.uu.se>
cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org,
        marcelo@conectiva.com.br, torvalds@transmeta.com
Subject: Re: [PATCH] boot_cpu_data corruption on SMP x86
In-Reply-To: <200203212117.WAA22504@harpo.it.uu.se>
Message-ID: <Pine.GSO.3.96.1020322002809.1646C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Mar 2002, Mikael Pettersson wrote:

> > This is broken -- these word stores assure a proper initialization on
> >pre-CPUID processors.
> 
> boot_cpu_data is a static-extent object with an explicit initialiser
> (i.e., ".data") in setup.c in 2.2.21rc2, 2.4.19-pre4, and 2.5.7.
> Any further "initialisation" by APs is called "clobbering".

 boot_cpu_data is initialized and then copied to cpu_data for each CPU
booted.  If say the BSP supports cpuid but an AP does not (possible for an
i486 setup), leftover values will be stored for the AP incorrectly.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

