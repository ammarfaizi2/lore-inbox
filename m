Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264205AbRFNXnL>; Thu, 14 Jun 2001 19:43:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264209AbRFNXnC>; Thu, 14 Jun 2001 19:43:02 -0400
Received: from pizda.ninka.net ([216.101.162.242]:17589 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S264205AbRFNXmx>;
	Thu, 14 Jun 2001 19:42:53 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15145.19442.773217.177804@pizda.ninka.net>
Date: Thu, 14 Jun 2001 16:42:42 -0700 (PDT)
To: James Simmons <jsimmons@transvirtual.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux-kernel@vger.kernel.org
Subject: Re: VGA handling was [Re: Going beyond 256 PCI buses]
In-Reply-To: <Pine.LNX.4.10.10106141616470.12951-100000@transvirtual.com>
In-Reply-To: <15145.14057.67940.752173@pizda.ninka.net>
	<Pine.LNX.4.10.10106141616470.12951-100000@transvirtual.com>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


James Simmons writes:
 >    Actually this weekend I'm working on this for the console system. I
 > plan to get my TNT card and 3Dfx card both working at the same time both in
 > VGA text mode. If you also really want to get multiple card in vga text
 > mode it is going to get far more complex in a multihead besides the
 > problem of multiple buses.

You going to have to enable/disable I/O, MEM access, and VGA pallette
snooping in the PCI_COMMAND register of both boards every time you go
from rendering text on one to rendering text on the other.  If there
are bridges leading to either device, you may need to fiddle with VGA
forwarding during each switch as well.

You'll also need a semaphore or similar to control this "active VGA"
state.

Really, I don't think this is all that good of an idea.

Later,
David S. Miller
davem@redhat.com
