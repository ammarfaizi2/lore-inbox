Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129507AbQKGABt>; Mon, 6 Nov 2000 19:01:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129543AbQKGABi>; Mon, 6 Nov 2000 19:01:38 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:19982 "EHLO
	havoc.gtf.org") by vger.kernel.org with ESMTP id <S129507AbQKGAB1>;
	Mon, 6 Nov 2000 19:01:27 -0500
Message-ID: <3A074633.12ED8137@mandrakesoft.com>
Date: Mon, 06 Nov 2000 19:00:51 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.0-test10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
CC: Linus Torvalds <torvalds@transmeta.com>, viro@math.psu.edu
Subject: swapout vs. filemap_sync_pte...?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The address_space::writepage callback is called from try_to_swap_out()
path, and also from the filemap_sync_pte() path.  There appears to be no
way to tell the difference between the two callers.  This is not good
because the semantics are very different:  "sync this page" versus "page
is going away".

Should address_space::writepage get passed an additional arg, indicating
the caller?
Should filemap_sync_pte call address_space::sync_page instead of
::writepage?

Either way, this allows the writepage function to know whether it really
needs to store the page, because it is going away, or not.

I will admit I might be missing something obvious...  I'm pretty new to
this part of the code.

	Jeff


-- 
Jeff Garzik             | "When I do this, my computer freezes."
Building 1024           |          -user
MandrakeSoft            | "Don't do that."
                        |          -level 1
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
