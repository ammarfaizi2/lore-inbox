Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264633AbUEOCjf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264633AbUEOCjf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 22:39:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264642AbUEOCjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 22:39:33 -0400
Received: from zeus.kernel.org ([204.152.189.113]:34547 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S264633AbUEOChy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 22:37:54 -0400
Subject: Re: peculiar problem with 2.6, 8139too + ACPI
From: Len Brown <len.brown@intel.com>
To: Robert Fendt <fendt@physik.uni-dortmund.de>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
References: <A6974D8E5F98D511BB910002A50A6647615FB5FE@hdsmsx403.hd.intel.com>
Content-Type: text/plain
Organization: 
Message-Id: <1084584998.12352.306.camel@dhcppc4>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.3 
Date: 14 May 2004 21:36:38 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-05-14 at 09:28, Robert Fendt wrote:

> I have the following problem: the 8139too driver produces lots of
> overruns and is _very_ slow (but strangely not always; the problem
> seems to be site-dependant, too). And here is what is weird: if I
> artifically raise the system load (e.g. compile a kernel just for
> fun), the download speed grows by at least an order of magnitude.

It is possible that the system is getting into a high power saving
mode on idle.  Device bus master activity or interrupts will wake
it up -- but the latency to return from power savings mode may be
so high that the device experiences receive buffer overruns.

Some devices handle this latency better than others,
and with a network, dropping RX packets can cause the
connection to thrash, and it seems that is what you see.

If the 8139too has statistics counters showing if it gets
RX buffer over-runs, that would be interseting to observe.

Also, to see what idle power saving states you have, their
latency and their usage, please do this:
cat /proc/acpi/processor/CPU0/power

It would also be interesting to know if you see the problem
more frequently when running on battery power, since some
systems have higher c-state exit latency when on battery.

It would also be interesting to know if you see the same
frequency of the problem on 2.4, since it has 100HZ clock
vs 1000HZ clock on 2.6 -- and this can have a significant
effect on the effectivness of idle c-states.

cheers,
-Len


