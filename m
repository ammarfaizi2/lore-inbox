Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262589AbUC2Dza (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 22:55:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262592AbUC2Dza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 22:55:30 -0500
Received: from mailout2.samsung.com ([203.254.224.25]:22483 "EHLO
	mailout2.samsung.com") by vger.kernel.org with ESMTP
	id S262589AbUC2Dz2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 22:55:28 -0500
Date: Mon, 29 Mar 2004 12:54:24 +0900
From: "Hyok S. Choi" <hyok.choi@samsung.com>
Subject: RE: [ANNOUNCE] 2.6.4-hsc1 patch for MMU-less ARM is available.
In-reply-to: <20040328200026.A10359@flint.arm.linux.org.uk>
To: "'Russell King - ARM Linux'" <linux@arm.linux.org.uk>,
       Greg Ungerer <gerg@snapgear.com>, Christoph Hellwig <hch@infradead.org>
Cc: Linux-Kernel List <linux-kernel@vger.kernel.org>,
       uClinux development list <uclinux-dev@uclinux.org>,
       linux-arm-kernel@lists.arm.linux.org.uk
Message-id: <005201c41541$86d46320$7dc2dba8@dmsst.net>
Organization: Samsung Electronics Co.,Ltd.
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
X-Mailer: Microsoft Outlook, Build 10.0.4510
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Importance: Normal
X-Priority: 3 (Normal)
X-MSMail-priority: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

RMK> As Christoph said - why do you have a complete copy of the ARM specific
support,
RMK>   including lots of stuff which will probably never be used on MMU-less
CPUs?

I DO agree with you ;-) The stuffs are to be clean-up(removed) in next
coming-ups, we planed, already.

Christoph> Is the code really that different that you need a armnommu arch
instead of merging it into arch/arm?
RMK> I don't understand this "complete copy and modify" thinking that
uclinux people seem to have - it's
RMK> completely against the Linux development methodology.

I think it is just like the arm26 and the m68knommu case. maintenance issue.

a. readability and portability. If you've ever seen armnommu arch files in
2.4 version, it was just like what you've told, (patching
on arch/arm, although it was renamed to arch/armnommu). It was very
obfuscated.
  In fact, arch/arm supports lots of platforms (e.g. sa, xscale, and so on),
and they has many machine specific craps on common codes. In some cases, I
experienced some modification made some side-effects on other platforms.
  Thus, to increase readability and portability, separating armnommu from
arm directory could help this. I know that this
is not a best solution, but we have no other options, I think. In addition,
it was the way what uc people have done, so that they can work more easily.
think about it, to merge all arm (with mmu plus without mmu) codes in
arch/arm can be a right choice, but obviously it makes the codes hard to
read and hard to port. 

b. armnommu has dependencies with nommu support codes which is maintained by
uc people. we should test with their working codes. Much of the arch codes
are for mm. As you said, I think it should be optimized(removed or
re-written) for armnommu. e.g., mmu-less arm7tdmi, which is one of the main
target for armnommu, many of files like arm/kernel/head.S is not work at
all, and the files in arm/mm are not needed.

However, this port is based on RMK codes, if you say this patch must be
merged into rmk patch, I should agree. ;) but I think to be merged into one
directory is not good idea.

And for uclinux people, as linuxdevices.com survey says, there exist many
developers, and they made much efforts, they are linux people also, I think.
Ignoring them can not be a good idea. 

Best regards,
Hyok S. Choi

<EOT>
CHOI, HYOK-SUNG
Engineer (Linux System Software)
S/W Platform Lab, Digital Media R&D Center
Samsung Electronics Co.,Ltd.
tel: +82-31-200-8594  fax: +82-31-200-3427
e-mail: hyok.choi@samsung.com

[compile&run]
main(a){printf(a,34,a="main(a){printf(a,34,a=%c%s%c,34);}",34);}
 
 



