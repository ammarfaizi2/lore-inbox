Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264012AbTDNWTI (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 18:19:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264014AbTDNWTI (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 18:19:08 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:25612
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id S264012AbTDNWTF 
	(for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 18:19:05 -0400
Subject: Re: [RFC] 2.5 TASK_INTERRUPTIBLE preemption race
From: Robert Love <rml@tech9.net>
To: Joe Korty <joe.korty@ccur.com>
Cc: Andrew Morton <akpm@digeo.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030414222750.GA19050@rudolph.ccur.com>
References: <20030414215410.GA18922@rudolph.ccur.com>
	 <1050357642.3664.89.camel@localhost>
	 <20030414222750.GA19050@rudolph.ccur.com>
Content-Type: text/plain
Organization: 
Message-Id: <1050359457.3664.106.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 (1.2.4-2) 
Date: 14 Apr 2003 18:30:57 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2003-04-14 at 18:27, Joe Korty wrote:

> I see.  It is because the 'goto pick_next_task' skips the
> 'deactivate_task' call.  Therefore the previous task remains on the
> run queue in spite of its TASK_UNINTERRUPTIBLE state.  Clever!

Yep :)

We actually did away with it for a bit in mid 2.5... it turned out to
not be worth it.  Its a little odd to use the flag like that, but its
quite simply and the results are good.

Means we can safely schedule anytime, no matter the state.  There are
tons of other places where we would not want to sleep if it were not for
PREEMPT_ACTIVE.

	Robert Love

