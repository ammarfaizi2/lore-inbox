Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313305AbSHWWwi>; Fri, 23 Aug 2002 18:52:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313558AbSHWWwi>; Fri, 23 Aug 2002 18:52:38 -0400
Received: from pizda.ninka.net ([216.101.162.242]:28574 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S313305AbSHWWwi>;
	Fri, 23 Aug 2002 18:52:38 -0400
Date: Fri, 23 Aug 2002 15:41:14 -0700 (PDT)
Message-Id: <20020823.154114.99162408.davem@redhat.com>
To: haveblue@us.ibm.com
Cc: manand@us.ibm.com, bcrl@redhat.com, alan@lxorguk.ukuu.org.uk,
       bhartner@us.ibm.com, linux-kernel@vger.kernel.org,
       lse-tech@lists.sourceforge.net, lse-tech-admin@lists.sourceforge.net
Subject: Re: [Lse-tech] Re: (RFC): SKB Initialization
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <3D666531.4020909@us.ibm.com>
References: <OF1AAF39E9.D733B26C-ON87256C1E.004ACC87@boulder.ibm.com>
	<3D666531.4020909@us.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dave Hansen <haveblue@us.ibm.com>
   Date: Fri, 23 Aug 2002 09:39:13 -0700

   Where are interrupts disabled?   I just went through a set of kernprof 
   data and traced up the call graph.  In the most common __kfree_skb 
   case, I do not believe that it has interupts disabled.  I could be 
   wrong, but I didn't see it.

That's completely right.  interrupts should never be disabled when
__kfree_skb is executed.  It used to be possible when we allowed
it to be invoked from interrupt handlers, but that is illegal and
we have kfree_skb_irq which just reschedules the actual __kfree_skb
to a software interrupt.

So I agree with you, Mala's claims seem totally bogus and not well
founded at all.
