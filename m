Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1757797AbWK0KW5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757797AbWK0KW5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Nov 2006 05:22:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757802AbWK0KW5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Nov 2006 05:22:57 -0500
Received: from pfx2.jmh.fr ([194.153.89.55]:31124 "EHLO pfx2.jmh.fr")
	by vger.kernel.org with ESMTP id S1757797AbWK0KW4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Nov 2006 05:22:56 -0500
From: Eric Dumazet <dada1@cosmosbay.com>
To: Andi Kleen <ak@suse.de>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Mon, 27 Nov 2006 11:23:11 +0100
User-Agent: KMail/1.9.5
Cc: Amul Shah <amul.shah@unisys.com>, LKML <linux-kernel@vger.kernel.org>
References: <1163627312.3553.199.camel@ustr-linux-shaha1.unisys.com> <200611262149.36529.ak@suse.de>
In-Reply-To: <200611262149.36529.ak@suse.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611271123.11649.dada1@cosmosbay.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 26 November 2006 21:49, Andi Kleen wrote:
> On Wednesday 15 November 2006 22:48, Amul Shah wrote:
> > This patch removes the statically allocated memory to NUMA node hash map
> > in favor of a dynamically allocated memory to node hash map (it is cache
> > aligned).
> >
> > This patch has the nice side effect in that it allows the hash map to
> > grow for systems with large amounts of memory (256GB - 1TB), but suffer
> > from having small PCI space tacked onto the boot node (which is
> > somewhere between 192MB to 512MB on the ES7000).
> >
> > Signed-off-by: Amul Shah <amul.shah@unisys.com>
> >
> > ---
> > Patch applies to 2.6.19-rc4 and has been tested.
> > This patch needs testing on a K8 NUMA platform.
> > Thanks to Eric Dumazet and Andi Kleen for their improvement suggestions.
>
> I had the patch in, but had to drop it again because it makes one of my
> test system triple fault. Haven't done much investigation yet.
>
> BIOS-provided physical RAM map:
>  BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
>  BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
>  BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
>  BIOS-e820: 0000000000100000 - 000000003ef30000 (usable)
>  BIOS-e820: 000000003ef30000 - 000000003ef40000 (ACPI data)
>  BIOS-e820: 000000003ef40000 - 000000003eff0000 (ACPI NVS)
>  BIOS-e820: 000000003eff0000 - 000000003f000000 (reserved)
>  BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
>  BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
> end_pfn_map = 1043872
> kernel direct mapping tables up to feda0000 @ 8000-d000
> DMI 2.3 present.
> No NUMA configuration found
> Faking a node at 0000000000000000-000000003ef30000
> <triple fault>
>

Well, I dont have currently an AMD64 test machine so I cannot really help.

With previous implementation, the nimimum shift value was 20 (one megabytes)

If a memnode had a finer range (with chunks not multiple of megabytes), some 
bits of memory could be ignored.

But with your fake node (0-3ef30000), Amul patch may give a shift value of 16.
 Maybe this breaks something in the kernel...

Eric
