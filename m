Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261634AbUKJJtv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261634AbUKJJtv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 Nov 2004 04:49:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261661AbUKJJtu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 Nov 2004 04:49:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:36776 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261634AbUKJJpx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 Nov 2004 04:45:53 -0500
Date: Wed, 10 Nov 2004 01:45:43 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Hood <jdthood@yahoo.co.uk>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] Documentation/preempt-locking.txt clarification
Message-Id: <20041110014543.143b8ff3.akpm@osdl.org>
In-Reply-To: <1100078840.3654.822.camel@thanatos>
References: <1073302283.1903.85.camel@thanatos.hubertnet>
	<1074561880.26456.26.camel@localhost>
	<1100074907.3654.780.camel@thanatos>
	<20041110005742.35828d2b.akpm@osdl.org>
	<1100078840.3654.822.camel@thanatos>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Hood <jdthood@yahoo.co.uk> wrote:
>
> On Wed, 2004-11-10 at 09:57, Andrew Morton wrote:
>  > I guess it's saying ...
> 
>  Thanks for the explanation.  I include a new patch which incorporates
>  your example.  I am in no position to judge the _truth_ of the
>  statements in this document; I am only hoping to _understand_ them.  :)

I think the statement is in fact false.  Ingo, what's your take on this
paragraph, from preempt-locking.txt?


  An additional concern is proper usage of local_irq_disable and
  local_irq_save.  These may be used to protect from preemption, however,
  on exit, if preemption may be enabled, a test to see if preemption is
  required should be done.  If these are called from the spin_lock and
  read/write lock macros, the right thing is done.  They may also be called
  within a spin-lock protected region, however, if they are ever called
  outside of this context, a test for preemption should be made.  Do note
  that calls from interrupt context or bottom half/ tasklets are also
  protected by preemption locks and so may use the versions which do not
  check preemption.
