Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261928AbTIZEzo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 00:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261930AbTIZEzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 00:55:44 -0400
Received: from fmr09.intel.com ([192.52.57.35]:32239 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261928AbTIZEzn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 00:55:43 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HT not working by default since 2.4.22
Date: Fri, 26 Sep 2003 00:54:44 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8718@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not working by default since 2.4.22
Thread-Index: AcOD4Xflq5mph2OcS1iIwaa0WhZ6JAAB6b6w
From: "Brown, Len" <len.brown@intel.com>
To: "Jeff Garzik" <jgarzik@pobox.com>
Cc: <marcelo@parcelfarce.linux.theplanet.co.uk>,
       "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>,
       <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>
X-OriginalArrivalTime: 26 Sep 2003 04:54:45.0896 (UTC) FILETIME=[4E7DD080:01C383EA]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Now that I've thought of it (aren't I humble), I rather like 
> CONFIG_HT.
> It's simple and it's effects should be obvious to both developer and
> user:
> 
> 	CONFIG_HT, CONFIG_ACPI == ACPI
> 	!CONFIG_HT, CONFIG_ACPI == ACPI
> 	CONFIG_HT, !CONFIG_ACPI == HT-only ACPI
> 	!CONFIG_HT, !CONFIG_ACPI == no ACPI
> 
> Following the "autoconf model", what we really want to be testing with
> CONFIG_xxx is _features_, where possible. "hyperthreading: yes/no" is
> IMO more clear than "do I want ht-only ACPI or full ACPI", 
> while at the
> same time being more fine-grained and future-proof.

I like positive logic too.
I went so far as to try to implement this back when I deleted "noht".

The problem is that "!CONFIG_HT" is meaningless.  It implies that
you can have CONFIG_ACPI but still "config-out" HT, which you can't.

Ie. The 2nd row above says to give me ACPI w/o HT.
If you delete that row and reverse the polarity you get:

!CONFIG_ACPI_HT_ONLY, CONFIG_ACPI == ACPI
CONFIG_ACPI_HT_ONLY, !CONFIG_ACPI == HT-only ACPI
!CONFIG_ACPI_HT_ONLY, !CONFIG_ACPI == no ACPI

Here we can use config to emphasize that it is not possible to select
CONFIG_ACPI and CONFIG_ACPI_HT_ONLY at the same time.

Cheers,
-Len

Ps. Note that in 2.6 CONFIG_X86_HT exists and covers the sibling code.
It depends on CONFIG_SMP, and CONFIG_ACPI_HT_ONLY depends on it. (in the
ACPI patch)
