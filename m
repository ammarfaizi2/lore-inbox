Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267858AbRGRKq2>; Wed, 18 Jul 2001 06:46:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267859AbRGRKqS>; Wed, 18 Jul 2001 06:46:18 -0400
Received: from unamed.infotel.bg ([212.39.68.18]:47878 "EHLO l.himel.bg")
	by vger.kernel.org with ESMTP id <S267858AbRGRKqQ>;
	Wed, 18 Jul 2001 06:46:16 -0400
Date: Wed, 18 Jul 2001 13:48:00 +0300 (EEST)
From: Julian Anastasov <ja@himel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: cpuid_eax damages registers (2.4.7pre7)
Message-ID: <Pine.LNX.4.10.10107181347030.16710-100000@l>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


	Hello,

	I don't know whether cpuid_eax (2.4.7pre) should preserve the
registers changed from cpuid but I have an oops on boot with 2.4.7pre7 in
squash_the_stupid_serial_number where cpuid_eax changes ebx and the
parameter "c" is loaded with "Genu". The following change fixes the
problem:

from:

c->cpuid_level = cpuid_eax(0);

to:

unsigned int dummy;

cpuid(0, &c->cpuid_level, &dummy, &dummy, &dummy);


but I'm not sure in the definitions of these cpuid_XXX funcs. I see
that they are used at many places. IMO, they have to preserve the
registers.


Regards

--
Julian Anastasov <ja@ssi.bg>

