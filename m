Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261306AbUK1QT0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261306AbUK1QT0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Nov 2004 11:19:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261503AbUK1QT0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Nov 2004 11:19:26 -0500
Received: from mail.dif.dk ([193.138.115.101]:407 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S261306AbUK1QTU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Nov 2004 11:19:20 -0500
Date: Sun, 28 Nov 2004 17:29:04 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Gadi Oxman <gadio@netvision.net.il>, Jens Axboe <axboe@suse.de>,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH][0/2] ide-tape: small cleanups
Message-ID: <Pine.LNX.4.61.0411281725110.3389@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Small cleanups for ide-tape.

Patch 1:
-----
The patch removes a bunch of unnessesary parantheses from return
statements. There are tons of return statements that look like this: 
return (-EIO);   return (fn());  etc. 
The patch removes these unneeded parentheses.
The patch also removes a lot of spaces from function declarations. There 
is some inconsistency in the file, some functions are declared as  
  void fn() { }
and some as
  void fn () { }
So, the patch changes them to all use a common style. I picked the 
  void fn() { }
form, since (a) it seems to be the most common form used in the kernel as 
a whole, (b) it is the form used in Documentation/CodingStyle, and (c) it 
is the form that reduces the filesize a bit :)


Patch 2 (cut on top of Patch 1): 
-----
This patch ensures that copy_to|from_user() return values get checked and 
dealt with by returning -EFAULT if they fail. Aside from the fact that we 
really want to handle these failures, this patch also silences these 
warnings: 
drivers/ide/ide-tape.c: In function `idetape_copy_stage_from_user': 
drivers/ide/ide-tape.c:2613: warning: ignoring return value of `copy_from_user', declared with attribute warn_unused_result 
drivers/ide/ide-tape.c: In function `idetape_copy_stage_to_user': 
drivers/ide/ide-tape.c:2640: warning: ignoring return value of `copy_to_user', declared with attribute warn_unused_result


Please review these patches. I don't have the hardware to actually test 
them myself. All I have been able to do is compile test them and try to 
convince myself that they are OK by reading the code.


-- 
Jesper Juhl <juhl-lkml@dif.dk>


