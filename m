Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751629AbWBWGzX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629AbWBWGzX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 01:55:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751630AbWBWGzX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 01:55:23 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:47018 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751627AbWBWGzX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 01:55:23 -0500
Date: Wed, 22 Feb 2006 22:54:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, drepper@redhat.com, tglx@linutronix.de,
       arjan@infradead.org, akpm@osdl.org
Subject: Re: [patch 4/6] lightweight robust futexes: compat
Message-Id: <20060222225457.90a35cf8.pj@sgi.com>
In-Reply-To: <20060221084655.GE5506@elte.hu>
References: <20060221084655.GE5506@elte.hu>
Organization: SGI
X-Mailer: Sylpheed version 2.1.7 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I think this broke the 2.6.16-rc4-mm1 CONFIG_FUTEX build for all but
archs:

  powerpc sparc64 x86_64

In the added file kernel/futex_compat.c, routine
compat_sys_get_robust_list() the lines:

+       if (put_user(sizeof(*head), len_ptr))
+               return -EFAULT;
+       return put_user(ptr_to_compat(head), head_ptr);

use a ptr_to_compat() routine that only seems to be defined
for the above arch's.

My ia64 sn2_defconfig build final link is failing:

kernel/built-in.o(.text+0x54782): In function `compat_sys_get_robust_list':
kernel/futex_compat.c:92: undefined reference to `ptr_to_compat'


-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
