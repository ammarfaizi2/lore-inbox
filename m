Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261552AbSJPWGE>; Wed, 16 Oct 2002 18:06:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261550AbSJPWGE>; Wed, 16 Oct 2002 18:06:04 -0400
Received: from pizda.ninka.net ([216.101.162.242]:41396 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S261540AbSJPWF7>;
	Wed, 16 Oct 2002 18:05:59 -0400
Date: Wed, 16 Oct 2002 15:03:23 -0700 (PDT)
Message-Id: <20021016.150323.101559793.davem@redhat.com>
To: mkanand@us.ibm.com
Cc: akpm@digeo.com, lse-tech@lists.sourceforge.net,
       linux-kernel@vger.kernel.org, hartner@austin.ibm.com,
       linux-net@vger.kernel.org
Subject: Re: Skb initialization patch
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3DADD6FD.E898DD61@us.ibm.com>
References: <3DADD6FD.E898DD61@us.ibm.com>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Mala Anand <mkanand@us.ibm.com>
   Date: Wed, 16 Oct 2002 16:15:41 -0500
   
   Looks like we were trying to take advantage of this feature by
   initializing before freeing it and this is good for UNI but for SMP
   there is no guarantee that the freed skbs will be given back to the
   same CPU.

There are not guarentees, but %99 of the time what is supposed to
happen is that either the per-cpu skb_head_pool[] or the per-cpu slab
cache give back the data on the same processor.

If this isn't happening, fix the head pool or SLAB.  Because if
you fix it there you'll fix the SMP behavior of every other SLAB
cache in the kernel, not just SKBs.

If the current cpu's skb_head_pool[] is being depleted in your
tests, it should go to the per-cpu SLAB pool, if that is being
depleted and thus it is going to other cpu's pools you should
work on making SLAB not hit that case so often.

2.5.38 is really old too, results with current 2.5.x would be
appreciated.  If you are unable to run your tests with current
2.5.x kernels, work to fix those problems instead of telling me
"I can't test with current 2.5.x"

Also, I would really appreciate it if you could walk through the
2.5.x versions between the "good" and "bad" performance points
you noted in postings yesterday.  Please do not walk off to other
tasks such as this SKB initialization patch when we have regressions
in other areas.
