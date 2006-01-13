Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161644AbWAMDSK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161644AbWAMDSK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 22:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161642AbWAMDSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 22:18:10 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:47787 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1161644AbWAMDSI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 22:18:08 -0500
Subject: Re: 2.6.15-rt4 failure with LATENCY_TRACE on x86_64
From: Steven Rostedt <rostedt@goodmis.org>
To: Clark Williams <clark.williams@gmail.com>
Cc: Ingo Molnar <mingo@elte.hu>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1137103652.11354.40.camel@localhost.localdomain>
References: <1137103652.11354.40.camel@localhost.localdomain>
Content-Type: text/plain
Date: Thu, 12 Jan 2006 22:18:00 -0500
Message-Id: <1137122280.7338.6.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-01-12 at 16:07 -0600, Clark Williams wrote:
> Ingo/Steve,
> 
> Did I miss a "Don't turn on latency tracing for x86_64" message
> somewhere?
> 
> I'm seeing a failure on my Athlon64 3000+ where, when I turn on
> CONFIG_LATENCY_TRACE, the init program segfaults. Doesn't happen with a
> statically linked shell like sash (e.g. init=/sbin/sash boots ok), but
> if /sbin/init or /bin/sh is used, the init program segfaults. Presumably
> any dynamically linked program will fail. 
> 
> Attached is console output for a boot failure (segfault messages
> truncated after four lines, since they're all the same) as well as the
> config files for both working and failing kernels.
> 
> I'm not sure where to start looking on this one. Barring any advise, I'm
> going to look for occurrences of CONFIG_LATENCY_TRACE, especially in
> proximity to exec.

OK, I'm actually sending you this email on a x86_64 running
2.6.15-rt4-sr2, with latency tracing on.  But unfortunately, I have a
AMD X2 that each core has it's own tsc counter that is not in sync, and
since the latency tracer uses tsc, I get garbage.  But beware, the tsc
does slow down when the cpu idles, so it gives bad results even for non
x2 systems.

I finally was able to boot this with using the PM timer, but the
beginning of my dmesg is still filled with:

read_tsc: ACK! TSC went backward! Unsynced TSCs?

Have you tried booting with idle=poll? I wonder if that would help?

-- Steve


