Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267795AbTBYHPO>; Tue, 25 Feb 2003 02:15:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267796AbTBYHPO>; Tue, 25 Feb 2003 02:15:14 -0500
Received: from mail0.rawbw.com ([198.144.192.41]:10509 "EHLO mail0.rawbw.com")
	by vger.kernel.org with ESMTP id <S267795AbTBYHPM>;
	Tue, 25 Feb 2003 02:15:12 -0500
Message-ID: <006a01c2dc9e$e4f685a0$0b01a8c0@john1>
From: "John Newlin" <jnewlin@tsoft.com>
To: <linux-kernel@vger.kernel.org>
Subject: Cache aliasing
Date: Mon, 24 Feb 2003 23:24:11 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4920.2300
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4920.2300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm working on a port of Linux to a processor that has virutally
indexed caches that are larger than the page size.  This brings up
the documented feature of cache aliasing.

As I am looking over how other ports (sh-4, sparc64 etc) have solved
the problem, it made me wonder if this is the best way to solve
the problem.

Would it make more sense to just always ensure that your 
virtual and physical pages had matching "color" bits?

For example, in the memory allocator, you would have to pass in
the vaddr that you wanted to map to physical space, and then the
memory allocator would find a physical page of the correct color.

And in the case where you are mirroring a user page into kernel
space, you would have to choose a virtual address of the correct
colour.  On architectures like x86 where cache aliasing is never
a concern, this code could be optimized away.


The benefits would be, any architecture that has cache aliasing
wouldn't have to go through hoops to keep memory coherent, and
depending on how often memory is flushed in the caches it might
give some performance boost.



-John 
