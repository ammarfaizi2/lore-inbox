Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262927AbUEKRkd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262927AbUEKRkd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 May 2004 13:40:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264772AbUEKRkd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 May 2004 13:40:33 -0400
Received: from x35.xmailserver.org ([69.30.125.51]:17577 "EHLO
	x35.xmailserver.org") by vger.kernel.org with ESMTP id S262927AbUEKRiY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 May 2004 13:38:24 -0400
X-AuthUser: davidel@xmailserver.org
Date: Tue, 11 May 2004 10:38:22 -0700 (PDT)
From: Davide Libenzi <davidel@xmailserver.org>
X-X-Sender: davide@bigblue.dev.mdolabs.com
To: Fabiano Ramos <ramos_fabiano@yahoo.com.br>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [patch] really-ptrace-single-step
In-Reply-To: <1084297014.1729.10.camel@slack.domain.invalid>
Message-ID: <Pine.LNX.4.58.0405111036320.25232@bigblue.dev.mdolabs.com>
References: <Pine.LNX.4.58.0405111007440.25232@bigblue.dev.mdolabs.com>
 <1084297014.1729.10.camel@slack.domain.invalid>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 May 2004, Fabiano Ramos wrote:

> It would not work against 2.6.5, since
> 
> do_syscall_trace()
> 
> makes the check
> 
> if (!test_thread_flag(TIF_SYSCALL_TRACE))
> 		return;
> 
> Simply removing it would do?

No no. You need to OR it with the single-step. Try:

if (!test_thread_flag(TIF_SYSCALL_TRACE) && 
    !test_thread_flag(TIF_SINGLESTEP))
	return;


- Davide

