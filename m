Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbTFJLI7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 07:08:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261876AbTFJLI7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 07:08:59 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:55282 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S261843AbTFJLI6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 07:08:58 -0400
Date: Tue, 10 Jun 2003 13:20:12 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Zwane Mwaikambo <zwane@linuxpower.ca>
cc: "Brian J. Murrell" <brian@interlinx.bc.ca>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: local apic timer ints not working with vmware: nolocalapic
In-Reply-To: <Pine.LNX.4.50.0306092112250.19137-100000@montezuma.mastecende.com>
Message-ID: <Pine.GSO.3.96.1030610130024.19547D-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 9 Jun 2003, Zwane Mwaikambo wrote:

> >  Why do you consider the systems broken?
> 
> Not necessarily broken, just no reporting of APIC capability. Not that i 
> should expect better from Intel (c.f. HT bit, SEP on PPro etc)

 Hmm, how could e.g. an i486 report it?  Remember, the i82489DX is a
discrete APIC implementation, i.e. it's a chip external to the CPU.  The
i82489DX is actually a complete APIC implementation, including both a
local and an I/O unit in a single chip.  And it's also superior to
integrated APIC implementations -- it can address up to 255 units in the
physical destination mode and up to 32 ones in the logical one.

 These APICs were used for i486 systems as well as for Pentium ones meant
to support more than two CPUs (although the Pentium integrated local APICs
can probably support more than two such units in a system, there was no
suitable I/O unit available; the i82093AA chip was introduced later and
the i82489DX is hardware-incompatible to later implementations, e.g. 
using a five-wire inter-APIC bus).

> How about we only clear smp_found_config when forced.

 Looks OK.  Probably a message could be added to report handling of the
local APIC got disabled. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

