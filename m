Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129900AbQKAKTS>; Wed, 1 Nov 2000 05:19:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129912AbQKAKTI>; Wed, 1 Nov 2000 05:19:08 -0500
Received: from [62.172.234.2] ([62.172.234.2]:29562 "EHLO saturn.homenet")
	by vger.kernel.org with ESMTP id <S129900AbQKAKSy>;
	Wed, 1 Nov 2000 05:18:54 -0500
Date: Wed, 1 Nov 2000 10:19:18 +0000 (GMT)
From: Tigran Aivazian <tigran@veritas.com>
To: Linus Torvalds <torvalds@transmeta.com>
cc: Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Daniel Roesen <dr@bofh.de>, Richard Schaal <richard.schaal@intel.com>
Subject: Re: Linux-2.4.0-test10
In-Reply-To: <Pine.LNX.4.10.10010311237430.22165-100000@penguin.transmeta.com>
Message-ID: <Pine.LNX.4.21.0011011012510.1722-100000@saturn.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Oct 2000, Linus Torvalds wrote:

> 
> Ok, test10-final is out there now. This has no _known_ bugs that I
> consider show-stoppers, for what it's worth.

Linus,

But it contains an erroneous part in microcode.c:

-       if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 < 6){
+       if (c->x86_vendor != X86_VENDOR_INTEL || c->x86 != 6){
                printk(KERN_ERR "microcode: CPU%d not an Intel P6\n",
cpu_num);


It was not in Daniel's cleanup patch which I saw but came from elsewhere.
Are there Intel CPUs with family>6 which do not support the same mechanism
for microcode update as family=6? The manuals suggest that test for ">" is
correct, i.e. that Intel will maintain compatibility with P6 wrt microcode
update.

Perhaps Richard can clarify this?

Regards,
Tigran

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
