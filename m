Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964921AbVL3XrE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964921AbVL3XrE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Dec 2005 18:47:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964924AbVL3XrE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Dec 2005 18:47:04 -0500
Received: from smtp.osdl.org ([65.172.181.4]:60310 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S964921AbVL3XrB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Dec 2005 18:47:01 -0500
Date: Fri, 30 Dec 2005 15:46:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] protect remove_proc_entry
Message-Id: <20051230154647.5a38227e.akpm@osdl.org>
In-Reply-To: <1135978110.6039.81.camel@localhost.localdomain>
References: <1135973075.6039.63.camel@localhost.localdomain>
	<1135978110.6039.81.camel@localhost.localdomain>
X-Mailer: Sylpheed version 2.1.8 (GTK+ 2.8.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> wrote:
>
> +static DEFINE_SPINLOCK(remove_proc_lock);
>

I'll take a closer look at this next week.

The official way of protecting the contents of a directory from concurrent
lookup or modification is to take its i_sem.  But procfs is totally weird
and that approach may well not be practical here.  We'd certainly prefer
not to rely upon lock_kernel().
