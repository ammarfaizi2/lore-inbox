Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261566AbVADIvW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261566AbVADIvW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Jan 2005 03:51:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261567AbVADIvV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Jan 2005 03:51:21 -0500
Received: from main.gmane.org ([80.91.229.2]:61650 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S261566AbVADIvL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Jan 2005 03:51:11 -0500
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Martin Lucina <mato@kotelna.sk>
Subject: Re: [PATCH] swsusp: properly suspend and resume *all* devices
Date: Tue, 4 Jan 2005 08:44:04 +0000 (UTC)
Message-ID: <loom.20050104T093741-631@post.gmane.org>
References: <20041228144741.GA2969@butterfly.hjsoft.com> <20050101172344.GA1355@elf.ucw.cz> <20050102055753.GB7406@ip68-4-98-123.oc.oc.cox.net> <20050102184239.GA21322@butterfly.hjsoft.com> <1104696556.2478.12.camel@pefyra> <20050103051018.GA4413@ip68-4-98-123.oc.oc.cox.net> <20050103084713.GB2099@elf.ucw.cz> <20050103101423.GA4441@ip68-4-98-123.oc.oc.cox.net> <20050103150505.GA4120@ip68-4-98-123.oc.oc.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 217.67.24.115 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041128 Firefox/1.0 (Debian package 1.0-4))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Barry,

Barry K. Nathan <barryn <at> pobox.com> writes:
 
> swsusp does not suspend and resume *all* devices, including system
> devices. This has been the case since at least 2.6.9, if not earlier.
> 
> One effect of this is that resuming fails to properly reconfigure
> interrupt routers. In 2.6.9 this was obscured by other kernel code,
> but in 2.6.10 this often causes post-resume APIC errors and near-total
> failure of some PCI devices (e.g. network, sound and USB controllers).

I'm seeing a variation (?) of this problem with 2.6.10. I have the same symptoms
as you describe above, but on a machine without an APIC, using APM for
suspend/resume. (Toshiba Portege 7220cte, which has an Intel 440BX chipset)

Obviously, I don't get the APIC errors, but everything else is the same, random
devices fail and need to be reloaded (3c59x and uhci-hcd in particular), plus
the system appears to panic somewhere along the way to resume occasionally (as I
assume from the hung machine and blinking CAPS LOCK), which didn't happen
previously (2.6.9, 2.6.8.1, ...). I also see lots of 

drivers/usb/input/hid-core.c: input irq status -84 received

until I do a 'rmmod uhci_hcd; modprobe uhci_hcd'. This used to happen with 2.6.9
as well, but the system would recover after about 20 messages or so like this
after a resume.

Any suggestions about where to look to track this down?

-mato

