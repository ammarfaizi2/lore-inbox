Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310435AbSEMAhZ>; Sun, 12 May 2002 20:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314454AbSEMAhY>; Sun, 12 May 2002 20:37:24 -0400
Received: from loisexc2.loislaw.com ([12.5.234.240]:26121 "EHLO
	loisexc2.loislaw.com") by vger.kernel.org with ESMTP
	id <S310435AbSEMAhX>; Sun, 12 May 2002 20:37:23 -0400
Message-ID: <4188788C3E1BD411AA60009027E92DFD0962E24F@loisexc2.loislaw.com>
From: "Rose, Billy" <wrose@loislaw.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Segfault hidden in list.h
Date: Sun, 12 May 2002 19:37:25 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code inside of __list_add:

next->prev = new;
new->next = next;
new->prev = prev;
pre-next = new;

needs to be altered to:

new->prev = prev;
new->next = next;
next->prev = new;
prev->next = new;

If something is accessing the list in reverse at the time of insertion and
"next->prev = new;" has been executed, there exists a moment when new->prev
may contain garbage if the element had been used in another list and is
being transposed into a new one. Even if garbage is not present, and the
element had just been initialized (i.e. new->prev = new), a false list head
will appear briefly (from the executing thread's point of view).

Billy Rose 
wrose@loislaw.com
