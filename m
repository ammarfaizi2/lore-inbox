Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261843AbUK2WdS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261843AbUK2WdS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:33:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261845AbUK2WdS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:33:18 -0500
Received: from gate.crashing.org ([63.228.1.57]:45962 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261843AbUK2W1U (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:27:20 -0500
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second
	take)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin.lkml@colino.net>
Cc: David Brownell <david-b@pacbell.net>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041129090406.5fb31933@pirandello>
References: <20041126113021.135e79df@pirandello>
	 <200411260928.18135.david-b@pacbell.net>
	 <20041126183749.1a230af9@jack.colino.net>
	 <200411260957.52971.david-b@pacbell.net> <1101507130.28047.29.camel@gaston>
	 <20041129090406.5fb31933@pirandello>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 09:26:23 +1100
Message-Id: <1101767183.15463.17.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 09:04 +0100, Colin Leroy wrote:
> On 27 Nov 2004 at 09h11, Benjamin Herrenschmidt wrote:
> 
> Hi, 
> 
> > > > It's probably a linux-wlan-ng issue... 
> > > 
> > > I suspect PPC resume issues myself.
> > 
> > Colin, you didn't tell us which controller it was ? The NEC one is a
> > totally normal off-the-shelves controller coming out of D3. The Apple
> > ones are a bit special tho.
> 
> It's the ibook G4's controller:
> [colin@jack ~]$ for i in 1 2 3 4; do cat /sys/bus/usb/devices/usb$i/product; done;
> NEC Corporation USB 2.0
> Apple Computer Inc. KeyLargo/Intrepid USB (#3)
> NEC Corporation USB
> NEC Corporation USB (#2)

Hrm... there is some problem in communication here. I asked you which
controller out of the 3 OHCIs you have in this machine is the culprit,
you give me a list of all of them but without PCI IDs ... From the
archive, I think it was USB bus #4 no ? not sure which of these
controllers it matches. 

The iBook G4 has actually 3 "Apple" OHCI's in KeyLargo/Intrepid but with
2 of them disabled by the firmware (not wired) plus one NEC USB2
controller (which contains 1 EHCI and 2 OHCIs) on the PCI bus. The code
managing their sleep process is very different.

Ben.


