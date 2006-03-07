Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751446AbWCGUr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbWCGUr6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Mar 2006 15:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751479AbWCGUr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Mar 2006 15:47:58 -0500
Received: from mail.tv-sign.ru ([213.234.233.51]:11705 "EHLO several.ru")
	by vger.kernel.org with ESMTP id S1751446AbWCGUr5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Mar 2006 15:47:57 -0500
Message-ID: <440DF0C2.B23B8837@tv-sign.ru>
Date: Tue, 07 Mar 2006 23:44:50 +0300
From: Oleg Nesterov <oleg@tv-sign.ru>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.2.20 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH 01/23] tref: Implement task references.
References: <m1oe0yhy1w.fsf@ebiederm.dsl.xmission.com>
		<m1k6bmhxze.fsf@ebiederm.dsl.xmission.com>
		<m1mzgidnr0.fsf@ebiederm.dsl.xmission.com>
		<44074479.15D306EB@tv-sign.ru>
		<m14q2gjxqo.fsf@ebiederm.dsl.xmission.com>
		<440CA459.6627024C@tv-sign.ru> <m1wtf76wtr.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Eric W. Biederman" wrote:
> 
> Unless we can implement do_each_task_pid/while_each_task_pid in terms
> of for_each_task_pid.  I am nervous about making the conversion.

Yes, of course. Currently I have:

#define for_each_task_pid(head, who, type, task)                             \
        if ((head = find_pid(who)))                                          \ 
                list_for_each_entry(task, ((head)->tasks + type), pids[type])

// OBSOLETE
#define do_each_task_pid(who, type, task)                               \
        do {                                                            \
                struct pid_head * __pid_head__;                         \
                for_each_task_pid(__pid_head__, who, type, task) {

#define while_each_task_pid(who, type, task)                            \
                }                                                       \
        } while (0)

It's better not to change the users of do_each_task_pid() for some
time at least.

Oleg.
