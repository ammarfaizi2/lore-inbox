Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbTFPOjS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Jun 2003 10:39:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263894AbTFPOjS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Jun 2003 10:39:18 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:5387 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261823AbTFPOjR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Jun 2003 10:39:17 -0400
Subject: Re: 2.5.71 cardbus problem + possible solution
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: mikpe@csd.uu.se
Cc: Russell King <rmk@arm.linux.org.uk>, Dominik Brodowski <linux@brodo.de>,
       LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <16109.54908.249375.482633@gargle.gargle.HOWL>
References: <16109.50492.555714.813028@gargle.gargle.HOWL>
	 <20030616153253.A13312@flint.arm.linux.org.uk>
	 <16109.54908.249375.482633@gargle.gargle.HOWL>
Content-Type: text/plain
Message-Id: <1055775186.587.2.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 16 Jun 2003 16:53:07 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-06-16 at 16:38, mikpe@csd.uu.se wrote:
> Russell King writes:
>  > On Mon, Jun 16, 2003 at 03:25:16PM +0200, mikpe@csd.uu.se wrote:
>  > > 2.5.71 changed the name of the Yenta module from yenta_socket
>  > > to yenta. In my case (Latitude with RH9 user-space), this
>  > > prevented cardmgr from starting properly.
>  > > 
>  > > Quick fix: add 'alias yenta_socket yenta' to /etc/modprobe.conf,
>  > > or s/yenta_socket/yenta/ in the appropriate config file (but
>  > > then you make multi-booting 2.4/2.5 more difficult).
>  > 
>  > What do people want to do about this?  I have no particular desire to
>  > answer all those emails asking about this, so unless Dominik objects,
>  > I think we should just rename "yenta.c" to "yenta_socket.c" so we have
>  > back-compatibility.
>  > 
>  > (This issue has appeared because yenta_socket.ko used to be created
>  > by combining yenta.o with pci_socket.o.  Since pci_socket.c no longer
>  > exists, we create the module from yenta.c directly, so its now called
>  > yenta.ko.)
> 
> I'd prefer compatibility, if there are no technical reasons for
> breaking it. Reverting to the old name in 2.5.72 sounds like a
> good idea.

I must agree with. I think backwards compatibility is important if we
want widespread adoption of 2.6 from the beginning. But there's a
question I had in mind for long time: is cardmgr really needed? Isn't
hotplug more than enough to handle CardBus devices?

