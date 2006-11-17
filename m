Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1424918AbWKQV3F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424918AbWKQV3F (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 16:29:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424924AbWKQV3E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 16:29:04 -0500
Received: from smtp009.mail.ukl.yahoo.com ([217.12.11.63]:18519 "HELO
	smtp009.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S1424918AbWKQV3D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 16:29:03 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.it;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Disposition:Content-Type:Content-Transfer-Encoding:Message-Id;
  b=y/HKq4aN0r45QGzYk/jQxPbZU6MjTMjreybmcRkLzdaLszUJF52vO0+MDUqGQL+SpuliAtnVX2YzSD6dYejPrYRno6tZ7jXBQ65q2680p92W1l32r3aHKdavP8+uUjeVt+g6JZCh3W0x84oo/oKfnaXVxyeT1uc7toLr8LK0LLw=  ;
X-YMail-OSG: acmQCpcVM1lBIIirjuLhxSDmojsVLkzw07gbnldUdLvWuuaUJqxvZwXE3vZH6KrUeiV6NVYY6l7QyYqcYvEQj7WrMK2A.fuu.qDM_GqBYEEYZOIwaQI-
From: Blaisorblade <blaisorblade@yahoo.it>
To: LKML <linux-kernel@vger.kernel.org>
Subject: We're still coping with GCC < 3.0
Date: Fri, 17 Nov 2006 23:28:58 +0200
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200611172228.58658.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC me on replies as I'm not subscribed)
In arch/i386/kernel/irq.c (current git head) I found this comment:

/*
 * These should really be __section__(".bss.page_aligned") as well, but
 * gcc's 3.0 and earlier don't handle that correctly.
 */
static char softirq_stack[NR_CPUS * THREAD_SIZE]
                __attribute__((__aligned__(THREAD_SIZE)));

static char hardirq_stack[NR_CPUS * THREAD_SIZE]
                __attribute__((__aligned__(THREAD_SIZE)));

That should be fixed now that we require GCC 3.0, not?

Btw, there are other such comments, like in include/asm-i386/semaphore.h: 
sema_init (for GCC 2.7!). That one might not be the case to fix because of the 
increased stack usage

I've seen other similar tests around, so I thought that it'd be useful to 
centralize all tests for GCC versions to headers like include/compiler.h so 
they're promptly removed when deprecating old compilers.

What about this?
-- 
Inform me of my mistakes, so I can keep imitating Homer Simpson's "Doh!".
Paolo Giarrusso, aka Blaisorblade (Skype ID "PaoloGiarrusso", ICQ 215621894)
http://www.user-mode-linux.org/~blaisorblade

Chiacchiera con i tuoi amici in tempo reale! 
 http://it.yahoo.com/mail_it/foot/*http://it.messenger.yahoo.com 
