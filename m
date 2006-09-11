Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964854AbWIKAbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964854AbWIKAbg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Sep 2006 20:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964853AbWIKAbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Sep 2006 20:31:36 -0400
Received: from cavan.codon.org.uk ([217.147.92.49]:19157 "EHLO
	vavatch.codon.org.uk") by vger.kernel.org with ESMTP
	id S964839AbWIKAbf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Sep 2006 20:31:35 -0400
Date: Mon, 11 Sep 2006 01:31:29 +0100
From: Matthew Garrett <mjg59@srcf.ucam.org>
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, ak@suse.de
Subject: io-apic - no timer ticks after resume on IXP200
Message-ID: <20060911003129.GA10600@srcf.ucam.org>
References: <20060910141533.GA6594@srcf.ucam.org> <20060910205803.GA1966@elf.ucw.cz> <20060910212045.GA9278@srcf.ucam.org> <20060910223308.GA1691@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060910223308.GA1691@elf.ucw.cz>
User-Agent: Mutt/1.5.9i
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: mjg59@codon.org.uk
X-SA-Exim-Scanned: No (on vavatch.codon.org.uk); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Cc:ing Andi because I seem to remember him reworking the code for this 
chipset)

Got it. After a suspend/resume cycle, I no longer have any timer ticks. 
Unsurprisingly, this breaks things. This is even true if I stub out the 
actual suspend code - that is, simply calling the device suspend and 
resume methods fails to set up the timer again properly.

So the situation is the following: without acpi_skip_timer_override, 
the system works fine until suspend/resume. At that point, I no longer 
get any timer ticks. With acpi_skip_timer_override, the timer works fine 
before and after suspend. I suspect that something in the apic 
suspend/resume code isn't setting things correctly? Is there any useful 
debug output I can provide?
-- 
Matthew Garrett | mjg59@srcf.ucam.org
