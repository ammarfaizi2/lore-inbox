Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135550AbRD1Q0s>; Sat, 28 Apr 2001 12:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135556AbRD1Q0i>; Sat, 28 Apr 2001 12:26:38 -0400
Received: from www.linux.org.uk ([195.92.249.252]:60434 "EHLO www.linux.org.uk")
	by vger.kernel.org with ESMTP id <S135550AbRD1Q01>;
	Sat, 28 Apr 2001 12:26:27 -0400
Date: Sat, 28 Apr 2001 17:25:54 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: linux-kernel@vger.kernel.org
Subject: IPv4 NAT doesn't compile in 2.4.4
Message-ID: <20010428172554.H21792@flint.arm.linux.org.uk>
Mail-Followup-To: Russell King <rmk@flint.arm.linux.org.uk>,
	linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

net/network.o: In function `init_or_cleanup':
net/network.o(.text+0x4a530): relocation truncated to fit: R_ARM_PC24 ip_nat_cleanup

says it all.

ip_nat_standalone.c:

static int init_or_cleanup(int init)
{
...
 cleanup_nat:
        ip_nat_cleanup();
...
}

ip_nat_core:

void __exit ip_nat_cleanup(void)
{
        ip_ct_selective_cleanup(&clean_nat, NULL);
        ip_conntrack_destroyed = NULL;
}

*Don't* do this - its fundamentally wrong.  Code in the kernel should _not_
reference code that has been removed by the linker.

--
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

