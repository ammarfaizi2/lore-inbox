Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262410AbVERWVw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262410AbVERWVw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 May 2005 18:21:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262404AbVERWVv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 May 2005 18:21:51 -0400
Received: from fmr17.intel.com ([134.134.136.16]:16308 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262283AbVERWQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 May 2005 18:16:33 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17035.48794.636650.724153@sodium.jf.intel.com>
Date: Wed, 18 May 2005 15:15:54 -0700
To: linux-kernel@vger.kernel.org
Cc: joe.korty@ccur.com, robustmutexes@lists.osdl.org, george@mvista.com
Subject: [RFC] A more general timeout specification
In-Reply-To: <20050518201517.GA16193@tsunami.ccur.com>
References: <20050518201517.GA16193@tsunami.ccur.com>
X-Mailer: VM 7.19 under Emacs 21.3.1
From: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Joe Korty <joe.korty@ccur.com> writes:

> [ for comment only ] The fusyn (robust mutexes) project proposes the
> creation of a more general data structure, 'struct timeout', for the
> specification of timeouts in new services.  In this structure, the
> user specifies:

>     a time, in timespec format.  the clock the time is specified
> against (eg, CLOCK_MONOTONIC).  whether the time is absolute, or
> relative to 'now'.

> That is, all combinations of useful timeout attributes become
> possible.
...

The main reason why we are asking for this is that timeouts in POSIX
calls are always specified in an absolute form. Because most system
calls take it in a relative form, glibc has to call the kernel twice
(one to get the time, one to do the syscall with the computed delta).

By having new syscalls that take advantage of this timeout interface,
we can save this extra kernel call. 

We believe it is generic enough for interfacing with user space
timeouts, although we'd like to hear feedback :)

-- 

Inaky

