Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265492AbTFSI1J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jun 2003 04:27:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265526AbTFSI1J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jun 2003 04:27:09 -0400
Received: from solen.ce.chalmers.se ([129.16.20.244]:11937 "EHLO
	solen.ce.chalmers.se") by vger.kernel.org with ESMTP
	id S265492AbTFSI1G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jun 2003 04:27:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16113.30505.519963.233275@solen.ce.chalmers.se>
Date: Thu, 19 Jun 2003 10:41:13 +0200
From: Florian-Daniel Otel <otel@ce.chalmers.se>
To: EricAltendorf@orst.edu
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       swsusp-devel@lists.sourceforge.net
Subject: Re: [Swsusp-devel] Re: RTC causes hard lockups in 2.5.70-mm8
In-Reply-To: <200306190031.54686.EricAltendorf@orst.edu>
References: <Pine.LNX.4.55L-032.0306122205210.4915@unix48.andrew.cmu.edu>
	<1055492730.5162.0.camel@dhcp22.swansea.linux.org.uk>
	<200306171232.27887.EricAltendorf@orst.edu>
	<200306190031.54686.EricAltendorf@orst.edu>
X-Mailer: VM 7.07 under 21.4 (patch 12) "Portable Code" XEmacs Lucid
Reply-To: Florian-Daniel Otel <otel@ce.chalmers.se>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org




I can confirm the RTC problems on a Fujitsu LifeBook P2120 (Crusoe
TM5800, ALi, ACPI). In my case I was even more fortunate (??) since
using RTC (either compiled-in in the kernel and/or as a module), any
call to "hwclock" locks the machine rock solid (not even SysRQ
works). So for me the RTC issue is not at all swsusp related.

Back to swsusp: I'm more than happy to annonce that I just discovered
that -pre11 works !! Actually, after reading a bit more closely this
list (*gasp*) and trying the suspend the machine AFTER modules were
unloaded (WLAN, USBs), networking stopped and all non-critical daemons
terminated (basically switching to run-level 1, terminating daemons
and unloading modules), the suspend worked !! And resuming too :)) !!

As such, after a horrible hack of the old  suspend.sh script (from
swsusp-beta17) and using "echo -n 4 > /proc/acpi/sleep" the
suspension+resuming process worked (at least once...).

On less extatic but more useful note: It seems that if I start the
suspending process by hand (i.e. swsusp utility) while PCMCIA and USBs
are stopped but __not__ networking, the resume process freezes. I can
use SysRq+T at this point, but since this is a "legacy free" laptop, I
have no idea how to hook on a serial console there and come w/ a
useful bug report. If anyone has an idea how to do that, I'll be more
than happy to help w/ more testing.


HTH,

Florian

