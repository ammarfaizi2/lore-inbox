Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282848AbRLTJlY>; Thu, 20 Dec 2001 04:41:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282702AbRLTJlO>; Thu, 20 Dec 2001 04:41:14 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:11018 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S282688AbRLTJk7>; Thu, 20 Dec 2001 04:40:59 -0500
Date: Thu, 20 Dec 2001 09:37:10 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: "David S. Miller" <davem@redhat.com>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] PCI updates - 32-bit IO support
Message-ID: <20011220093710.C29925@flint.arm.linux.org.uk>
In-Reply-To: <20011218235024.N13126@flint.arm.linux.org.uk> <9vrmea$mef$1@cesium.transmeta.com> <20011219.213019.35013739.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20011219.213019.35013739.davem@redhat.com>; from davem@redhat.com on Wed, Dec 19, 2001 at 09:30:19PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 19, 2001 at 09:30:19PM -0800, David S. Miller wrote:
> Don't the PCI specs actually talk about 24-bits in fact?
> 
> Russell does you box really have the full 32-bits or is it
> really just 24-bits?

Shrug - the chip documentation isn't good enough to indicate either.

What I do know is:

- setting the bridge and eepro100 up with 16-bit IO addresses causes PCI
  master aborts.
- setting the bridge and eepro100 up with 32-bit IO addresses which
  correspond to the host MMIO region, it works perfectly.

It appears that the first bridge converts the mmio access into a PCI
IO read/write cycle without any address translation.  So, when I
access mmio 0x90011000, it would appear to cause a PCI IO cycle at
the same address.

The MMIO region for this bus is 0x90010000 - 0x9001ffff, so its impossible
to test the effect of different upper 16-bits.

I suppose I could waste some time by getting Linux to generate lots of IO
cycles and scoping the PCI bus lines to find the PCI address, but I think
its rather academic in light of the above.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

