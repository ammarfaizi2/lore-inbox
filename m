Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272426AbTHKI7l (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Aug 2003 04:59:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272431AbTHKI7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Aug 2003 04:59:40 -0400
Received: from ioskeha.hittite.isp.9tel.net ([62.62.156.27]:58786 "EHLO
	ioskeha.hittite.isp.9tel.net") by vger.kernel.org with ESMTP
	id S272426AbTHKI7e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Aug 2003 04:59:34 -0400
Content-Type: text/plain;
  charset="us-ascii"
From: Francois Cartegnie <fcartegnie@free.fr>
To: linux-kernel@vger.kernel.org
Subject: Crash on kmalloc with GFP_KERNEL
Date: Mon, 11 Aug 2003 11:09:26 +0200
User-Agent: KMail/1.4.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <200308111109.26569.fcartegnie@free.fr>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I'm currently extending the u32 classifier (linux traffic control).
I've experienced some strange behaviour with memory allocation :
A single kmalloc with GFP_KERNEL leads to kernel panic (BUG, slab.c) when 
there's multiple requests matching the classifier. 
Thinking about concurrent access, I tried to lock the allocation with 
semaphores.
The only way to solve it was to use GFP_ATOMIC (but I also experienced It 
still crash in some cases).

This is really similar to the bug report made on netfilter buzilla:
https://bugzilla.netfilter.org/cgi-bin/bugzilla/show_bug.cgi?id=68

So I guess the memory allocations are interrupted by arrival of new packets 
and then crash.
-Is there any way to fix it to use GFP_KERNEL memory allocations ?

-Also, the original u32 code uses GFP_KERNEL for storing it's matching rules. 
I guess It would crash here too if the rules are created under heavy network 
traffic. Any idea ?


Greetings,

