Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265594AbUEZNCp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265594AbUEZNCp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 May 2004 09:02:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265586AbUEZNA4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 May 2004 09:00:56 -0400
Received: from mail4.hitachi.co.jp ([133.145.228.5]:27880 "EHLO
	mail4.hitachi.co.jp") by vger.kernel.org with ESMTP id S265581AbUEZNAN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 May 2004 09:00:13 -0400
MIME-Version: 1.0
Date: Wed, 26 May 2004 22:00:06 +0900
Subject: Re: why swap at all?
From: Satoshi Oshima <oshima@sdl.hitachi.co.jp>
To: orders@nodivisions.com, linux-kernel@vger.kernel.org
Message-ID: <JI20040526220006.47968296@sdl.hitachi.co.jp>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
In-Reply-To: <40B43B5F.8070208@nodivisions.com>
References: <40B43B5F.8070208@nodivisions.com>
X-Mailer: JsvMail 5.0 (Shuriken Pro3)
X-Priority: 3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anthony DiSante <orders@nodivisions.com> wrote:
> As a general question about ram/swap and relating to some of the issues 
in 
> this thread:
> 
>       ~500 megs cached yet 2.6.5 goes into swap hell
> 
> Consider this: I have a desktop system with 256MB ram, so I make a 256MB 
> swap partition.  So I have 512MB "memory" and if some process wants more, 
> too bad, there is no more.
> 
> Now I buy another 256MB of ram, so I have 512MB of real memory.  Why not 
> just disable my swap completely now?  I won't have increased my memory's 
> size at all, but won't I have increased its performance lots?
> 
> Or, to make it more appealing, say I initially had 512MB ram and now I 
have 
> 1GB.  Wouldn't I much rather not use swap at all anymore, in this case, 
on 
> my desktop?

I really agree. And I think swappoff is not enough.

Some of my customers have over 4GB of memory. RDMS, 
Java Virtual Machine or Grid system (like Globus tool 
kit) run on the servers. 
Those kinds of application make a lot of threads and 
they have huge amount of shared memory. And those 
shared memory is sometimes mlocked.

I think, in those systems, memory aging itself is 
useless or obstructive in worst case. Because mlocked 
pages which can't be swapped off are on the LRU list.

In such case, aging-off (relevant to process) is 
effective, I think.

Of course, I agree that swap-off or aging-off is 
NEVER always useful. On the contrary, these functions 
may be required by very small number of user.

But it is very important that we can choose 
how we use the OS.


Satoshi Oshima

