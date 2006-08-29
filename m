Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030187AbWH2WlY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030187AbWH2WlY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 18:41:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965154AbWH2WlY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 18:41:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:16558 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965150AbWH2WlX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 18:41:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>
Cc: Sukadev Bhattiprolu <sukadev@us.ibm.com>, video4linux-list@redhat.com,
       Mauro Carvalho Chehab <mchehab@infradead.org>, kraxel@bytesex.org,
       Containers@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
References: <20060829211555.GB1945@us.ibm.com>
	<20060829143902.a6aa2712.akpm@osdl.org>
Date: Tue, 29 Aug 2006 16:39:53 -0600
In-Reply-To: <20060829143902.a6aa2712.akpm@osdl.org> (Andrew Morton's message
	of "Tue, 29 Aug 2006 14:39:02 -0700")
Message-ID: <m1k64rf9om.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> So in general, yes, the driver should be converted to the kthread API -
> this is a requirement for virtualisation, but I forget why, and that's the
> "standard" way of doing it.

With the kthread api new kernel threads are started as children of keventd
in well defined circumstances.  If you don't do this kernel threads
can wind up sharing weird parts of a parent process's resources and
locking resources in the kernel long past the time when they are
actually used by anything a user space process can kill.

We have actually witnessed this problem with the kernels filesystem mount
namespace.  Mostly daemonize in the kernel unshares everything that
could be a problem but the problem is sufficiently subtle it makes
more sense to the change kernel threads.  So these weird and subtle
dependencies go away.

So in essence the container work needs the new kthread api for the
same reasons everyone else does it is just more pronounced in that
case.

Eric
