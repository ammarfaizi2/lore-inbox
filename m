Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315941AbSGYSen>; Thu, 25 Jul 2002 14:34:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316106AbSGYSen>; Thu, 25 Jul 2002 14:34:43 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:63245 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S315941AbSGYSen>;
	Thu, 25 Jul 2002 14:34:43 -0400
Message-ID: <3D404506.45E6900@zip.com.au>
Date: Thu, 25 Jul 2002 11:35:50 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
CC: linux-kernel@vger.kernel.org, wli@holomorphy.com, torvalds@transmeta.com,
       jsantos@austin.ibm.com
Subject: Re: [PATCH] Missing memory barrier in pte_chain_unlock
References: <20020725005932.GA18140@krispykreme>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anton Blanchard wrote:
> 
> ...
> +       smp_mb__before_clear_bit();
>         clear_bit(PG_chainlock, &page->flags);

Bah.   The problem with this smp_mb thing is that nobody knows
what it does, nobody remembers to do it and it's as ugly as sin.

I bet there are plenty of identical bugs around the place which
haven't been discovered yet.

Is there some clean, centralised way of fixing this problem
permanently?

Correctness comes first.  Why not move the barrier into
clear_bit() and then have a clear_bit_no_mb() operation for those
performance-sensitive places where the barrier is not needed?

 
-
