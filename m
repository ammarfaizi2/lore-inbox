Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267058AbTGGPoa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 11:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267066AbTGGPoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 11:44:30 -0400
Received: from rumms.uni-mannheim.de ([134.155.50.52]:27577 "EHLO
	rumms.uni-mannheim.de") by vger.kernel.org with ESMTP
	id S267058AbTGGPoW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 11:44:22 -0400
From: Thomas Schlichter <schlicht@uni-mannheim.de>
To: "Barry K. Nathan" <barryn@pobox.com>, Andrew Morton <akpm@osdl.org>
Subject: Re: [BUG] heavy disk access sometimes freezes 2.5.73-mm[123]
Date: Mon, 7 Jul 2003 17:58:44 +0200
User-Agent: KMail/1.5.9
Cc: Nick Piggin <piggin@cyberone.com.au>, linux-kernel@vger.kernel.org
References: <20030703090541.GB5044@ip68-101-124-193.oc.oc.cox.net> <20030706193722.79352bc3.akpm@osdl.org> <20030707033058.GA2860@ip68-4-255-84.oc.oc.cox.net>
In-Reply-To: <20030707033058.GA2860@ip68-4-255-84.oc.oc.cox.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_1iZC/4YfMlaKzeo"
Message-Id: <200307071758.45702.schlicht@uni-mannheim.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Boundary-00=_1iZC/4YfMlaKzeo
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Monday 07 July 2003 05:30, Barry K. Nathan wrote:
> On Sun, Jul 06, 2003 at 07:37:22PM -0700, Andrew Morton wrote:
> > Nick Piggin <piggin@cyberone.com.au> wrote:
> >
> > Barry says the problem started with 2.5.73-mm1.  There was a reiserfs
> > patch added in that kernel.
> >
> > Does a `patch -R' of this fix it up?
>
> [patch snipped]
>
> Yes, backing that patch out fixes it.

I had similar problems with my reiserfs root FS. For me backing out only the 
second chunk of the patch made it, too. I've attached the patch I used for 
that. If someone sees something really bad I'm doing with this please write, 
because I'm playing with my root FS... ;-)

Best regards
  Thomas Schlichter

--Boundary-00=_1iZC/4YfMlaKzeo
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="fix_Dstate.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline; filename="fix_Dstate.diff"

diff -u linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c.orig linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c
--- linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c.orig	2003-06-23 09:26:10.000000000 -0700
+++ linux-2.5.74-mm2/fs/reiserfs/tail_conversion.c	2003-06-23 09:26:10.000000000 -0700
@@ -190,9 +190,6 @@ unmap_buffers(struct page *page, loff_t 
         }
 	bh = next ;
       } while (bh != head) ;
-      if ( PAGE_SIZE == bh->b_size ) {
-	ClearPageDirty(page);
-      }
     }
   } 
 }

--Boundary-00=_1iZC/4YfMlaKzeo--
