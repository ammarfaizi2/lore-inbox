Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154714AbQDIJTF>; Sun, 9 Apr 2000 05:19:05 -0400
Received: by vger.rutgers.edu id <S154695AbQDIJSx>; Sun, 9 Apr 2000 05:18:53 -0400
Received: from [216.101.162.242] ([216.101.162.242]:33158 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S154715AbQDIJQa>; Sun, 9 Apr 2000 05:16:30 -0400
Date: Sun, 9 Apr 2000 02:19:03 -0700
Message-Id: <200004090919.CAA02908@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: manfreds@colorfullife.com
Cc: alan@lxorguk.ukuu.org.uk, kanoj@google.engr.sgi.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org, torvalds@transmeta.com
In-reply-to: <38F048F5.1FABC033@colorfullife.com> (message from Manfred Spraul on Sun, 09 Apr 2000 11:10:13 +0200)
Subject: Re: zap_page_range(): TLB flush race
References: <E12e4mo-0003Pn-00@the-village.bc.nu> <38F048F5.1FABC033@colorfullife.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   Date: Sun, 09 Apr 2000 11:10:13 +0200
   From: Manfred Spraul <manfreds@colorfullife.com>

   I don't understand the purpose of flush_page_to_ram():

It's a (bad) attempt to deal with virtually indexed caches which
are larger than the page size of the machine.  Generally, when
the kernel writes to a page which potentially can subsequently
accessed from user mappings, it must call flush_page_to_ram.

It flushes the kernel-view page out of the caches and thus
makes main memory up to date, this way when the user accesses
the page from his mapping he won't see stale data if he happens
to have the page mapped at a bad "virtual alias" of what the
kernel maps it at.

It sucks, I'd like to kill it along with flush_icache_page.

I have been working a lot recently on something which is clean and
hopefully can allow these things to die.  But I don't want to talk
more about it until I am able to come up with an implementation which
I am happy with, because until that time it may as well not exist.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
