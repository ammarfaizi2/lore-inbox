Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261302AbSIWTLF>; Mon, 23 Sep 2002 15:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261307AbSIWTKR>; Mon, 23 Sep 2002 15:10:17 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261308AbSIWSln>;
	Mon, 23 Sep 2002 14:41:43 -0400
Message-ID: <3D8F4139.6BB60A35@digeo.com>
Date: Mon, 23 Sep 2002 09:28:41 -0700
From: Andrew Morton <akpm@digeo.com>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: dipankar@in.ibm.com
CC: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm2 [PATCH]
References: <3D8E96AA.C2FA7D8@digeo.com> <20020923151559.B29900@in.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 23 Sep 2002 16:28:41.0548 (UTC) FILETIME=[474220C0:01C2631E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dipankar Sarma wrote:
> 
> ...
> -#ifdef CONFIG_PREEMPTION
> +#ifdef CONFIG_PREEMPT
>  #define rcu_read_lock()                preempt_disable()
>  #define rcu_read_unlock()      preempt_enable()
>  #else

Thanks.  I just replaced

#ifdef CONFIG_PREEMPTION
#define rcu_read_lock()        preempt_disable()
#define rcu_read_unlock()      preempt_enable()
#else
#define rcu_read_lock()        do {} while(0)
#define rcu_read_unlock()      do {} while(0)
#endif

with

#define rcu_read_lock()        preempt_disable()
#define rcu_read_unlock()      preempt_enable()

because preempt_disable() is a no-op on CONFIG_PREEMPT=n anyway.
