Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271679AbTGRByi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 21:54:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271677AbTGRByi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 21:54:38 -0400
Received: from fmr01.intel.com ([192.55.52.18]:42715 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id S271680AbTGRByc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 21:54:32 -0400
Message-ID: <A5974D8E5F98D511BB910002A50A66470B981269@hdsmsx103.hd.intel.com>
From: "Brown, Len" <len.brown@intel.com>
To: "'Hugh Dickins'" <hugh@veritas.com>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'ACPI-Devel mailing list'" <acpi-devel@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Subject: "noht" (RE: ACPI patches updated (20030714))
Date: Thu, 17 Jul 2003 19:14:58 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"noht" turns out to be tricky for ACPI in practice.

ACPI really shouldn't tinker with or skip LAPIC enumeration.  It can't rely
on the table LAPIC ids to get packge numbers, and it can't rely on the BIOS
to have MPS implemented to enumerate physical processors.

The only reliable way to get the logical/physical mapping is the way
init_intel() does it today -- run CPUID locally on that logical processor
after it is up and running.

So if the kernel is to disable HT, the proper way would be to initialize all
the logical processors, have them identify themselves, and then optionally
take themselves off-line.  A possiblity for 2.6.

BIOS SETUP remains the preferred way to disable HT.  If the hardware is
implemented such that duplicated resources could be combined when HT is
disabled, only the BIOS would be able to do that -- so single threaded
performance with Linux implemented 'noht' might lag performance with BIOS
implemented 'noht'...

Given that 'noht' is workaround for a missing BIOS switch, I'm not confident
it is a win to burden the Linux kernel with it.

Cheers,
-Len


> -----Original Message-----
> From: Brown, Len 
> Sent: Tuesday, July 15, 2003 10:36 PM
> To: 'Hugh Dickins'
> Cc: Grover, Andrew; ACPI-Devel mailing list; 
> linux-kernel@vger.kernel.org; Marcelo Tosatti
> Subject: RE: ACPI patches updated (20030714)
> 
> 
> > From: Hugh Dickins [mailto:hugh@veritas.com] 
> 
> > > 		ACPI && !ACPI_HT_ONLY
> > > 			Full ACPI w/o the acpi=cpu option
> > 
> > Shouldn't this combination also support "noht", or is that 
> > too much to ask?
> 
> Can do.  It will be called CONFIG_ACPI_HT, and will be 
> required for ACPI to enable HT -- with or without the full 
> CONFIG_ACPI.
> 
> Cheers,
> -Len
> 
