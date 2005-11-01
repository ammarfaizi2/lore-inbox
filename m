Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964910AbVKAATD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964910AbVKAATD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Oct 2005 19:19:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964914AbVKAATD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Oct 2005 19:19:03 -0500
Received: from gate.crashing.org ([63.228.1.57]:59799 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964910AbVKAATB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Oct 2005 19:19:01 -0500
Subject: Re: Commit "[PATCH] USB: Always do usb-handoff" breaks my powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
In-Reply-To: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 11:16:54 +1100
Message-Id: <1130804214.29054.390.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-10-31 at 16:23 +1100, Paul Mackerras wrote:
> My G4 powerbook gets a machine check on boot as a result of commit
> 478a3bab8c87a9ba4a4ba338314e32bb0c378e62.  Putting a return at the
> start of quirk_usb_early_handoff fixes it.
> 
> The code in quirk_usb_handoff_ohci looks rather bogus in that it
> doesn't do pci_enable_device before trying to access the device.

That and it doesn't test if the BARs are assigned at all, doesn't
request the resources, etc... 

I'm not sure it's legal to do pci_enable_device() from within a pci
quirk anyway. I really wonder what that code is doing in the quirks, I
don't think it's the right place, but I may be wrong.

What is the logic supposed to be there ?

Ben.


