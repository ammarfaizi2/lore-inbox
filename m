Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271694AbTGREw7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jul 2003 00:52:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271695AbTGREw7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jul 2003 00:52:59 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:45015 "EHLO
	mtvmime03.VERITAS.COM") by vger.kernel.org with ESMTP
	id S271694AbTGREw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jul 2003 00:52:58 -0400
Date: Fri, 18 Jul 2003 06:04:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: "Brown, Len" <len.brown@intel.com>
cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "'ACPI-Devel mailing list'" <acpi-devel@lists.sourceforge.net>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
       "'Marcelo Tosatti'" <marcelo@conectiva.com.br>
Subject: Re: "noht" (RE: ACPI patches updated (20030714))
In-Reply-To: <A5974D8E5F98D511BB910002A50A66470B981269@hdsmsx103.hd.intel.com>
Message-ID: <Pine.LNX.4.44.0307180551060.1319-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Jul 2003, Brown, Len wrote:
> "noht" turns out to be tricky for ACPI in practice.

Thanks a lot for looking into it, Len.
Nice to know I wasn't being too silly when I said it's beyond me now.

> ACPI really shouldn't tinker with or skip LAPIC enumeration.  It can't rely
> on the table LAPIC ids to get packge numbers, and it can't rely on the BIOS
> to have MPS implemented to enumerate physical processors.
> 
> The only reliable way to get the logical/physical mapping is the way
> init_intel() does it today -- run CPUID locally on that logical processor
> after it is up and running.
> 
> So if the kernel is to disable HT, the proper way would be to initialize all
> the logical processors, have them identify themselves, and then optionally
> take themselves off-line.  A possiblity for 2.6.

Yes, a possibility.  But I doubt it'll be worth bothering.

> BIOS SETUP remains the preferred way to disable HT.  If the hardware is
> implemented such that duplicated resources could be combined when HT is
> disabled, only the BIOS would be able to do that -- so single threaded
> performance with Linux implemented 'noht' might lag performance with BIOS
> implemented 'noht'...
> 
> Given that 'noht' is workaround for a missing BIOS switch, I'm not confident
> it is a win to burden the Linux kernel with it.

I imagine we could still retain it when going the acpitable.c route;
but I'd prefer to be consistent across the ways, and just remove all
traces of "noht" now (a boot option to mask off the "ht" flag from
cpuinfo, its current role, is definitely not worth retaining).

Hugh

