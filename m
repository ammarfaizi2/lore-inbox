Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbTGHJDa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 05:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266902AbTGHJDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 05:03:30 -0400
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:7421 "EHLO
	delta.ds2.pg.gda.pl") by vger.kernel.org with ESMTP id S265572AbTGHJD3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 05:03:29 -0400
Date: Tue, 8 Jul 2003 11:17:51 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: john stultz <johnstul@us.ibm.com>
cc: marcelo <marcelo@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       lkml <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] linux-2.4.22-pre3_clear-smi-fix_A0
In-Reply-To: <1057614898.27380.86.camel@w-jstultz2.beaverton.ibm.com>
Message-ID: <Pine.GSO.3.96.1030708111039.18238B-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 Jul 2003, john stultz wrote:

> 	Some of our more recent hardware requires that SMIs are routed through
> the IOAPIC, thus when we clear_IO_APIC() at boot time, we clear the BIOS
> initialized SMI pin. This basically clobbers the SMI, which can cause
> problems with console redirection as well keeping us from being able to
> transition into full ACPI mode. 

 That should be appropriately marked in the MP-table -- is it?  I think
clear_IO_APIC() should use the MP-table to select pins marked as mp_INT
(and possibly mp_ExtINT) only.  This way all special inputs are preserved.

 Your solution looks like a good hack for working around a broken
MP-table, but then a big fat warning should be printed about a BIOS bug.

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

