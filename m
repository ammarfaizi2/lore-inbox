Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135695AbRDXQLE>; Tue, 24 Apr 2001 12:11:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135697AbRDXQKz>; Tue, 24 Apr 2001 12:10:55 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:31249 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S135695AbRDXQKo>; Tue, 24 Apr 2001 12:10:44 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: BUG: Global FPU corruption in 2.2
Date: 24 Apr 2001 09:10:07 -0700
Organization: A poorly-installed InterNetNews site
Message-ID: <9c48gv$fbk$1@penguin.transmeta.com>
In-Reply-To: <cpx7l0g3mfk.fsf@goat.cs.wisc.edu> <20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20010423161148.6465.qmail@theseus.mathematik.uni-ulm.de>,
Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de> wrote:
>
>1.) If I'm not mistaken switch_to changes current->flags without
>atomic operations and without any locks and sys_ptrace changes
>child->flags only protected by the big kernel lock.

ptrace only operates on processes that are stopped. So there are no
locking issues - we've synchronized on a much higher level than a
spinlock or semaphore.

That said, it does look like 2.2.x has a real bug, and maybe the ptrace
task stopping sycnhronization is broken..

		Linus
