Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261307AbSIWTLF>; Mon, 23 Sep 2002 15:11:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261312AbSIWTKN>; Mon, 23 Sep 2002 15:10:13 -0400
Received: from zeus.kernel.org ([204.152.189.113]:27041 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S261307AbSIWSlo>;
	Mon, 23 Sep 2002 14:41:44 -0400
Date: Mon, 23 Sep 2002 23:03:40 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@digeo.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: 2.5.38-mm2 [PATCH]
Message-ID: <20020923230340.A341@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <3D8E96AA.C2FA7D8@digeo.com> <20020923151559.B29900@in.ibm.com> <3D8F4139.6BB60A35@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D8F4139.6BB60A35@digeo.com>; from akpm@digeo.com on Mon, Sep 23, 2002 at 09:28:41AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 23, 2002 at 09:28:41AM -0700, Andrew Morton wrote:
> #ifdef CONFIG_PREEMPTION
> #define rcu_read_lock()        preempt_disable()
> #define rcu_read_unlock()      preempt_enable()
> #else
> #define rcu_read_lock()        do {} while(0)
> #define rcu_read_unlock()      do {} while(0)
> #endif
> 
> with
> 
> #define rcu_read_lock()        preempt_disable()
> #define rcu_read_unlock()      preempt_enable()
> 
> because preempt_disable() is a no-op on CONFIG_PREEMPT=n anyway.

This is fine. The original rcu_ltimer patch needed #ifdef CONFIG_PREEMPT,
so that it could be easily used with 2.4. With preemption in 2.5, 
rcu_read_xxx() can be preempt_xxx().

Thanks
-- 
Dipankar Sarma  <dipankar@in.ibm.com> http://lse.sourceforge.net
Linux Technology Center, IBM Software Lab, Bangalore, India.
