Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293339AbSCOVlX>; Fri, 15 Mar 2002 16:41:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293341AbSCOVlF>; Fri, 15 Mar 2002 16:41:05 -0500
Received: from zero.tech9.net ([209.61.188.187]:28422 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S293286AbSCOVkt>;
	Fri, 15 Mar 2002 16:40:49 -0500
Subject: RE: [OOPS] Kernel powerdown
From: Robert Love <rml@tech9.net>
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Alan Cox'" <alan@lxorguk.ukuu.org.uk>, reality@delusion.de,
        linux-kernel@vger.kernel.org
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D01@orsmsx111.jf.intel.com>
In-Reply-To: <59885C5E3098D511AD690002A5072D3C02AB7D01@orsmsx111.jf.intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.2.99 Preview Release
Date: 15 Mar 2002 16:40:41 -0500
Message-Id: <1016228442.904.55.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-03-15 at 16:30, Grover, Andrew wrote:

> Theoretically we should be turning the machine off, after which I'm pretty
> sure the NMI watchdog shouldn't be an issue :) but IIRC we are masking
> interrupts and doing some delays before turning off, so the NMI watchdog
> might not be liking that? APM doesn't turn off the NMI afaik so why should
> ACPI have to?

Hm, is the period with interrupts off during shutdown much greater with
ACPI than with APM?  Maybe it is just simply that ...

You could sprinkle calls to
	touch_nmi_watchdog()
in the ACPI shutdown code and see if the problem goes away ...

I am also curious about Andrew's question - does the system properly
shutdown without nmi-watchdog?  The case could be that interrupts are
disabled and ACPI then goes to shut the system down, fails, and the
system just sits (like, say, a Windows 9x machine :>) and finally the
watchdog causes an OOPS.  This seems most likely, in fact.

	Robert Love

