Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbTFXVqo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jun 2003 17:46:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262687AbTFXVqo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jun 2003 17:46:44 -0400
Received: from dm6-35.slc.aros.net ([66.219.221.35]:7306 "EHLO cyprus")
	by vger.kernel.org with ESMTP id S262598AbTFXVql (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jun 2003 17:46:41 -0400
Message-ID: <3EF8CA10.4030701@aros.net>
Date: Tue, 24 Jun 2003 16:00:48 -0600
From: Lou Langholtz <ldl@aros.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: jds <jds@soltis.cc>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: Kernel Panic in 2.5.73-mm1 OOps part.
References: <20030624191740.M38428@soltis.cc> <3EF8C9A3.5020206@aros.net>
In-Reply-To: <3EF8C9A3.5020206@aros.net>
Content-Type: multipart/mixed;
 boundary="------------080805060305090804050004"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080805060305090804050004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

>
>
>> .. . .
>
> I'm *guestimating* that the following patch will fix this problem. Let 
> me know if you use it wether it makes this problem go away or not. 
> Note that to me at least, blk_init_queue() should be responsible for 
> initializing this memory not the driver. Either way, something has to 
> initialize request_queue.kobj.kset otherwise I think this is the 
> result when the kset field can be any value.
>
Woops... pressed send before doing the attachment...

--------------080805060305090804050004
Content-Type: text/plain;
 name="patch-2.5.73-nbd"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-2.5.73-nbd"

--- drivers/block/nbd.c	2003-06-24 14:39:59.043718133 -0600
+++ drivers/block/nbd-new.c	2003-06-24 15:28:04.318158305 -0600
@@ -695,6 +695,7 @@
 			put_disk(disk);
 			goto out;
 		}
+		memset(disk->queue, 0, sizeof(struct request_queue));
 		blk_init_queue(disk->queue, do_nbd_request, &nbd_lock);
 	}
 

--------------080805060305090804050004--

