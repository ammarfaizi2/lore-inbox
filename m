Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964967AbWDGWsw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964967AbWDGWsw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 18:48:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965040AbWDGWsw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 18:48:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:15303 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964967AbWDGWsv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 18:48:51 -0400
Date: Fri, 7 Apr 2006 15:51:13 -0700
From: Andrew Morton <akpm@osdl.org>
To: Oleg Nesterov <oleg@tv-sign.ru>
Cc: ebiederm@xmission.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH rc1-mm] de_thread: fix deadlockable process addition
Message-Id: <20060407155113.37d6a3b3.akpm@osdl.org>
In-Reply-To: <20060407234653.GB11460@oleg>
References: <20060406220403.GA205@oleg>
	<m1acay1fbh.fsf@ebiederm.dsl.xmission.com>
	<20060407234653.GB11460@oleg>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Nesterov <oleg@tv-sign.ru> wrote:
>
> -		if (likely(p->tasks.prev != LIST_POISON2))
> +		if (likely(p->tasks.prev != LIST_POISON2)) {

argh.

c'mon guys, we can't put a dependency on list_head poisoning into generic
code.

We have one in detach_timer() but that's just debugging.
