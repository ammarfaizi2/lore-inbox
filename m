Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVDCDKM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVDCDKM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 22:10:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261454AbVDCDKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 22:10:11 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24987 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261452AbVDCDKE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 22:10:04 -0500
Date: Sun, 3 Apr 2005 04:10:00 +0100
From: Matthew Wilcox <matthew@wil.cx>
To: "David S. Miller" <davem@davemloft.net>
Cc: Matthew Wilcox <matthew@wil.cx>, James.Bottomley@SteelEye.com,
       linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: iomapping a big endian area
Message-ID: <20050403031000.GC24234@parcelfarce.linux.theplanet.co.uk>
References: <1112475134.5786.29.camel@mulgrave> <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk> <20050402183805.20a0cf49.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050402183805.20a0cf49.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 02, 2005 at 06:38:05PM -0800, David S. Miller wrote:
> > My thought on this is that we should encode the endianness of the
> > registers in the ioremap cookie.  Some architectures (sparc, I think?) can
> > do this in their PTEs.  The rest of us can do it in our ioread/writeN
> > methods.  I've planned for this in the parisc iomap implementation but
> > not actually implemented it.
> 
> SPARC64 can do it in the PTEs, but we just use raw physical
> addresses in our I/O accessors, and in those load/store instructions
> we can specify the endianness.

Ah right.  So you'd prefer an ioread8be() interface?

> Be careful though.  Endianness can be dealt with on a hardware
> level.  Consider a byte access to a 32-bit word sized config space
> datum, the PCI controller on a big-endian system will likely byte-twist
> the data lanes in order for this to work properly.

Yup, PA-RISC PCI adapters (both Dino and Elroy) do the same thing.
The 53c700 driver handles this lack of skewing by xoring the address with 3.

-- 
"Next the statesmen will invent cheap lies, putting the blame upon 
the nation that is attacked, and every man will be glad of those
conscience-soothing falsities, and will diligently study them, and refuse
to examine any refutations of them; and thus he will by and by convince 
himself that the war is just, and will thank God for the better sleep 
he enjoys after this process of grotesque self-deception." -- Mark Twain
