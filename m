Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129697AbQKYFPh>; Sat, 25 Nov 2000 00:15:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S130498AbQKYFP2>; Sat, 25 Nov 2000 00:15:28 -0500
Received: from [209.249.10.20] ([209.249.10.20]:56762 "EHLO
        freya.yggdrasil.com") by vger.kernel.org with ESMTP
        id <S129697AbQKYFPV>; Sat, 25 Nov 2000 00:15:21 -0500
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Fri, 24 Nov 2000 20:45:19 -0800
Message-Id: <200011250445.UAA02193@baldur.yggdrasil.com>
To: kaos@ocs.com.au
Subject: Re: Patch(?): isapnp_card_id tables for all isapnp drivers in 2.4.0-test11
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:
>"Adam J. Richter" <adam@yggdrasil.com> wrote:
>>	Note that this is not a "final" version.  I plan to go
>>through all of the changes and bracket all of these new tables
>>with #ifdef MODULE...#endif so they do not result in complaints
>>about the table being defined static and never used in cases where
>>the driver is compiled directly into the kernel.

>This is cleaner.  Append MODULE_ONLY after __initdata and remove the
>ifdef.  It increases the size of initdata in the kernel, compared to
>ifdef, but since initdata is promptly reused as scratch space it should
>not be a problem.
[patch elided]

	Thanks for the patch, but I think I'll stick with the ifdefs
for now, for the following reasons.

	1. I think ifdef MODULE is more understandable to the casual observer.
	2. There is often some other condition that I need to combine
	   with (CONFIG_PCI, CONFIG_ISAPNP, CONFIG_ISAPNP_MODULE).
	3. There is often an existing ifdef in the right place that I
	   can just tuck the code into.
	4. I would prefer that this change not have even a file size cost
	   to people who want to build minimal monolithic kernels
	   for applicance applications.
	5. My feeling is that just the few kilobytes of file size cost
	   associated with #4 and knowing that absolutely nothing is
	   added for non-module usage will psychologically make
	   maintainers feel better about it and have even fewer misgivings
	   about integrating it.
	6. We can expect the lines bracketing these table declarations
	   to be changed in the near future as the drivers are changed
	   to use the new PCI and isapnp interfaces or to use the ID
	   tables just to eliminate the old custom data structures that
	   hold the same information.

	Thanks for the patch anyhow, though.  It's a clever idea that
may be useful in other situations.

Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
