Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261801AbTJRTmt (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Oct 2003 15:42:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261806AbTJRTmt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Oct 2003 15:42:49 -0400
Received: from dbl.q-ag.de ([80.146.160.66]:21461 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261801AbTJRTmp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Oct 2003 15:42:45 -0400
Message-ID: <3F919763.1000901@colorfullife.com>
Date: Sat, 18 Oct 2003 21:41:23 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030701
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: John Mock <kd6pag@qsl.net>
CC: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PPC: slab error in cache_free_debugcheck() from sd_revalidate_disk
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John wrote:

>Hardware: PowerMac 8500 (see attached 'lspci' and 'dmesg' for details), 
>	  ADB keyboard/mouse, USB mouse, Sony 100ES monitor
>Software: Debian 'Testing' branch
>
>Sorry, this may not be a very helpful bug report.  Let me know what additional
>information might be helpful and perhaps i can rig up a serial console for
>this beast.
>  
>
[snip]

>Oct 14 15:47:34 penngrove kernel: cddeec88: redzone 1: 0x0, redzone 2: 0x170fc2a5.
>O
>
That looks like a bug Ben reported some time ago: The dma controller 
trashes the whole cacheline when it transfers data from disk to memory.
I think the only solution is to disable redzoning for the kmalloc 
caches, or to use get_free_pages instead of kmalloc for the disk buffers,.

--
    Manfred

