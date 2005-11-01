Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964961AbVKAFLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964961AbVKAFLU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Nov 2005 00:11:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964966AbVKAFLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Nov 2005 00:11:20 -0500
Received: from gate.crashing.org ([63.228.1.57]:1691 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S964961AbVKAFLT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Nov 2005 00:11:19 -0500
Subject: Re: [linux-usb-devel] Re: Commit "[PATCH] USB: Always do
	usb-handoff" breaks my powerbook
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Cc: David Brownell <david-b@pacbell.net>,
       linux-usb-devel@lists.sourceforge.net,
       Alan Stern <stern@rowland.harvard.edu>, linux-kernel@vger.kernel.org
In-Reply-To: <17254.62622.780185.729677@cargo.ozlabs.ibm.com>
References: <17253.43605.659634.454466@cargo.ozlabs.ibm.com>
	 <200510311909.32694.david-b@pacbell.net>
	 <1130815836.29054.420.camel@gaston>
	 <200510312017.39915.david-b@pacbell.net>
	 <17254.62622.780185.729677@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Tue, 01 Nov 2005 16:08:04 +1100
Message-Id: <1130821684.29054.434.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-01 at 15:52 +1100, Paul Mackerras wrote:
> David Brownell writes:
> 
> > Maybe you should first pay attention to what I pointed out:  that
> > the problem reports I've seen have ONLY been on PPC systems.
> 
> Well, there is a problem in the code which is clearly visible just by
> inspection: that it is touching a pci device without having called
> pci_enable_device on it.  That is well known to cause problems on many
> platforms, and it is not guaranteed to work on any platform.
> 
> With a clearly visible bug like that in there, it doesn't matter what
> platform(s) the problem is reported on.

Yup, though I agree that considering the purpose of that code, it might
make sense for it to just "peek" to check if the device was enabled
rather than force-enabling it. If it was not, there is obviously no
handoff to do from the BIOS.

Ben.


