Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261353AbREQAXC>; Wed, 16 May 2001 20:23:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261355AbREQAWw>; Wed, 16 May 2001 20:22:52 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:11534 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S261353AbREQAWt>; Wed, 16 May 2001 20:22:49 -0400
Subject: Re: oops in 2.4.4-ac9 (mm/slab.c)
To: afranck@gmx.de (Andreas Franck)
Date: Thu, 17 May 2001 01:19:34 +0100 (BST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.31.0105170103380.2918-100000@dg1kfa.ampr.org> from "Andreas Franck" at May 17, 2001 01:05:26 AM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E150BVu-0004ja-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> when this happened, and I was not able to log in onto any console or
> terminal afterwards (probably because tty_open failed very miserably
> on the way?)

Its a deliberate debugging trap.

> #if DEBUG
>         if (cachep->flags & SLAB_POISON)
>                 if (kmem_check_poison_obj(cachep, objp))
>                         BUG();
> 			^^^^^^ This one is triggered

Someone freed memory and then scribbled on it. 

The first thing useful here is to know which drivers you were using shortly
before the oops
