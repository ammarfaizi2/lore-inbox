Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbTILJbR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 05:31:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTILJbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 05:31:17 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:5590 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S261357AbTILJbQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 05:31:16 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16225.37473.759644.110334@gargle.gargle.HOWL>
Date: Fri, 12 Sep 2003 11:31:13 +0200
From: Mikael Pettersson <mikpe@csd.uu.se>
To: Mathieu Desnoyers <mathieu.desnoyers@polymtl.ca>
Cc: linux-kernel@vger.kernel.org, macro@ds2.pg.gda.pl
Subject: Re: [PATCH][2.4.23-pre3] repair mpparse for default MP systems
In-Reply-To: <20030912031619.GA1310@Krystal>
References: <16224.62817.533540.928220@gargle.gargle.HOWL>
	<20030912031619.GA1310@Krystal>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathieu Desnoyers writes:
 > * Mikael Pettersson (mikpe@csd.uu.se) wrote:
 > > Mathieu,
 > > 
 > > This patch for 2.4.23-pre3 should fix the problems your dual
 > > P5 with default MP config has been having since 2.4.21-pre2.
 > > Please let us know if it works or not.
 > > 
 > > /Mikael
 > > 
 > 
 > Yes, I just tested this patch, and everything seems to work fine. Thank
 > you. :)
 > 
 > The only point I see, which is not triggered on my machine (because of
 > the absence of ACPI) is this one :
 > 
 > There is also an initialization of this mp_irqs variable in
 > mp_config_acpi_legacy_irqs from mpparse.c. It only seems to be called
 > from within acpi_boot_init in acpi.c. So I wonder if it's possible that
 > we do use default configuration and then also go into
 > mp_config_acpi_legacy_irqs during the acpi init, thus reserving the
 > memory twice and forgetting the old pointer, which could lead to an
 > erratic result.
 > 
 > If it's possible, then there is still a problem in there.

I looked through acpi/mpparse/setup and I don't think there is
a problem. acpi does mp_config_acpi_legacy_irqs if it found its
tables, but this is done before get_smp_config, and get_smp_config
bails out early if ACPI already has done the deed. If it were a
problem, it would affect _all_ MP configs not just yours.

I'll submit the patch to Marcelo then, with appropriate explaination.
(No forward port to 2.6 is needed, since the arrays-to-pointers
change hasn't been done there (yet).)

/Mikael
