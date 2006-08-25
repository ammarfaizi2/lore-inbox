Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422792AbWHYAvR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422792AbWHYAvR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 20:51:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422793AbWHYAvR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 20:51:17 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:1471 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1422792AbWHYAvQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 20:51:16 -0400
Subject: Re: [PATCH] Make spinlock/rwlock annotations more accurate by
	using parameters, not types
From: Josh Triplett <josht@us.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060822205359.5a06dcde.akpm@osdl.org>
References: <1156294298.4510.5.camel@josh-work.beaverton.ibm.com>
	 <20060822205359.5a06dcde.akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 24 Aug 2006 17:51:19 -0700
Message-Id: <1156467079.3418.61.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-08-22 at 20:53 -0700, Andrew Morton wrote:
> On Tue, 22 Aug 2006 17:51:38 -0700
> Josh Triplett <josht@us.ibm.com> wrote:
> 
> > The lock annotations used on spinlocks and rwlocks currently use
> > __{acquires,releases}(spinlock_t) and __{acquires,releases}(rwlock_t),
> > respectively.  This loses the information of which lock actually got acquired
> > or released, and assumes a different type for the parameter of __acquires and
> > __releases than the rest of the kernel.  While the current implementations of
> > __acquires and __releases throw away their argument, this will not always
> > remain the case.
> 
> It won't?  Why, what will happen?

See http://marc.theaimsgroup.com/?l=linux-sparse&m=115644727723278&w=2
(Message-ID: 1156447273.3418.34.camel@josh-work.beaverton.ibm.com); with
that patch, sparse can track a context expression per context.  I plan
to make sparse use that context expression to track contexts
independently to improve the correctness and usefulness of context
warnings.  The Linux patch "Pass sparse the lock expression given to
lock annotations" that I just sent (Message-ID:
1156466936.3418.58.camel@josh-work.beaverton.ibm.com) changes
__acquires, __releases, __acquire, and __release to stop ignoring the
lock expression, and pass it to sparse.

- Josh Triplett


