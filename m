Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267057AbTBDAeQ>; Mon, 3 Feb 2003 19:34:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267059AbTBDAeQ>; Mon, 3 Feb 2003 19:34:16 -0500
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:24849
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S267057AbTBDAeP>; Mon, 3 Feb 2003 19:34:15 -0500
Subject: Re: linux hangs with printk on schedule()
From: Robert Love <rml@tech9.net>
To: Haoqiang Zheng <hzheng@cs.columbia.edu>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <05db01c2cbe5$4b4c34f0$9c2a3b80@zhengthinkpad>
References: <05db01c2cbe5$4b4c34f0$9c2a3b80@zhengthinkpad>
Content-Type: text/plain
Organization: 
Message-Id: <1044319431.783.113.camel@phantasy>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.1 (1.2.1-4) 
Date: 03 Feb 2003 19:43:52 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-02-03 at 19:35, Haoqiang Zheng wrote:

> I found Linux hangs when printk is inserted to the function schedule().
> Sure, it doesn't make much sense to add such a line to schedule(). But Linux
> shouldn't hang anyway, right? It's assumed that printk can be inserted
> safely to anywhere. So, is it a bug of Linux?

Its a known deadlock in 2.4:

	schedule -> printk() -> dmesg output -> klogd wakes up -> repeat

It is not a hard fix and its basically one of a few places where you
cannot call printk(), which is otherwise a very robust funciton.

	Robert Love

