Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154606AbQDHXpI>; Sat, 8 Apr 2000 19:45:08 -0400
Received: by vger.rutgers.edu id <S154478AbQDHXmP>; Sat, 8 Apr 2000 19:42:15 -0400
Received: from [216.101.162.242] ([216.101.162.242]:32951 "EHLO pizda.ninka.net") by vger.rutgers.edu with ESMTP id <S154363AbQDHXl7>; Sat, 8 Apr 2000 19:41:59 -0400
Date: Sat, 8 Apr 2000 16:44:14 -0700
Message-Id: <200004082344.QAA02536@pizda.ninka.net>
From: "David S. Miller" <davem@redhat.com>
To: kanoj@google.engr.sgi.com
Cc: manfreds@colorfullife.com, linux-kernel@vger.rutgers.edu, linux-mm@kvack.org
In-reply-to: <200004082111.OAA73647@google.engr.sgi.com> (kanoj@google.engr.sgi.com)
Subject: Re: zap_page_range(): TLB flush race
References: <200004082111.OAA73647@google.engr.sgi.com>
Sender: owner-linux-kernel@vger.rutgers.edu

   From: kanoj@google.engr.sgi.com (Kanoj Sarcar)
   Date: 	Sat, 8 Apr 2000 14:11:05 -0700 (PDT)

   > filemap_sync() calls flush_tlb_page() for each page, but IMHO this is a
   > really bad idea, the performance will suck with multi-threaded apps on
   > SMP.

   The best you can do probably is a flush_tlb_range?

People, look at the callers of filemap_sync, it does range tlb/cache
flushes so the flushes in filemap_sync_pte() are in fact spurious.

Later,
David S. Miller
davem@redhat.com

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
