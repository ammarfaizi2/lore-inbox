Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261867AbUK2W4N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261867AbUK2W4N (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Nov 2004 17:56:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261856AbUK2Wyz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Nov 2004 17:54:55 -0500
Received: from gate.crashing.org ([63.228.1.57]:64650 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S261845AbUK2Wnt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Nov 2004 17:43:49 -0500
Subject: Re: [linux-usb-devel] [PATCH] Ohci-hcd: fix endless loop (second
	take)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin.lkml@colino.net>
Cc: David Brownell <david-b@pacbell.net>,
       Linux-USB <linux-usb-devel@lists.sourceforge.net>,
       Colin Leroy <colin@colino.net>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>
In-Reply-To: <20041129233435.4e0d125c@jack.colino.net>
References: <20041126113021.135e79df@pirandello>
	 <200411260928.18135.david-b@pacbell.net>
	 <20041126183749.1a230af9@jack.colino.net>
	 <200411260957.52971.david-b@pacbell.net> <1101507130.28047.29.camel@gaston>
	 <20041129090406.5fb31933@pirandello> <1101767183.15463.17.camel@gaston>
	 <20041129233435.4e0d125c@jack.colino.net>
Content-Type: text/plain
Date: Tue, 30 Nov 2004 09:43:15 +1100
Message-Id: <1101768195.15463.20.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-11-29 at 23:34 +0100, Colin Leroy wrote:
> On 30 Nov 2004 at 09h11, Benjamin Herrenschmidt wrote:
> 
> Hi, 
> 
> > Hrm... there is some problem in communication here. I asked you which
> > controller out of the 3 OHCIs you have in this machine is the culprit,
> > you give me a list of all of them but without PCI IDs ... From the
> > archive, I think it was USB bus #4 no ? not sure which of these
> > controllers it matches. 
> > 
> > The iBook G4 has actually 3 "Apple" OHCI's in KeyLargo/Intrepid but
> > with 2 of them disabled by the firmware (not wired) plus one NEC USB2
> > controller (which contains 1 EHCI and 2 OHCIs) on the PCI bus. The
> > code managing their sleep process is very different.
> 
> Sorry, i was away and had a problem of /proc/bus/usb being empty. As my
> link was on the wireless stick I couldn't reload usb modules. The
> culprit is usb 4-1, I think it would be this one (as the stick is bus
> 004 device 001):

Ok, this is a perfectly normal "out of the schelves" NEC chip, no
special "Mac" thing in there, it just use normal PCI PM...

It could be one of the devices not properly dealing with beeing
suspended, or it could be some delay needing to be increased here or
there in the resume process, difficult to say at this point.

Ben.
 

