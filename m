Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261588AbTIXV5U (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Sep 2003 17:57:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbTIXV5U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Sep 2003 17:57:20 -0400
Received: from fmr09.intel.com ([192.52.57.35]:22486 "EHLO hermes.hd.intel.com")
	by vger.kernel.org with ESMTP id S261588AbTIXV5O convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Sep 2003 17:57:14 -0400
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: RE: HT not working by default since 2.4.22
Date: Wed, 24 Sep 2003 17:56:57 -0400
Message-ID: <BF1FE1855350A0479097B3A0D2A80EE0CC8708@hdsmsx402.hd.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: HT not working by default since 2.4.22
Thread-Index: AcOBb0xRBcZcIEOcQpmli0QiRzF8awBcvVPg
From: "Brown, Len" <len.brown@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com.br>
Cc: <linux-kernel@vger.kernel.org>, "Alan Cox" <alan@lxorguk.ukuu.org.uk>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Jeff Garzik" <jgarzik@pobox.com>
X-OriginalArrivalTime: 24 Sep 2003 21:56:58.0529 (UTC) FILETIME=[C6C36910:01C382E6]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, so what to do?

We could make 2.4.23 like 2.4.21 where ACPI code for HT is included in
the kernel even when CONFIG_ACPI is not set.

Or we could leave 2.4.23 like 2.4.22 where disabling CONFIG_ACPI really
does remove all ACPI code in the kernel; and when CONFIG_ACPI is set,
CONFIG_ACPI_HT_ONLY is available to limit ACPI to just the tables part
needed for HT.

I'd prefer the later (doing nothing) because CONFIG_ACPI really should
exclude all of ACPI.  If we start including bits of ACPI without
CONFIG_ACPI, where do we stop?

I'm not sure how to address "compatibility" and "regression" concepts in
the face of changing config files.  Make oldconfig will ask you about
CONFIG_ACPI -- perhaps I should update the help text to emphasize that
it is necessary for HT, and that if selected, CONFIG_ACPI_HT_ONLY is
then available?

Is defconfig used?  Does it define "compatibility"?  If so, we could
define CONFIG_ACPI && CONFIG_ACPI_HT_ONLY in defconfig to get the 2.4.21
behavior -- then could have our cake and eat it too.

I don't feel strongly about which way to go, but I will want to keep 2.4
and 2.6 as similar as possible in this area.

Thanks,
-Len


> -----Original Message-----
> From: Jeff Garzik [mailto:jgarzik@pobox.com] 
> Sent: Monday, September 22, 2003 1:55 PM
> To: Brown, Len
> Cc: Marcelo Tosatti; linux-kernel@vger.kernel.org; Alan Cox; 
> Nakajima, Jun
> Subject: Re: HT not working by default since 2.4.22
> 
> 
> On Mon, Sep 22, 2003 at 01:28:03PM -0400, Brown, Len wrote:
> > If somebody has a 2.4.22 system where CONFIG_ACPI_HT_ONLY plus zero
> > cmdline parameters doesn't result in HT running and no ACPI running,
> > then please forward the details directly to me.
> 
> The old acpitable.[ch] was unconditionally enabled...  So _not_
> unconditionally enabling HT was a regression.
> 
> (just pointing out a fact;  I actually prefer a CONFIG_xxx)
> 
> 	Jeff
> 
> 
> 
> 
