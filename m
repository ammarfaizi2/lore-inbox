Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966576AbWKOEYJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966576AbWKOEYJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 23:24:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966580AbWKOEYJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 23:24:09 -0500
Received: from srv5.dvmed.net ([207.36.208.214]:53983 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S966576AbWKOEYH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 23:24:07 -0500
Message-ID: <455A9664.50404@garzik.org>
Date: Tue, 14 Nov 2006 23:24:04 -0500
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
CC: torvalds@osdl.org, linux-kernel@vger.kernel.org, tiwai@suse.de
Subject: Re: [PATCH] ALSA: hda-intel - Disable MSI support by default
References: <20061114.192117.112621278.davem@davemloft.net>	<Pine.LNX.4.64.0611141935390.3349@woody.osdl.org>	<455A938A.4060002@garzik.org> <20061114.201549.69019823.davem@davemloft.net>
In-Reply-To: <20061114.201549.69019823.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.7 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David Miller wrote:
> Is this absolutely true?  I've never been sure about this point, and I
> was rather convinced after reading various documents that once you
> program up the MSI registers to start generating MSI this implicitly
> disabled INTX and this was even in the PCI specification.
> 
> It would be great to get a definitive answer on this.
> 
> If it is mandatory, perhaps the driver shouldn't be doing it and
> rather the PCI layer MSI enabling should.


I can't answer for the spec, but at least two independent device vendors 
recommended to write an MSI driver that way (disable intx, enable msi).

Completely independent of MSI though, a PCI 2.2 compliant driver should 
be nice and disable intx on exit, just to avoid any potential interrupt 
hassles after driver unload.  And of course be aware that it might need 
to enable intx upon entry.

	Jeff


