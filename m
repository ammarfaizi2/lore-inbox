Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964952AbWAWUsa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964952AbWAWUsa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:48:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932474AbWAWUsa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:48:30 -0500
Received: from uproxy.gmail.com ([66.249.92.203]:30633 "EHLO uproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932472AbWAWUs3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:48:29 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:date:from:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent;
        b=R0/bFMX+u1UgVbEGTXJ5DaQ8tJ02AqGdtSs1b9j9FH1aexM8zzXjiBueSeGScvWaXwR+bhaRCz7dPKO72idXG0sHX2FG+0VwP+R31B45bof7XjuL5ydDkkAHjhwHHzCu7iC6Z5nPsA/gt4vSAaMoQb2bTGZSfH6VeMKYpDbf7NY=
Date: Tue, 24 Jan 2006 00:05:52 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] include/asm-*/bitops.h: fix masking in find_next_zero_bit()
Message-ID: <20060123210552.GA12531@mipter.zuzino.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3960f2faaf0a67ad352bd5d4085e43f19f33ab91 says:

    [PATCH] m68knommu: fix find_next_zero_bit in bitops.h

    We're starting a number of big applications (memory footprint app.
    1MByte) on our Arcturus uC5272.  Therefore memory fragmentation is a
    real pain for us.  We've switched to uClinux-2.4.27-uc1 and found that
    page_alloc2 fragments the memory heavily.

    Digging into it we found a bug in the find_next_zero_bit function in the
    m68knommu/bitops.h file.  if the size isn't a multiple of 32 than the
    upper bits of the last word to be searched should be masked.  But the
    functions masks the lower bits of the last word because it uses a right
    shift instead of a left shift operator.

Fix same typos.

Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
---

 include/asm-cris/bitops.h  |    2 +-
 include/asm-frv/bitops.h   |    2 +-
 include/asm-h8300/bitops.h |    2 +-
 include/asm-v850/bitops.h  |    2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

--- a/include/asm-cris/bitops.h
+++ b/include/asm-cris/bitops.h
@@ -290,7 +290,7 @@ static inline int find_next_zero_bit (co
 	tmp = *p;
 	
  found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
  found_middle:
 	return result + ffz(tmp);
 }
--- a/include/asm-frv/bitops.h
+++ b/include/asm-frv/bitops.h
@@ -209,7 +209,7 @@ static inline int find_next_zero_bit(con
 	tmp = *p;
 
 found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
 found_middle:
 	return result + ffz(tmp);
 }
--- a/include/asm-h8300/bitops.h
+++ b/include/asm-h8300/bitops.h
@@ -227,7 +227,7 @@ static __inline__ int find_next_zero_bit
 	tmp = *p;
 
 found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
 found_middle:
 	return result + ffz(tmp);
 }
--- a/include/asm-v850/bitops.h
+++ b/include/asm-v850/bitops.h
@@ -188,7 +188,7 @@ static inline int find_next_zero_bit(con
 	tmp = *p;
 
  found_first:
-	tmp |= ~0UL >> size;
+	tmp |= ~0UL << size;
  found_middle:
 	return result + ffz (tmp);
 }

