Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265037AbUEVCV2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265037AbUEVCV2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 22:21:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264450AbUEUWjd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 18:39:33 -0400
Received: from fw.osdl.org ([65.172.181.6]:28570 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266084AbUEUWd5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 18:33:57 -0400
Date: Thu, 20 May 2004 23:36:39 -0700
From: Andrew Morton <akpm@osdl.org>
To: Ulrich Drepper <drepper@redhat.com>
Cc: jakub@redhat.com, linux-kernel@vger.kernel.org, mingo@redhat.com
Subject: Re: [PATCH] Add FUTEX_CMP_REQUEUE futex op
Message-Id: <20040520233639.126125ef.akpm@osdl.org>
In-Reply-To: <40AD9C5E.1020603@redhat.com>
References: <20040520093817.GX30909@devserv.devel.redhat.com>
	<20040520155217.7afad53b.akpm@osdl.org>
	<40AD9C5E.1020603@redhat.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ulrich Drepper <drepper@redhat.com> wrote:
>
> Andrew Morton wrote:
> 
> > Is it safe to go adding a new argument to an existing syscall in this manner?
> 
> Yes.  This is a multiplexed syscall and the opcode decides which syscall
> parameter is used.
> 

Of course.

> > It'll work OK on x86 because of the stack layout but is the same true of
> > all other supported architectures?
> 
> We add parameters at the end.  This does not influence how previous
> values are passed.  And especially for syscalls it makes no difference.
> 

what we're effectively doing is:

void foo(int a, int b, int c)
{
}

and from another compilation unit:

	foo(a, b);

and we're expecting the a's and b's to line up across all architectures and
compiler options.  I thought that on some architectures that only works out
if the function has a vararg declaration.

Does it do the right thing on stack-grows-up machines?

If the compiler passes the first few args via registers and the rest on the
stack, are we sure that it won't at some level of complexity decide to pass
_all_ the args on the stack?  It's free to do so, I think.

I have a vague memory of getting bitten by this trick once...
