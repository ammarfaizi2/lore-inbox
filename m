Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750707AbVKRN1K@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750707AbVKRN1K (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 08:27:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750717AbVKRN1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 08:27:10 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:32718 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750707AbVKRN1I (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 08:27:08 -0500
Date: Fri, 18 Nov 2005 14:27:15 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Dinakar Guniguntala <dino@in.ibm.com>
Cc: David Singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org
Subject: Re: PI BUG with -rt13
Message-ID: <20051118132715.GA3314@elte.hu>
References: <20051117161817.GA3935@in.ibm.com> <437D0C59.1060607@mvista.com> <20051118092909.GC4858@elte.hu> <20051118132137.GA5639@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051118132137.GA5639@in.ibm.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=disabled SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Dinakar Guniguntala <dino@in.ibm.com> wrote:

> Ingo, Thanks for providing the fix. However I still hit the same bug 
> even with your changes

even with my patch the robust-futex code is still quite broken. E.g. in 
down_futex(), it accesses rt-mutex internals without any locking (!):

        if (rt_mutex_free(lock)) {
                __down_mutex(lock __EIP__);
                rt_mutex_set_owner(lock, owner_task->thread_info);
        }

both rt_mutex_free() and rt_mutex_set_owner() must be called with the 
proper locking. David?

	Ingo
