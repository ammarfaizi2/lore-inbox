Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314529AbSH0GNP>; Tue, 27 Aug 2002 02:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314548AbSH0GNP>; Tue, 27 Aug 2002 02:13:15 -0400
Received: from pizda.ninka.net ([216.101.162.242]:11402 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S314529AbSH0GNO>;
	Tue, 27 Aug 2002 02:13:14 -0400
Date: Mon, 26 Aug 2002 23:11:57 -0700 (PDT)
Message-Id: <20020826.231157.10296323.davem@redhat.com>
To: dipankar@in.ibm.com
Cc: rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com, davej@suse.de, andrea@suse.de,
       paul.mckenney@us.ibm.com
Subject: Re: [BKPATCH] Read-Copy Update 2.5
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020827114152.A2072@in.ibm.com>
References: <20020827022239.C31269@in.ibm.com>
	<20020826193708.0C64C2C07B@lists.samba.org>
	<20020827114152.A2072@in.ibm.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Dipankar Sarma <dipankar@in.ibm.com>
   Date: Tue, 27 Aug 2002 11:41:52 +0530

   On Tue, Aug 27, 2002 at 10:24:30AM +1000, Rusty Russell wrote:
   > > +#ifdef CONFIG_PREEMPT
   > > +/* Fake initialization to work around compiler breakage */
   > > +DEFINE_PER_CPU(atomic_t[2], rcu_preempt_cntr) = 
   > > +			{ATOMIC_INIT(0), ATOMIC_INIT(0)};
   > > +DEFINE_PER_CPU(atomic_t, *curr_preempt_cntr) = NULL;
   > > +DEFINE_PER_CPU(atomic_t, *next_preempt_cntr) = NULL;
   > 
   > Also static I assume?
   
   So, only statics are broken by gcc 2.95, right ?

I think it gets both static and non-static wrong.

Why don't we just specify that DEFINE_PER_CPU()'s must
have explicit initializers then we never need to think
about this ever again.
