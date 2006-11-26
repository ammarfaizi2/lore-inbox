Return-Path: <linux-kernel-owner+willy=40w.ods.org-S935553AbWKZUtt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935553AbWKZUtt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Nov 2006 15:49:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935561AbWKZUtt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Nov 2006 15:49:49 -0500
Received: from ns2.suse.de ([195.135.220.15]:15256 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S935540AbWKZUtr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Nov 2006 15:49:47 -0500
From: Andi Kleen <ak@suse.de>
To: Amul Shah <amul.shah@unisys.com>
Subject: Re: [PATCH] x86_64: Make the NUMA hash function nodemap allocation dynamic and remove NODEMAPSIZE
Date: Sun, 26 Nov 2006 21:49:36 +0100
User-Agent: KMail/1.9.5
Cc: LKML <linux-kernel@vger.kernel.org>, Eric Dumazet <dada1@cosmosbay.com>
References: <1163627312.3553.199.camel@ustr-linux-shaha1.unisys.com>
In-Reply-To: <1163627312.3553.199.camel@ustr-linux-shaha1.unisys.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611262149.36529.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 15 November 2006 22:48, Amul Shah wrote:
> This patch removes the statically allocated memory to NUMA node hash map
> in favor of a dynamically allocated memory to node hash map (it is cache
> aligned).
> 
> This patch has the nice side effect in that it allows the hash map to
> grow for systems with large amounts of memory (256GB - 1TB), but suffer
> from having small PCI space tacked onto the boot node (which is
> somewhere between 192MB to 512MB on the ES7000).
> 
> Signed-off-by: Amul Shah <amul.shah@unisys.com>
> 
> ---
> Patch applies to 2.6.19-rc4 and has been tested.
> This patch needs testing on a K8 NUMA platform.
> Thanks to Eric Dumazet and Andi Kleen for their improvement suggestions.

I had the patch in, but had to drop it again because it makes one of my
test system triple fault. Haven't done much investigation yet.

BIOS-provided physical RAM map:
 BIOS-e820: 0000000000000000 - 000000000009fc00 (usable)
 BIOS-e820: 000000000009fc00 - 00000000000a0000 (reserved)
 BIOS-e820: 00000000000e6000 - 0000000000100000 (reserved)
 BIOS-e820: 0000000000100000 - 000000003ef30000 (usable)
 BIOS-e820: 000000003ef30000 - 000000003ef40000 (ACPI data)
 BIOS-e820: 000000003ef40000 - 000000003eff0000 (ACPI NVS)
 BIOS-e820: 000000003eff0000 - 000000003f000000 (reserved)
 BIOS-e820: 00000000fecf0000 - 00000000fecf1000 (reserved)
 BIOS-e820: 00000000fed20000 - 00000000feda0000 (reserved)
end_pfn_map = 1043872
kernel direct mapping tables up to feda0000 @ 8000-d000
DMI 2.3 present.
No NUMA configuration found
Faking a node at 0000000000000000-000000003ef30000
<triple fault>

-Andi
