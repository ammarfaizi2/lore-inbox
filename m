Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261465AbUBVPNI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Feb 2004 10:13:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261515AbUBVPNI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Feb 2004 10:13:08 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:38804 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261465AbUBVPNF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Feb 2004 10:13:05 -0500
Message-ID: <4038C6F5.1070309@colorfullife.com>
Date: Sun, 22 Feb 2004 16:12:53 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.4.1) Gecko/20031114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
CC: linux-kernel@vger.kernel.org,
       Krzysztof Benedyczak <golbi@mat.uni.torun.pl>
Subject: Re: [RFC][PATCH] 2/6 POSIX message queues
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arnd wrote:

>Nothing difficult here, but slow and avoidable if you have the
>structures laid out properly.
>
I thought about using s32 for the kernel mq_attr structure, and didn't 
like it: It would mean that 64-bit archs running native 64-bit apps must 
do a conversion - glibc must expose a structure with long values.
Additionally, the posix message queue API uses 3 structures with long 
values, and only one of them is new - we'll need wrappers anyway.
The actual values in the mq_attr structure would fit into s32:
- mq_flags is 0 or O_NONBLOCK
- mq_maxmsg is less than 32k (kmalloc'ed array of pointers)
- mq_msgsize is theoretically unlimited, but the current implementation 
arbitrarily limits the value to 1 MB.

--
    Manfred


