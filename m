Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270327AbTG3Kv0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 06:51:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270330AbTG3Kv0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 06:51:26 -0400
Received: from fw.osdl.org ([65.172.181.6]:17337 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S270327AbTG3KvZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 06:51:25 -0400
Date: Wed, 30 Jul 2003 03:51:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: andrea@suse.de, linas@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
Message-Id: <20030730035140.7c834268.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.44.0307301232220.13891-100000@localhost.localdomain>
References: <20030730083726.GE23835@dualathlon.random>
	<Pine.LNX.4.44.0307301232220.13891-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar <mingo@elte.hu> wrote:
>
> But on 2.6 the timer will run precisely on the CPU it was added, so i
>  think the race is not possible.

well there is add_timer_on()...

I still don't see the race in the itimer code actually.  On return
from del_timer_sync() we know that the timer is not pending, even
if it_real_fn() tried to re-add it.

ie: why does the below "crash"?


Andrea Arcangeli <andrea@suse.de> wrote:
>
> 	cpu0			cpu1
>  	------------		--------------------
> 
>  	do_setitimer
>  				it_real_fn
>  	del_timer_sync		add_timer	-> crash


(Does the timer_pending() test in del_timer_sync() needs some
barriers btw?)

