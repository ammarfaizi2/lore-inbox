Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265320AbSLVUoT>; Sun, 22 Dec 2002 15:44:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265339AbSLVUoT>; Sun, 22 Dec 2002 15:44:19 -0500
Received: from franka.aracnet.com ([216.99.193.44]:2973 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP
	id <S265320AbSLVUoS>; Sun, 22 Dec 2002 15:44:18 -0500
Date: Sun, 22 Dec 2002 12:52:12 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>,
       William Lee Irwin III <wli@holomorphy.com>
cc: Christoph Hellwig <hch@infradead.org>,
       James Cleverdon <jamesclv@us.ibm.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       John Stultz <johnstul@us.ibm.com>,
       "Nakajima, Jun" <jun.nakajima@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Van Maren, Kevin" <kevin.vanmaren@UNISYS.com>, Andi Kleen <ak@suse.de>,
       Hubert Mantel <mantel@suse.de>,
       "Kamble, Nitin A" <nitin.a.kamble@intel.com>
Subject: RE: [PATCH][2.4]  generic cluster APIC support for systems with m	
 ore than 8 CPUs
Message-ID: <5540000.1040590331@titus>
In-Reply-To: <3FAD1088D4556046AEC48D80B47B478C1AEC75@usslc-exch-4.slc.unisys.com>
References: <3FAD1088D4556046AEC48D80B47B478C1AEC75@usslc-exch-4.slc.unisys.
 com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Some platforms (like certain ES7000s) won't tolerate any bit masks
> programmed into the RTE because their balancing is done entirely in
> hardware, similar to XTPR mechanism for Fosters. For those I suggest to
> have an escape door, in the form of boot parameter such as
> "irq_balance=no". It was suggested to us by SuSE and worked great - I
> could turn it off in our platform code unconditionally. It could also
> help those who can use irq balancing as is but might want to implement
> their own balancing schema.

Having a boot-time parameter is useful, but I'd like it to default to off
without a paramater for the platforms where it's just broken. At the
moment there's an "if (clustered_apic_mode) return;" stuck at the top
of balance_irq, the latest series of patches changes that to
"if (no_balance_irq) return;", which is set by NUMA-Q. If we can set
up no_balance_irq to default correctly, but be possibly overridden by
the boot-time parameter, I think we'd have the best of both worlds.

M.

