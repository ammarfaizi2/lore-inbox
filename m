Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275912AbTHOME1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Aug 2003 08:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275915AbTHOME1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Aug 2003 08:04:27 -0400
Received: from smtp3.wanadoo.fr ([193.252.22.25]:40493 "EHLO
	mwinf0603.wanadoo.fr") by vger.kernel.org with ESMTP
	id S275912AbTHOMEA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Aug 2003 08:04:00 -0400
Message-ID: <3F3CE8BF.6080800@wanadoo.fr>
Date: Fri, 15 Aug 2003 14:05:51 +0000
From: Philippe Elie <phil.el@wanadoo.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020605
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jozsef Kadlecsik <kadlec@blackhole.kfki.hu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: kmem_cache_destroy: Can't free all objects (2.6)
References: <Pine.LNX.4.33.0308142131130.8530-100000@blackhole.kfki.hu>
Content-Type: multipart/mixed;
 boundary="------------040602070408060507090403"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040602070408060507090403
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Jozsef Kadlecsik wrote:
> On Thu, 14 Aug 2003, Philippe Elie wrote:
> 
> 
>>>This happens both with 2.5.74 and 2.6.0-test1.
>>
>>I fixed a bug with exactly this symptom, all object freed but
>>the cache was retaining some object internally. I look 2.6.0-test1
>>and the fix is in, apologies if you already did it correctly
>>but can you double check the bug is really in 2.6.0-test1.
> 
> 
> Yes. Before I posted my mail I googled a lot and found your fix. I
> checked the source of 2.6.0-test1 and your fix is there of course.

Thanks, I wanted to be sure before digging in the source. Try
the attached patch please.

regards,
Philippe Elie


--------------040602070408060507090403
Content-Type: text/plain;
 name="slab.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="slab.diff"

--- mm/slab.c~	2003-07-14 03:36:48.000000000 +0000
+++ mm/slab.c	2003-08-15 13:59:34.000000000 +0000
@@ -2349,7 +2349,7 @@
 	int tofree;
 
 	check_spinlock_acquired(cachep);
-	if (ac->touched) {
+	if (ac->touched && !force) {
 		ac->touched = 0;
 	} else if (ac->avail) {
 		tofree = force ? ac->avail : (ac->limit+4)/5;

--------------040602070408060507090403--

