Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261451AbVDCCie@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261451AbVDCCie (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Apr 2005 21:38:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261443AbVDCCie
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Apr 2005 21:38:34 -0500
Received: from dsl027-180-174.sfo1.dsl.speakeasy.net ([216.27.180.174]:49095
	"EHLO cheetah.davemloft.net") by vger.kernel.org with ESMTP
	id S261439AbVDCCia (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Apr 2005 21:38:30 -0500
Date: Sat, 2 Apr 2005 18:38:05 -0800
From: "David S. Miller" <davem@davemloft.net>
To: Matthew Wilcox <matthew@wil.cx>
Cc: James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: iomapping a big endian area
Message-Id: <20050402183805.20a0cf49.davem@davemloft.net>
In-Reply-To: <20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
References: <1112475134.5786.29.camel@mulgrave>
	<20050403013757.GB24234@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; sparc-unknown-linux-gnu)
X-Face: "_;p5u5aPsO,_Vsx"^v-pEq09'CU4&Dc1$fQExov$62l60cgCc%FnIwD=.UF^a>?5'9Kn[;433QFVV9M..2eN.@4ZWPGbdi<=?[:T>y?SD(R*-3It"Vj:)"dP
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Apr 2005 02:37:57 +0100
Matthew Wilcox <matthew@wil.cx> wrote:

> My thought on this is that we should encode the endianness of the
> registers in the ioremap cookie.  Some architectures (sparc, I think?) can
> do this in their PTEs.  The rest of us can do it in our ioread/writeN
> methods.  I've planned for this in the parisc iomap implementation but
> not actually implemented it.

SPARC64 can do it in the PTEs, but we just use raw physical
addresses in our I/O accessors, and in those load/store instructions
we can specify the endianness.

Be careful though.  Endianness can be dealt with on a hardware
level.  Consider a byte access to a 32-bit word sized config space
datum, the PCI controller on a big-endian system will likely byte-twist
the data lanes in order for this to work properly.

It's a subtle issue, and it's explained pretty well in some of the
UltraSPARC PCI controller docs at:

	http://www.sun.com/processors/documentation.html

In particular, "U2P UPA to PCI User's Manual", chapter 10
"Little-Endian Support", has some informative diagrams.

