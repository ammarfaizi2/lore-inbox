Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263492AbTHWWPx (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Aug 2003 18:15:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263788AbTHWWPx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Aug 2003 18:15:53 -0400
Received: from fw.osdl.org ([65.172.181.6]:58247 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263492AbTHWWPv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Aug 2003 18:15:51 -0400
Date: Sat, 23 Aug 2003 15:18:14 -0700
From: Andrew Morton <akpm@osdl.org>
To: Vinay K Nallamothu <vinay-rc@naturesoft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.6.0-test4] wait.h: fix spin_lock_irqrestore typo
Message-Id: <20030823151814.01fa53b1.akpm@osdl.org>
In-Reply-To: <1061646928.1141.33.camel@lima.royalchallenge.com>
References: <1061646928.1141.33.camel@lima.royalchallenge.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vinay K Nallamothu <vinay-rc@naturesoft.net> wrote:
>
> A small patch to fix a spin_lock typo in the macro add_wait_queue_cond
> 
>  Vinay
> 
>  --- linux-2.6.0-test4/include/linux/wait.h	2003-07-15 17:22:56.000000000 +0530
>  +++ linux-2.6.0-test4-nvk/include/linux/wait.h	2003-08-23 19:08:36.000000000 +0530
>  @@ -232,7 +232,7 @@
>   			_raced = 1;				\
>   			__remove_wait_queue((q), (wait));	\
>   		}						\
>  -		spin_lock_irqrestore(&(q)->lock, flags);	\
>  +		spin_unlock_irqrestore(&(q)->lock, flags);	\
>   		_raced;						\
>   	})

Well that's obviously had a lot of testing.

It has no callers; I'll just kill it.

