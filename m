Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263526AbTKQStl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:49:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263583AbTKQStk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:49:40 -0500
Received: from fmr05.intel.com ([134.134.136.6]:45548 "EHLO
	hermes.jf.intel.com") by vger.kernel.org with ESMTP id S263526AbTKQStj convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:49:39 -0500
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-MimeOLE: Produced By Microsoft Exchange V6.0.6487.1
Subject: Re:  format_cpumask()
Date: Mon, 17 Nov 2003 10:49:31 -0800
Message-ID: <B8E391BBE9FE384DAA4C5C003888BE6F0F37B0@scsmsx401.sc.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: Re:  format_cpumask()
Thread-Index: AcOtO4lKAiUS+OJFTLWLH0uYULapvg==
From: "Luck, Tony" <tony.luck@intel.com>
To: <linux-kernel@vger.kernel.org>
Cc: <wli@holomorphy.com>
X-OriginalArrivalTime: 17 Nov 2003 18:49:32.0701 (UTC) FILETIME=[8A08BCD0:01C3AD3B]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> +	for (k = sizeof(cpumask_t)/sizeof(long) - 1; k >= 0; ++k) {
> +		int m;
> +		cpumask_t tmp;
> +
> +		cpus_shift_right(tmp, cpus, BITS_PER_LONG*k);
> +		if (BITS_PER_LONG == 32)
> +			m = sprintf(buf, "%08lx", cpus_coerce(tmp));
> +		else /* BITS_PER_LONG == 64 */
> +			m = sprintf(buf, "%16lx", cpus_coerce(tmp));
> +		len += m;
> +		buf += m;
> +	}

That makes it had to write portable shell scripts (etc.) that can
parse these values on both 32-bit and 64-bit systems?  A bitmask with
just cpu0 set looks like:

	0000000100000000

on a 32-bit machine.  And like:

	0000000000000001

on a 64-bit machine.  Heaven help the architectures (ia64, sparc, ppc)
that support both 32-bit and 64-bit applications!

-Tony Luck  

