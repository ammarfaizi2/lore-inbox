Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751018AbWAPSPE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751018AbWAPSPE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 13:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWAPSPE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 13:15:04 -0500
Received: from fmr15.intel.com ([192.55.52.69]:16615 "EHLO
	fmsfmr005.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751018AbWAPSPC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 13:15:02 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] acpi: remove function tracing macros
Date: Mon, 16 Jan 2006 13:14:54 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005B835E4@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] acpi: remove function tracing macros
Thread-Index: AcYWyJ3zpO/6/XK/SRyi17MNhClkogD/VRRQ
From: "Brown, Len" <len.brown@intel.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jan 2006 18:14:56.0580 (UTC) FILETIME=[C1521040:01C61AC8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>From: Pekka Enberg <penberg@cs.helsinki.fi>
>
>This patch removes function tracing macro usage from drivers/acpi/. In
>particular, ACPI_FUNCTION_TRACE are ACPI_FUNCTION_NAME removed 
>completely and return_VALUE, return_PTR, and return_ACPI_STATUS
>are converted with proper use of return.
>
>I have not included the actual patch in this mail because it 
>is 600 KB in size. You can find the patch here:
>
>http://www.cs.helsinki.fi/u/penberg/linux/acpi-remove-function-tracing-macros.patch
>
>Signed-off-by: Pekka Enberg <penberg@cs.helsinki.fi>

I'm sorry, I can't apply this source clean-up patch.

We need tracing to debug interpreter failures on hardware
in the field.

And there is more to the long story, which I'll try to makes short here.

Linux shares the same dual-licensed ACPICA core interpreter with FreeBSD
Apple etc. -- indeed every ACPI-enabled OS other than Windows.
Linux gets a huge benefit from doing so.
In Linux, ACPICA refers to almost all the files under drivers/acpi/*.
(maybe I should re-arrange the source tree to make this more clear)

When we make GPL changes to those files, we diverge
from the rest of the universe and the overloaded
Linux/ACPI maintainer (me) starts to lose his sanity.
That said, if the author of the patch re-licenses it back
to Intel so it can be distributed under eitiher GPL or BSD,
then Intel can apply a change "up-stream" and divergence
can be avoided.  But per above, that isn't the primary
issue with ripping out tracing.

Note that tracing is built in only for CONFIG_ACPI_DEBUG.

Note that Patrick has an upcoming patch set that removes
tracing from the "pure GPL" drivers in drivers/acpi/*.c
where it isn't really needed.

Note that ACPICA 20060113 includes an additional patch
suggested by SuSE to split up CONFIG_ACPI_DEBUG
so that the tracing can be left out and the warnings
included.

thank you for your understanding.

-Len

