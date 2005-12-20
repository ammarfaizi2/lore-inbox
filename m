Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751090AbVLTPdv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbVLTPdv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:33:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751095AbVLTPdv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:33:51 -0500
Received: from e36.co.us.ibm.com ([32.97.110.154]:25286 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751090AbVLTPdu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:33:50 -0500
Date: Tue, 20 Dec 2005 21:20:04 +0530
From: Dinakar Guniguntala <dino@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: David Singleton <dsingleton@mvista.com>, linux-kernel@vger.kernel.org,
       robustmutexes@lists.osdl.org
Subject: Re: Recursion bug in -rt
Message-ID: <20051220155004.GA3906@in.ibm.com>
Reply-To: dino@in.ibm.com
References: <20051214223912.GA4716@in.ibm.com> <43A1BD61.5070409@mvista.com> <20051220131956.GA24408@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051220131956.GA24408@elte.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 20, 2005 at 02:19:56PM +0100, Ingo Molnar wrote:
> 
> hm, i'm looking at -rf4 - these changes look fishy:
> 
> -       _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> +       if (current != lock_owner(lock)->task)
> +               _raw_spin_lock(&lock_owner(lock)->task->pi_lock);
> 
> why is this done?
>
 
Ingo, this is to prevent a kernel hang due to application error.

Basically when an application does a pthread_mutex_lock twice on a
_nonrecursive_ mutex with robust/PI attributes the whole system hangs.
Ofcourse the application clearly should not be doing anything like
that, but it should not end up hanging the system either

	-Dinakar

