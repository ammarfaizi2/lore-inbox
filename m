Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266345AbUG0I2d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266345AbUG0I2d (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 04:28:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266352AbUG0I2d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 04:28:33 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:45009 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S266345AbUG0I2c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 04:28:32 -0400
To: Andrew Morton <akpm@osdl.org>
cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] voluntary-preempt-2.6.8-rc2-J3
References: <20040726141143.6d8352b6.akpm@osdl.org>
From: Junio C Hamano <junkio@cox.net>
Date: Tue, 27 Jul 2004 01:28:30 -0700
In-Reply-To: <fa.h4elqom.kjeer4@ifi.uio.no> (Andrew Morton's message of
 "Mon, 26 Jul 2004 21:27:09 GMT")
Message-ID: <7v8yd5c0r5.fsf@assigned-by-dhcp.cox.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "AM" == Andrew Morton <akpm@osdl.org> writes:

AM> +#ifdef CONFIG_SMP
AM> +#define cond_resched_lock(lock, counter, limit)		\
AM> +	do {						\
AM> +		if (++(counter) >= limit) {		\
AM> +			spin_unlock(lock);		\
AM> +			cpu_relax();			\
AM> +			spin_lock(lock);		\
AM> +		}					\
AM> +		(counter) = 0;				\
AM> +	} while (0)
AM> +#else

I am wondering if you meant to reset the counter to zero inside
of the if(){}, probably after reaquiring the lock...

 

