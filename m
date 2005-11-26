Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932172AbVKZNbe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932172AbVKZNbe (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 26 Nov 2005 08:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932188AbVKZNbe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 26 Nov 2005 08:31:34 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:46491 "EHLO mx2.mail.elte.hu")
	by vger.kernel.org with ESMTP id S932172AbVKZNbe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 26 Nov 2005 08:31:34 -0500
Date: Sat, 26 Nov 2005 14:31:37 +0100
From: Ingo Molnar <mingo@elte.hu>
To: david singleton <dsingleton@mvista.com>
Cc: robustmutexes@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: robust futex heap support patch
Message-ID: <20051126133137.GA9722@elte.hu>
References: <2F3CDB0C-5E50-11DA-8242-000A959BB91E@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2F3CDB0C-5E50-11DA-8242-000A959BB91E@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: -1.5
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.5 required=5.9 tests=ALL_TRUSTED,AWL autolearn=no SpamAssassin version=3.0.3
	-2.8 ALL_TRUSTED            Did not pass through any untrusted hosts
	1.4 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* david singleton <dsingleton@mvista.com> wrote:

> There is a new patch, patch-2.6.14-rt15-rf1, that adds support for 
> robust and priority inheriting pthread_mutexes on the 'heap'.

we need to go a bit slower. For now i had to remove robust-futexes from 
the -rt17 release because they broke normal (non-robust) futex support 
in -rt15. A simple mozilla startup would hang... Please send fixes 
against -rt16 and i'll try to re-add the robust futexes patch later on.  
You can find -rt16 at:

 http://people.redhat.com/mingo/realtime-preempt/older/patch-2.6.14-rt16

> The previous patches only supported either file based pthread_mutexes 
> or mmapped anonymous memory based pthread_mutexes.  This patch allows 
> pthread_mutexes to be 'malloc'ed while using the 
> PTHREAD_MUTEX_ROBUST_NP attribute or PTHREAD_PRIO_INHERIT attribute.
> 
> The patch can be found at:
> 
> http://source.mvista.com/~dsingleton

this patch looks much cleaner than the earlier one, but there's one more 
step to go: now that we've got the futex_head in every vma, why not hang 
all robust futexes to the vma, and thus get rid of ->robust_list and 
->robust_sem from struct address_space?

	Ingo
