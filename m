Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261345AbVBWHVK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261345AbVBWHVK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 02:21:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261355AbVBWHVK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 02:21:10 -0500
Received: from fire.osdl.org ([65.172.181.4]:12007 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261345AbVBWHVG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 02:21:06 -0500
Date: Tue, 22 Feb 2005 23:20:02 -0800
From: Andrew Morton <akpm@osdl.org>
To: Kaigai Kohei <kaigai@ak.jp.nec.com>
Cc: jlan@sgi.com, lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org,
       guillaume.thouvenin@bull.net, tim@physik3.uni-rostock.de,
       erikj@subway.americas.sgi.com, limin@dbear.engr.sgi.com,
       jbarnes@sgi.com
Subject: Re: [Lse-tech] Re: A common layer for Accounting packages
Message-Id: <20050222232002.4d934465.akpm@osdl.org>
In-Reply-To: <421C2B99.2040600@ak.jp.nec.com>
References: <42168D9E.1010900@sgi.com>
	<20050218171610.757ba9c9.akpm@osdl.org>
	<421993A2.4020308@ak.jp.nec.com>
	<421B955A.9060000@sgi.com>
	<421C2B99.2040600@ak.jp.nec.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kaigai Kohei <kaigai@ak.jp.nec.com> wrote:
>
>  The common agreement for the method of dealing with process aggregation
>  has not been constructed yet, I understood. And, we will not able to
>  integrate each process aggregation model because of its diverseness.
> 
>  For example, a process which belong to JOB-A must not belong any other
>  'JOB-X' in CSA-model. But, In ELSA-model, a process in BANK-B can concurrently
>  belong to BANK-B1 which is a child of BANK-B.
> 
>  And, there are other defferences:
>  Whether a process not to belong to any process-aggregation is permitted or not ?
>  Whether a process-aggregation should be inherited to child process or not ?
>  (There is possibility not to be inherited in a rule-based process aggregation like CKRM)
> 
>  Some process-aggregation model have own philosophy and implemantation,
>  so it's hard to integrate. Thus, I think that common 'fork/exec/exit' event handling
>  framework to implement any kinds of process-aggregation.

We really want to avoid doing such stuff in-kernel if at all possible, of
course.

Is it not possible to implement the fork/exec/exit notifications to
userspace so that a daemon can track the process relationships and perform
aggregation based upon individual tasks' accounting?  That's what one of
the accounting systems is proposing doing, I believe.

(In fact, why do we even need the notifications?  /bin/ps can work this
stuff out).

