Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264679AbTGGXdL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 19:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264700AbTGGXdL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 19:33:11 -0400
Received: from fed1mtao04.cox.net ([68.6.19.241]:687 "EHLO fed1mtao04.cox.net")
	by vger.kernel.org with ESMTP id S264679AbTGGXdJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 19:33:09 -0400
Date: Mon, 7 Jul 2003 16:47:41 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Chris Mason <mason@suse.com>, schlicht@uni-mannheim.de, green@namesys.com,
       barryn@pobox.com, piggin@cyberone.com.au, linux-kernel@vger.kernel.org
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Message-ID: <20030707234741.GB2860@ip68-4-255-84.oc.oc.cox.net>
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net> <20030706193722.79352bc3.akpm@osdl.org> <20030707033058.GA2860@ip68-4-255-84.oc.oc.cox.net> <200307071758.45702.schlicht@uni-mannheim.de> <1057599193.20904.1352.camel@tiny.suse.com> <20030707121859.5204703f.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030707121859.5204703f.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 07, 2003 at 12:18:59PM -0700, Andrew Morton wrote:
> But we need to tell the VFS that the page was cleaned.
> 
> Could someone please make that clear_page_dirty() and retest?

Ok, I just did that -- indeed, that appears to fix it. Beneath my
e-mail signature is the fix, turned into a patch.

-Barry K. Nathan <barryn@pobox.com>

--- 2.5.74-bk2/fs/reiserfs/tail_conversion.c	2003-07-03 01:13:37.000000000 -0700
+++ 2.5.74-bk2-iserv/fs/reiserfs/tail_conversion.c	2003-07-07 16:36:01.000000000 -0700
@@ -191,7 +191,7 @@
 	bh = next ;
       } while (bh != head) ;
       if ( PAGE_SIZE == bh->b_size ) {
-	ClearPageDirty(page);
+	clear_page_dirty(page);
       }
     }
   } 
