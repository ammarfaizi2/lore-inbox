Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262161AbTKVKzm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Nov 2003 05:55:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262164AbTKVKzm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Nov 2003 05:55:42 -0500
Received: from dbl.q-ag.de ([80.146.160.66]:54912 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S262161AbTKVKzl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Nov 2003 05:55:41 -0500
Message-ID: <3FBF409F.7070405@colorfullife.com>
Date: Sat, 22 Nov 2003 11:55:27 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: pinotj@club-internet.fr
CC: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Oops]  i386 mm/slab.c (cache_flusharray)
References: <mnet1.1069487254.8717.pinotj@club-internet.fr>
In-Reply-To: <mnet1.1069487254.8717.pinotj@club-internet.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

pinotj@club-internet.fr wrote:

>c6fd7870: redzone 1: 0x170fc2a5, redzone 2: 0x160fc2a5.
>
Single bit error: redzone 2 must be 0x170fc2a5.

>---
>System looks OK, I tried a second compilation just after and this time I got an oops:
>---
>slab: double free detected in cache 'buffer_head', objp cc3f9798, objnr 26, slabp cc3f9000, s_mem cc3f9180 bufctl f7ffffff.
>  
>
Good.

+#define BUFCTL_END	0xfeffFFFF
+#define BUFCTL_FREE	0xf7ffFFFE
+#define	SLAB_LIMIT	0xf0ffFFFD

f7ffffff is not a valid value, slab never writes that into a bufctl. 
Someone did a ++ or "|= 1", or a hw bug.
I think the Athlon cpus have ECC for the L2 cache - could you check in 
the bios that ECC checking is enabled?

--
    Manfred

