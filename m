Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVCXXeE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVCXXeE (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 18:34:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261244AbVCXXeE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 18:34:04 -0500
Received: from gw.goop.org ([64.81.55.164]:41949 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S261243AbVCXXeA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 18:34:00 -0500
Message-ID: <42434E60.1060209@goop.org>
Date: Thu, 24 Mar 2005 15:33:52 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Mozilla Thunderbird 1.0.2-1.3.1 (X11/20050323)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Felix von Leitner <felix-linuxkernel@fefe.de>
Cc: Adam Belay <abelay@novell.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, cpufreq@ZenII.linux.org.uk
Subject: Re: 2.6.11: USB broken on nforce4, ipv6 still broken, centrino speedstep
 even more broken than in 2.6.10
References: <20050311202122.GA13205@fefe.de> <20050311173517.7fe95918.akpm@osdl.org> <1110599659.12485.279.camel@localhost.localdomain> <20050321163225.4af1c169.akpm@osdl.org> <1111454454.6633.5.camel@linux.site> <20050322222943.GA10442@codeblau.de>
In-Reply-To: <20050322222943.GA10442@codeblau.de>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Felix von Leitner wrote:

>>ACPI is the preferred (and only standardized) method of controlling cpu
>>throttling on x86 systems.
>>    
>>
>
>  1. I don't trust ACPI
>  2. my battery runs out quicker with ACPI compared to cpufreq
>
>I _really_ _really_ don't want ACPI.  No, really not.  This is no idle
>decision.  My current notebook is the only hardware I have ever seen
>enabling ACPI not completely break Linux.  Of all my 10+ machines,
>including my other 3 ones that are actually in use.
>  
>
Unfortunately, the Dothans *REQUIRE* some degree of ACPI support; the
speedfreq-centrino needs to extract a table from ACPI to know what are
valid operating (voltage/frequency) points to use for the CPU.  The
patch you're using is definitely wrong in principle, though if it works
for you in practice then by all means use it.

The problem is that there are 4 different voltage grades of Dothan -
VID#A to VID#D - and there doesn't appear to be a way to tell what grade
a CPU is from software at runtime; this is a problem because there's no
one set of voltages you can use across all 4 grades (they have
non-overlapping voltage limits).  It's unknown whether running a Dothan
out of voltage spec will cause reliability problems or damage.

    J
