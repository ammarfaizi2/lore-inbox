Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319111AbSHGSau>; Wed, 7 Aug 2002 14:30:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319117AbSHGSau>; Wed, 7 Aug 2002 14:30:50 -0400
Received: from zeus.kernel.org ([204.152.189.113]:54718 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S319111AbSHGS3a>;
	Wed, 7 Aug 2002 14:29:30 -0400
Date: Wed, 07 Aug 2002 11:18:43 -0700 (PDT)
Message-Id: <20020807.111843.15996855.davem@redhat.com>
To: willy@debian.org
Cc: rusty@rustcorp.com.au, george@mvista.com, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org
Subject: Re: softirq parameters
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020807192314.H24631@parcelfarce.linux.theplanet.co.uk>
References: <20020804.223746.89817190.davem@redhat.com>
	<20020807152423.3577a5cc.rusty@rustcorp.com.au>
	<20020807192314.H24631@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Matthew Wilcox <willy@debian.org>
   Date: Wed, 7 Aug 2002 19:23:14 +0100

   On Wed, Aug 07, 2002 at 03:24:23PM +1000, Rusty Russell wrote:
   > Things haven't been changed over because I haven't pushed the per-cpu
   > interface changes (required for some archs 8() to Linus yet.  But you'll
   > want them so we can save space (you only need allocate per-cpu data for
   > cpus where cpu_possible(i) is true).
   
   So what we want is something more like:

Yes that would work.

I'm starting to become leery about this percpu stuff, which ends up
moving critical data structures (in this case softnet) out of the main
kernel image (and thus out of the single large PAGE_SIZE entry many
platforms use to map that part of the kernel).

Since all the per-cpu stuff ends up in the same cluster of bootmem
it probably doesn't matter so much.  Here's to hoping that's true :-)
