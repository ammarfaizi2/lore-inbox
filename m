Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317587AbSHHOpp>; Thu, 8 Aug 2002 10:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317590AbSHHOpp>; Thu, 8 Aug 2002 10:45:45 -0400
Received: from pizda.ninka.net ([216.101.162.242]:47074 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S317587AbSHHOpo>;
	Thu, 8 Aug 2002 10:45:44 -0400
Date: Thu, 08 Aug 2002 07:36:30 -0700 (PDT)
Message-Id: <20020808.073630.37512884.davem@redhat.com>
To: rusty@rustcorp.com.au
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpumask_t
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20020808074422.E414A4ADA@lists.samba.org>
References: <20020808074422.E414A4ADA@lists.samba.org>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Rusty Russell <rusty@rustcorp.com.au>
   Date: Thu, 08 Aug 2002 17:39:18 +1000

   I've tested this now with making cpumask_t a struct, and it works fine
   (at the moment it's unsigned long for every arch, no change).

It worked because you cast the thing to (unsigned long *) in every
bitops.  We either:

1) shouldn't need to do that, meaning cpumask_t must be a long
   or array or longs

2) you need to abstract away bitops on cpumask_t so that one
   _really_ could make cpumask_t a struct with things other
   than the mask itself inside, so cpumask_test, cpumask_add,
   cpumask_remove or however you'd like to name them

Didn't we go through a lot of effort to sanitize bitops types
and kill the ugly casts? :-))))

