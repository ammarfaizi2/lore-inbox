Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263349AbUCNML7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 14 Mar 2004 07:11:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263355AbUCNML6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 14 Mar 2004 07:11:58 -0500
Received: from aun.it.uu.se ([130.238.12.36]:17659 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263349AbUCNML4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 14 Mar 2004 07:11:56 -0500
Date: Sun, 14 Mar 2004 13:11:49 +0100 (MET)
Message-Id: <200403141211.i2ECBnJw008435@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: ak@suse.de, torvalds@osdl.org
Subject: Re: [PATCH] Fix a 64bit bug in kobject module request
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Mar 2004 05:09:43 +0100, Andi Kleen wrote:
>>From Takashi Iwai
>
>kobj_lookup had a 64bit bug, which caused the request of a unknown
>character device to burn CPU instead of failing quickly.
>
>diff -burpN -X ../KDIFX linux-vanilla/drivers/base/map.c linux-2.6.4-amd64/drivers/base/map.c
>--- linux-vanilla/drivers/base/map.c	2003-09-23 08:03:40.000000000 +0200
>+++ linux-2.6.4-amd64/drivers/base/map.c	2004-03-08 15:23:45.000000000 +0100
>@@ -96,7 +96,7 @@ struct kobject *kobj_lookup(struct kobj_
> {
> 	struct kobject *kobj;
> 	struct probe *p;
>-	unsigned best = ~0U;
>+	unsigned long best = ~0UL;
> 
> retry:
> 	down_read(domain->sem);

My Athlon64 (FC1/x86_64 user-space) has been having mysterious
module autoloading failures where some modules (char-major-10-$N)
autoloaded just fine, but many ({char,block}-major-$N) did not.
This patch solved that problem.

Thanks Andi.

/Mikael
