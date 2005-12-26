Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVLZQgK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVLZQgK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Dec 2005 11:36:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751084AbVLZQgK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Dec 2005 11:36:10 -0500
Received: from dbl.q-ag.de ([213.172.117.3]:6080 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751083AbVLZQgJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Dec 2005 11:36:09 -0500
Message-ID: <43B01BD7.3040209@colorfullife.com>
Date: Mon, 26 Dec 2005 17:35:35 +0100
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20050923 Fedora/1.7.12-1.5.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Steven Rostedt <rostedt@goodmis.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] SLAB - have index_of bug at compile time.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven wrote:

>So I'm going through ever line of code and examining it
>thoroughly, when I find something that could be improved
>
Try to find a kfree implementation that doesn't need virt_to_page(). 
This is a big restriction of the current implementation: It's in the hot 
path, but the operation is only fast on simple systems, not on numa 
systems without a big memory map.
And it makes it impossible to use vmalloc memory as the basis for slabs, 
or to use slab for io memory.

--
    Manfred

