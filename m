Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266517AbUIXA7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266517AbUIXA7t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 20:59:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267679AbUIXA4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 20:56:07 -0400
Received: from fmr12.intel.com ([134.134.136.15]:45184 "EHLO
	orsfmr001.jf.intel.com") by vger.kernel.org with ESMTP
	id S266517AbUIXAtl convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 20:49:41 -0400
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Date: Thu, 23 Sep 2004 17:48:18 -0700
Message-ID: <7F740D512C7C1046AB53446D3720017302495C07@scsmsx402.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to fit 32byte cacheline]
Thread-Index: AcShyl2Bl37xnPJMRme0ivVdav77DQAAsvqw
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: "Marcelo Tosatti" <marcelo.tosatti@cyclades.com>
Cc: <linux-kernel@vger.kernel.org>, <akpm@osdl.org>, <arjanv@redhat.com>,
       <ak@suse.de>, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>
X-OriginalArrivalTime: 24 Sep 2004 00:48:21.0023 (UTC) FILETIME=[30623AF0:01C4A1D0]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From: Marcelo Tosatti [mailto:marcelo.tosatti@cyclades.com]
>Sent: Thursday, September 23, 2004 3:32 PM
>To: Nakajima, Jun
>Cc: linux-kernel@vger.kernel.org; akpm@osdl.org; arjanv@redhat.com;
>ak@suse.de; Saxena, Sunil; Mallick, Asit K
>Subject: Re: [arjanv@redhat.com: Re: [PATCH] shrink per_cpu_pages to
fit
>32byte cacheline]
>

<snip>

>> >***********
>> >
>> >Jun,
>> >
>> >We need some assistance here - you can probably help us.
>> >
>> >Within the Linux kernel we can benefit from changing some fields
>> >of commonly accessed data structures to 16 bit instead of 32 bits,
>> >given that the values for these fields never reach 2 ^ 16.
>> >
>> >Arjan warned me, however, that the prefix (in this case "data16")
will
>> >cause an additional extra cycle in instruction decoding, per message
>> above.
>>
>> On the Pentium4 core, this is not a big deal because it runs out of
the
>> trace cache (i.e. decoded in advance). However, on the Pentium III/M
>> (aka P6) core (i.e. Penitum III, Banias, Dothan, Yonah, etc.),
>> especially when an operand size prefix (0x66) changes the # of bytes
in
>> an instruction (usually by impacting the size of an immediate in the
>> instruction), the P6 core pays unnegligible penalty, slowing down
>> decoding.
>
>Jun,
>
>What you mean by "unnegligible penalty" ?
>
>You mean its very small penalty (unconsiderable), or its considerable
>penalty?

I mean it's considerable. Did you look at what kinds of instructions are
used for accessing such data structures? Does the operand size prefix
change the # of bytes in those instructions (as described above) for
most cases? If it does, we don't recommend such codes.

Jun

>> an instruction

>
>We are use one less cacheline for a very commonly used structure.
>

