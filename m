Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264097AbRFNV6C>; Thu, 14 Jun 2001 17:58:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264101AbRFNV5w>; Thu, 14 Jun 2001 17:57:52 -0400
Received: from smtp-rt-4.wanadoo.fr ([193.252.19.156]:47345 "EHLO
	areca.wanadoo.fr") by vger.kernel.org with ESMTP id <S264097AbRFNV5l>;
	Thu, 14 Jun 2001 17:57:41 -0400
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "David S. Miller" <davem@redhat.com>
Cc: <linux-kernel@vger.kernel.org>
Subject: Re: Going beyond 256 PCI buses
Date: Thu, 14 Jun 2001 23:57:09 +0200
Message-Id: <20010614215709.23875@smtp.wanadoo.fr>
In-Reply-To: <15145.12584.339783.786454@pizda.ninka.net>
In-Reply-To: <15145.12584.339783.786454@pizda.ninka.net>
X-Mailer: CTM PowerMail 3.0.8 <http://www.ctmdev.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>It really isn't needed, and I understand why Linus didn't like the
>idea either.  Because you can encode the bus etc. info into the
>resource addresses themselves.
>
>On sparc64 we just so happen to stick raw physical addresses into the
>resources, but that is just one way of implementing it.

That would be fine for PIO on PCI, but still is an issue for
VGA-like devices that need to issue some "legacy" cycles on
a given domain. Currently, on PPC, inx/outx will only go to
one bus (arbitrarily choosen during boot) because of that,
meaning that we can't have 2 VGA cards on 2 different domains

That's why I'd love to see a review of the "legacy" (ISA) stuff
in general. I understand that can require a bit of updating of
a lot of legacy drivers to do the proper ioremap's, but that would
help a lot, including some weird embedded archs which love using
those cheap 16 bits devices on all sorts of custom busses. In
those case, only the probe part will have to be hacked since the
drivers will all cleanly use a "base" obtained from that probe-time
ioremap before doing inx/outx.

I'd be happy to help bringing drivers up-to-date (however, I don't
have an x86 box to test with) once we agree on the way do go.

Ben.


