Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262763AbUCOVJN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:09:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUCOVJN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:09:13 -0500
Received: from smtp05.web.de ([217.72.192.209]:6664 "EHLO smtp.web.de")
	by vger.kernel.org with ESMTP id S262763AbUCOVJE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:09:04 -0500
From: Thomas Schlichter <thomas.schlichter@web.de>
To: Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.4-mm2
Date: Mon, 15 Mar 2004 22:08:47 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040314172809.31bd72f7.akpm@osdl.org> <200403152157.02051.thomas.schlichter@web.de>
In-Reply-To: <200403152157.02051.thomas.schlichter@web.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200403152208.49491.thomas.schlichter@web.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, March 15. 2004 21:57, I wrote:
> Hi,
>
> with 2.6.4-mm2 I get following badness on boot:
>
> Badness in as_insert_request at drivers/block/as-iosched.c:1513
> Call Trace:
>  [<c022e326>] as_insert_request+0x166/0x190
>  [<c0225af8>] __elv_add_request+0x28/0x60
>  [<c0228b9b>] __make_request+0x47b/0x540
>  [<c0228d75>] generic_make_request+0x115/0x1d0
>  [<c011efd0>] autoremove_wake_function+0x0/0x40
>  [<c0228e80>] submit_bio+0x50/0xf0
>  [<c0162f58>] __bio_add_page+0x88/0x110
>  [<c016300c>] bio_add_page+0x2c/0x40
>  [<c013be4f>] submit+0x9f/0xf0
>  [<c03aa14a>] check_sig+0x1a/0x70
>  [<c03aa4b6>] read_suspend_image+0x6/0x60
>  [<c03aa565>] pmdisk_read+0x55/0x70
>  [<c013b1a5>] pm_resume+0x15/0x90
>  [<c039c7a3>] do_initcalls+0x23/0xc0
>  [<c0103090>] init+0x0/0x150
>  [<c01030c5>] init+0x35/0x150
>  [<c0105288>] kernel_thread_helper+0x0/0x18
>  [<c010528d>] kernel_thread_helper+0x5/0x18
>
> After that one I get many badnesses in line 977 of the same file. I
> commented out that WARN_ON(..) to be able to capture the badness above. The
> message before the badness is:
> 	PM: Reading pmdisk image.
> After the badness following message is printed:
> 	PM: Resume from disk failed.
>
> So there seems to be a conflict between PM-resume (btw, I did not use
> suspend to disk) and as-iosched. There is no problem if I use
> "elevator=cfq", "elevator=deadline" or "elevator=noop".

Now I verified that "pmdisk=off" also removes the badnesses...

Regards
   Thomas

