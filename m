Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbUKFXRP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbUKFXRP (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 18:17:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261502AbUKFXRO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 18:17:14 -0500
Received: from av1-2-sn3.vrr.skanova.net ([81.228.9.106]:47556 "EHLO
	av1-2-sn3.vrr.skanova.net") by vger.kernel.org with ESMTP
	id S261501AbUKFXRJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 18:17:09 -0500
To: kraxel@bytesex.org
Cc: linux-kernel list <linux-kernel@vger.kernel.org>,
       Eyal Lebedinsky <eyal@eyal.emu.id.au>
Subject: Re: 2.6.10-rc1 bttv oops in btcx_riscmem_free
References: <41839BFC.1070302@eyal.emu.id.au> <m3wtx86s07.fsf@telia.com>
From: Peter Osterlund <petero2@telia.com>
Date: 07 Nov 2004 00:17:00 +0100
In-Reply-To: <m3wtx86s07.fsf@telia.com>
Message-ID: <m3llder2j7.fsf@telia.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Osterlund <petero2@telia.com> writes:

> Eyal Lebedinsky <eyal@eyal.emu.id.au> writes:
> 
> > Watching on Mythtv, I stopped watching on the client. at this point
> > the picture froze. Looking in dmesg I see this oops. The machine
> > quicly becomes unusable ('ps aux' hangs).
> > 
> > I then applied the v4l patches off the list. Still the same problem.
> > 
> > Unable to handle kernel paging request at virtual address 85525fe9
> 
> I have similar problems using 2.6.10-rc1-bk8. Often when I exit
> tvtime, I get "unable to handle kernel paging request" or "unable to
> handle kernel NULL pointer", see below.

I found the bug. Here is a patch to fix it.

Signed-off-by: Peter Osterlund <petero2@telia.com>
---

 linux-petero/drivers/media/video/video-buf.c |    2 +-
 1 files changed, 1 insertion(+), 1 deletion(-)

diff -puN drivers/media/video/video-buf.c~bttv-fix3 drivers/media/video/video-buf.c
--- linux/drivers/media/video/video-buf.c~bttv-fix3	2004-11-07 00:10:04.632421064 +0100
+++ linux-petero/drivers/media/video/video-buf.c	2004-11-07 00:10:04.635420608 +0100
@@ -1063,7 +1063,7 @@ videobuf_vm_close(struct vm_area_struct 
 				continue;
 			map->q->bufs[i]->map   = NULL;
 			map->q->bufs[i]->baddr = 0;
-			map->q->ops->buf_release(vma->vm_file,map->q->bufs[i]);
+			map->q->ops->buf_release(vma->vm_file->private_data,map->q->bufs[i]);
 		}
 		kfree(map);
 	}
_

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
