Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281946AbRKUSc6>; Wed, 21 Nov 2001 13:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281945AbRKUScu>; Wed, 21 Nov 2001 13:32:50 -0500
Received: from ns.suse.de ([213.95.15.193]:51984 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S281944AbRKUScf>;
	Wed, 21 Nov 2001 13:32:35 -0500
To: harish.vasudeva@amd.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: Need Info on Checksum Offloading
In-Reply-To: <CB35231B9D59D311B18600508B0EDF2F0197A311@caexmta9.amd.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Nov 2001 07:16:27 +0100
In-Reply-To: harish.vasudeva@amd.com's message of "15 Nov 2001 02:25:09 +0100"
Message-ID: <p731yj07e4k.fsf@amdsim2.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.7
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

harish.vasudeva@amd.com writes:

> Hi All,
> 
>  Could any1 pls direct me wherein i could find some documentation about implementing checksum offloading for my ethernet LAN driver?

include/linux/skbuff.h has a big fat comment describing checksums handling.
Just read it.

For RX checksums you just set ip_summed of the incoming skb 
to CHECKSUM_UNNCESSARY (you did a complete check of the checksum;
not recommended as you're unlikely to support all weird protocols) or 
CHECKSUM_HW (you put a checksum of the TCP/UDP data area minus pseudo header
and ip header into skb->csum) or CHECKSUM_NONE for sw checksum.

-Andi
