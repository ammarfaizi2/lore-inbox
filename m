Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129602AbQLGREZ>; Thu, 7 Dec 2000 12:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129908AbQLGREP>; Thu, 7 Dec 2000 12:04:15 -0500
Received: from d12lmsgate-3.de.ibm.com ([195.212.91.201]:2783 "EHLO
	d12lmsgate-3.de.ibm.com") by vger.kernel.org with ESMTP
	id <S129602AbQLGREE>; Thu, 7 Dec 2000 12:04:04 -0500
From: Ulrich.Weigand@de.ibm.com
X-Lotus-FromDomain: IBMDE
To: linux-kernel@vger.kernel.org
cc: schwidefsky@de.ibm.com
Message-ID: <C12569AE.005AF14B.00@d12mta01.de.ibm.com>
Date: Thu, 7 Dec 2000 17:33:17 +0100
Subject: bug: merge_segments vs. lock_vma_mappings?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

since test11, the merge_segments() routine assumes that every
VMA that it frees has been locked with lock_vma_mappings().

While most callers have been adapted to perform this locking,
at least two, do_mlock and sys_mprotect, do *not* currently.
This causes a deadlock in certain situations.

What's the correct way to fix this?  In mlock and mprotect,
potentially many segments could be freed; do we need to
call lock_vma_mappings on all of them before calling
merge_segments?


Mit freundlichen Gruessen / Best Regards

Ulrich Weigand

--
  Dr. Ulrich Weigand
  Linux for S/390 Design & Development
  IBM Deutschland Entwicklung GmbH, Schoenaicher Str. 220, 71032 Boeblingen
  Phone: +49-7031/16-3727   ---   Email: Ulrich.Weigand@de.ibm.com


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
