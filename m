Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264229AbUEDEQU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264229AbUEDEQU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 00:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUEDEQU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 00:16:20 -0400
Received: from fw.osdl.org ([65.172.181.6]:10922 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264229AbUEDEQF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 00:16:05 -0400
Date: Mon, 3 May 2004 21:15:40 -0700
From: Andrew Morton <akpm@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: mixxel@cs.auc.dk, linux-kernel@vger.kernel.org
Subject: Re: workqueue and pending
Message-Id: <20040503211540.052848a1.akpm@osdl.org>
In-Reply-To: <1083642950.29596.299.camel@gaston>
References: <40962F75.8000200@cs.auc.dk>
	<20040503162719.54fb7020.akpm@osdl.org>
	<1083639081.20092.294.camel@gaston>
	<20040503201616.6f3b8700.akpm@osdl.org>
	<1083642950.29596.299.camel@gaston>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>
> It's probably still good to precise explicitely in the comments
>  that upon return of cancel_delayed_work(), the work queue might
>  still be pending and that a flush and whoever called this may
>  still need a flush_scheduled_work() or flush_workqueue() (provided
>  it's running in a context where that can sleep)

That function was originally written by a comment fetishist.

/*
 * Kill off a pending schedule_delayed_work().  Note that the work callback
 * function may still be running on return from cancel_delayed_work().  Run
 * flush_scheduled_work() to wait on it.
 */
static inline int cancel_delayed_work(struct work_struct *work)
{
	int ret;

	ret = del_timer_sync(&work->timer);
	if (ret)
		clear_bit(0, &work->pending);
	return ret;
}

