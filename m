Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262494AbTD3XL6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Apr 2003 19:11:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262523AbTD3XL6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Apr 2003 19:11:58 -0400
Received: from [12.47.58.20] ([12.47.58.20]:4207 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S262494AbTD3XL4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Apr 2003 19:11:56 -0400
Date: Wed, 30 Apr 2003 16:21:08 -0700
From: Andrew Morton <akpm@digeo.com>
To: Rick Lindsley <ricklind@us.ibm.com>
Cc: solt@dns.toxicfilms.tv, linux-kernel@vger.kernel.org, frankeh@us.ibm.com
Subject: Re: must-fix list for 2.6.0
Message-Id: <20030430162108.09dbd019.akpm@digeo.com>
In-Reply-To: <200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
References: <20030430121105.454daee1.akpm@digeo.com>
	<200304302311.h3UNB2H27134@owlet.beaverton.ibm.com>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Apr 2003 23:24:10.0599 (UTC) FILETIME=[9A98AF70:01C30F6F]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rick Lindsley <ricklind@us.ibm.com> wrote:
>
> 	Why is this bad?
> 	(a) if it does busy looping through sched_yield it will eat cycles which
> 	    might not have happened

Things like OpenOffice _do_ busy loop on sched_yield().  It appears with
that patch, OO will sit there chewing ~1% of CPU.  Not great, but not bad
either..

A few kernels ago, OpenOffice would take sixty seconds to just flop down a
menu if there was a kernel build happening at the same time.  That is just
utterly broken, so if we're going to leave the sched.c code as-is then we
*require* that all applications be updated to not spin on sched_yield.

There's just no question about that.  It may end up not being acceptable.

Has anyone looked at what Andrea did in -aa?  I assume some suitable
compromise was achieved there.


