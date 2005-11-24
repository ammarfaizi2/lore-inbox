Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932608AbVKXB1V@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932608AbVKXB1V (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 20:27:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932609AbVKXB1V
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 20:27:21 -0500
Received: from gate.crashing.org ([63.228.1.57]:50661 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S932608AbVKXB1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 20:27:20 -0500
Subject: Re: [PATCH] Fix USB suspend/resume crasher
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, David Brownell <david-b@pacbell.net>,
       Paul Mackerras <paulus@samba.org>,
       linuxppc-dev list <linuxppc-dev@ozlabs.org>,
       Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
       Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <200511240122.46125.rjw@sisk.pl>
References: <1132715288.26560.262.camel@gaston>
	 <200511240122.46125.rjw@sisk.pl>
Content-Type: text/plain
Date: Thu, 24 Nov 2005 12:23:15 +1100
Message-Id: <1132795396.26560.382.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Unfortunately with this patch the EHCI controller in my box (Asus L5D,
> x86-64 kernel) does not resume from suspend.  Appended is the relevant
> snippet from the serial console log (EHCI is the only device using IRQ #5).

Hrm... let me see... You are getting an interrupt for EHCI after it has
been resumed, so it should work.

 /me double-checks the patch

> ehci_hcd 0000:00:02.2: lost power, restarting

Hrm... I can't find that line in the code...

 /me rechecks with david's other patches

Ah ... I see it. There might have been some screwup between david's
patch and mine.

Make sure that 

       set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);

Is still done before anything else in ehci_pci_resume(). It may be worth
following it with a memory barrier actually... just in case (due to the
absence of locks in that area).

Ben.


