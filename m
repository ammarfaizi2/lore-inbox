Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264641AbUEJLal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264641AbUEJLal (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 May 2004 07:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264639AbUEJLal
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 May 2004 07:30:41 -0400
Received: from fw.osdl.org ([65.172.181.6]:52164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264643AbUEJLag (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 May 2004 07:30:36 -0400
Date: Mon, 10 May 2004 04:30:10 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] WAIT_BIT_QUEUE
Message-Id: <20040510043010.0c9dd1e8.akpm@osdl.org>
In-Reply-To: <409F668A.CEFD60F6@tv-sign.ru>
References: <409F668A.CEFD60F6@tv-sign.ru>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> a better (imho) alternative to filtered wakeups.
>  see http://marc.theaimsgroup.com/?l=linux-kernel&m=108375670411475&w=2
> 
>  process waiting in wait_on_page_bit() will be woken only after
>  the required bit is cleared.
> 
>  so there is no need to recheck the bit in do/while loop, because
>  there is no false wakeups now.

yup.  Please see the new patches in 2.6.6-mm1 - the waiter puts the bit
number into the waitqueue structure and the waker tests it before
delivering the wakeup.

