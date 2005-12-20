Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751001AbVLTNUf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751001AbVLTNUf (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 08:20:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751000AbVLTNUf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 08:20:35 -0500
Received: from mx3.mail.elte.hu ([157.181.1.138]:37092 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S1750999AbVLTNUe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 08:20:34 -0500
Date: Tue, 20 Dec 2005 14:19:56 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Singleton <dsingleton@mvista.com>
Cc: dino@in.ibm.com, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
Message-ID: <20051220131956.GA24408@elte.hu>
References: <20051214223912.GA4716@in.ibm.com> <43A1BD61.5070409@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <43A1BD61.5070409@mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.0
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.0 required=5.9 tests=AWL autolearn=no SpamAssassin version=3.0.3
	0.0 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Singleton <dsingleton@mvista.com> wrote:

> Dinakar,
>     after further testing and investigation I believe you original 
> assessment was correct.
> The problem you are seeing is not a library problem.
> The changes to down_futex need to be reverted.  There is a new patch at
> 
> http://source.mvista.com/~dsingleton/patch-2.6.15-rc5-rt2-rf2.
> 
> that reverts the changes to down_futex.

hm, i'm looking at -rf4 - these changes look fishy:

-       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
+       if (current != lock_owner(lock)->task)
+               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);

why is this done?

	Ingo
