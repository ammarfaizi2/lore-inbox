Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129319AbQLRTqK>; Mon, 18 Dec 2000 14:46:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129391AbQLRTqA>; Mon, 18 Dec 2000 14:46:00 -0500
Received: from pizda.ninka.net ([216.101.162.242]:14497 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S129319AbQLRTpr>;
	Mon, 18 Dec 2000 14:45:47 -0500
Date: Mon, 18 Dec 2000 10:58:04 -0800
Message-Id: <200012181858.KAA05797@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: root@chaos.analogic.com
CC: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.95.1001218140412.5366A-100000@chaos.analogic.com>
	(root@chaos.analogic.com)
Subject: Re: VM performance problem
In-Reply-To: <Pine.LNX.3.95.1001218140412.5366A-100000@chaos.analogic.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   Date: Mon, 18 Dec 2000 14:09:00 -0500 (EST)
   From: "Richard B. Johnson" <root@chaos.analogic.com>

   Well I just use free(), nothing more, nothing special, just like a
   typical data-base program.  Free should just set a new break
   address after the reclaimed data falls below some watermarks it has
   established. Both malloc() and free(), use already allocated
   data-space for their work-space (last time I looked at library
   code).

malloc and free maintain their free buffers pools using linked lists,
thus a free() does two stores to the (2 * sizeof(void *)) bytes before
or after that buffer.  Thus the swapping.

Use mmap()/munmap() directly and manage things totally yourself to get
rid of this.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
