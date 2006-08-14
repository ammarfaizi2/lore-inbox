Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751937AbWHNJCg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751937AbWHNJCg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 05:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751951AbWHNJCg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 05:02:36 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:6554 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1751937AbWHNJCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 05:02:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH -mm 5/5] swsusp: Use memory bitmaps during resume
Date: Mon, 14 Aug 2006 11:00:38 +0200
User-Agent: KMail/1.9.3
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
References: <200608101510.40544.rjw@sisk.pl> <200608101523.41107.rjw@sisk.pl> <20060813150457.43ba5893.akpm@osdl.org>
In-Reply-To: <20060813150457.43ba5893.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608141100.38695.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 14 August 2006 00:04, Andrew Morton wrote:
> On Thu, 10 Aug 2006 15:23:41 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > Make swsusp use memory bitmaps to store its internal information during the
> > resume phase of the suspend-resume cycle.
> 
> This patch makes the resume-time disk IO go all slow again.
> 
> Time to read 80k pages:
> 
> 2.6.18-rc4:				24 seconds
> 2.6.18-rc4+akpm-speedups:		10 seconds
> 2.6.18-rc4+akpm-speedups+this-patch:	24 seconds

Well, I removed one line too many, sorry.

 kernel/power/snapshot.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6.18-rc4-mm1/kernel/power/snapshot.c
===================================================================
--- linux-2.6.18-rc4-mm1.orig/kernel/power/snapshot.c
+++ linux-2.6.18-rc4-mm1/kernel/power/snapshot.c
@@ -1278,13 +1278,14 @@ int snapshot_write_next(struct snapshot_
 				chain_init(&ca, GFP_ATOMIC, PG_SAFE);
 				memory_bm_position_reset(&orig_bm);
 				restore_pblist = NULL;
-				handle->sync_read = 0;
 				handle->buffer = get_buffer(&orig_bm, &ca);
+				handle->sync_read = 0;
 				if (!handle->buffer)
 					return -ENOMEM;
 			}
 		} else {
 			handle->buffer = get_buffer(&orig_bm, &ca);
+			handle->sync_read = 0;
 		}
 		handle->prev = handle->cur;
 	}
