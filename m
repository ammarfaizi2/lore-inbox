Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751174AbWAPUBy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751174AbWAPUBy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jan 2006 15:01:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751172AbWAPUBy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jan 2006 15:01:54 -0500
Received: from fmr14.intel.com ([192.55.52.68]:63896 "EHLO
	fmsfmr002.fm.intel.com") by vger.kernel.org with ESMTP
	id S1751156AbWAPUBx convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jan 2006 15:01:53 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.5.7226.0
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] acpi: remove function tracing macros
Date: Mon, 16 Jan 2006 15:01:46 -0500
Message-ID: <F7DC2337C7631D4386A2DF6E8FB22B3005B8388F@hdsmsx401.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] acpi: remove function tracing macros
Thread-Index: AcYazTugRYK0jp1nRH2pxWFu3EZoDQACOcgg
From: "Brown, Len" <len.brown@intel.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Cc: <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
X-OriginalArrivalTime: 16 Jan 2006 20:01:49.0566 (UTC) FILETIME=[AFC211E0:01C61AD7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
>I appreciate that but per-function tracing is overkill.

I agree that 100% function coverage is overkill.
However, 100% is preferable to 0%.
The most desirable middle-ground will take some work
on the part of the folks that actually use the tracing.

>Especially since
>the macros used for it are very obfuscating (i.e. return_VALUE, et al)
>and we have things like kprobes.

Everybody agreees with you about the return_VALUE syntax.
The other irritating thing about this instrumentation is
that the function trace header looks like a call, but
is actually a declaration -- so sometimes DEBUG builds
break when executable code is put before it.  The fortunate
thing is that a relatively small group of people make
changes to the ACPI sub-system and this is one of the
things they learn about quickly:-)

If kprobes can give us the same functionality,
I'll be delighted if somebody can show me how.

>On Mon, 2006-01-16 at 13:14 -0500, Brown, Len wrote:
>> When we make GPL changes to those files, we diverge
>> from the rest of the universe and the overloaded
>> Linux/ACPI maintainer (me) starts to lose his sanity.
>> That said, if the author of the patch re-licenses it back
>> to Intel so it can be distributed under eitiher GPL or BSD,
>> then Intel can apply a change "up-stream" and divergence
>> can be avoided.  But per above, that isn't the primary
>> issue with ripping out tracing.
>> 
>> Note that tracing is built in only for CONFIG_ACPI_DEBUG.
>
>My main concern is that the ACPI subsystem uses obfuscating macros to
>implement function tracing in the kernel. Please note that we do not
>allow this in new code and there are janitor such as myself that are
>working to remove the existing ones.
>
>While I have no intention of making your life as Linux maintainer
>harder, I would appreciate if you would at least consider ripping out
>function tracing from upstream. I am certainly willing to relicense or
>even transfer copyrights of the patch if that's what you need.

I share your concern about source code style.
Note that as I mentioned, we've got some changes in the pipeline
to clean up drivers/acpi/*.c already.
Changing this in the upstream interpreter in drivers/acpi/*/
will be harder and will take longer.

thanks,
-Len
