Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319092AbSHFOOm>; Tue, 6 Aug 2002 10:14:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319093AbSHFOOm>; Tue, 6 Aug 2002 10:14:42 -0400
Received: from pizda.ninka.net ([216.101.162.242]:50637 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S319092AbSHFOOl>;
	Tue, 6 Aug 2002 10:14:41 -0400
Date: Tue, 06 Aug 2002 07:05:35 -0700 (PDT)
Message-Id: <20020806.070535.24871584.davem@redhat.com>
To: kasperd@daimi.au.dk
Cc: manfred@colorfullife.com, rusty@rustcorp.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: [TRIVIAL] Warn users about machines with non-working WP bit
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D4FDA23.90CAB62F@daimi.au.dk>
References: <3D4FD736.DA443B4B@daimi.au.dk>
	<20020806.065652.12285252.davem@redhat.com>
	<3D4FDA23.90CAB62F@daimi.au.dk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Kasper Dupont <kasperd@daimi.au.dk>
   Date: Tue, 06 Aug 2002 16:16:03 +0200

   "David S. Miller" wrote:
   > What if we have to sleep and page in some memory from disk?
   > 
   > Your idea could lead to deadlock in a multi-threaded app.
   
   Why? The page should eventually get into memory from the disk,
   at this point the process doing the copy can continue, and
   when it finishes the other processes gets waked up. While the
   copy_to_user is in progress all the processes witht this mm
   should be in noninterruptible sleep. The sleeping procces
   doesn't need to do anything to get the page into memory, so I
   cannot see the problem.
   
What if the other thread we freeze is holding a lock we
need in order to get the page from disk?
