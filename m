Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130078AbQLJXWK>; Sun, 10 Dec 2000 18:22:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129361AbQLJXWA>; Sun, 10 Dec 2000 18:22:00 -0500
Received: from zero.tech9.net ([209.61.188.187]:23300 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S130138AbQLJXV4>;
	Sun, 10 Dec 2000 18:21:56 -0500
Date: Sun, 10 Dec 2000 17:51:31 -0500 (EST)
From: "Robert M. Love" <rml@tech9.net>
To: <linux-kernel@vger.kernel.org>
Subject: [HOWTO] Quick howto fix on the new task queue
Message-ID: <Pine.LNX.4.30.0012101745130.18138-100000@phantasy.awol.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the majority of the problems i am seeing with the new task queue is that,
on list init, *next is still being used. all of that was replaced by a
single list member in the new implementation.

on init, *next is typically set to NULL. for the new task queue, there is
a macro to initialize the list: INIT_LIST_HEAD, so we simply need to use
that in lieu.

thus, replace something like:
penguin->tq.next -> NULL;

with:
INIT_LIST_HEAD(&penguin->tq.list);

this is the only problem i am seeing in pre8 ... i am still looking for
some documentation on the new interface, but the source (where i got the
above, hopefully i am right) is readable.

-- 
Robert M. Love
rml@ufl.edu
rml@tech9.net

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
