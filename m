Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268138AbTBMSFC>; Thu, 13 Feb 2003 13:05:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268139AbTBMSFC>; Thu, 13 Feb 2003 13:05:02 -0500
Received: from CPE0080c6e90c22-CM014280010574.cpe.net.cable.rogers.com ([24.43.161.4]:53509
	"EHLO stargate.coplanar.net") by vger.kernel.org with ESMTP
	id <S268138AbTBMSFB>; Thu, 13 Feb 2003 13:05:01 -0500
Subject: Re: Faking a memory map?
From: Jeremy Jackson <jerj@coplanar.net>
To: David Frascone <dave@frascone.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20030212002115.GD26196@wolverine>
References: <20030212002115.GD26196@wolverine>
Content-Type: text/plain
Organization: 
Message-Id: <1045160092.1295.94.camel@contact.skynet.coplanar.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 
Date: 13 Feb 2003 13:14:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-11 at 19:21, David Frascone wrote:
> I'm trying to get an existing SDK (userland) for a PCI hardware device
> to work across a different propriatary bit-banged interface.
> 
> The original device driver just mmaped the PCI registers / address
> space into userland.  (talk about lazy ;)
> 
> Anyway, the hardware I'm working with is *not* on the PCI bus, and
> therefore not memory-mappable.  So, I'm stuck with a complex driver
> design (compared to the original), and rewriting the entire bottom of
> the SDK.
> 
> So, I thought:  Is there a way to cheat?  Would it be possible for me
> to *fake* the SDK out by memory mapping some RAM, and then reading /
> writing to the ram after bit-banging the device.
> 
> I looked into it some, but I couldn't figure out how to get notified
> when the region was read/written to (only when the page changed).  So,
> is it possible to do the (admitedly ugly) hack I'm attempting?

I think you would have to use mprotect(,,PROT_NONE), set the region to
disallow read/write, and then each SEGV would have to be decoded, and
the trap told to continue as though the access did take place.

Take a look at the mprotect man page for an example, and then sigaction
arount the siginfo_t area.  in siginfo_t.si_addr it gives the address
that faulted.
> 
> Thanks in advance,
> 
> -Dave
-- 
Jeremy Jackson <jerj@coplanar.net>

