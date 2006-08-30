Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750895AbWH3MlK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750895AbWH3MlK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:41:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750897AbWH3MlK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:41:10 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27828 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750894AbWH3MlJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:41:09 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: Andrew Morton <akpm@osdl.org>, video4linux-list@redhat.com,
       kraxel@bytesex.org, Containers@lists.osdl.org,
       linux-kernel@vger.kernel.org,
       Mauro Carvalho Chehab <mchehab@infradead.org>
Subject: Re: [PATCH] kthread: saa7134-tvaudio.c
References: <20060829211555.GB1945@us.ibm.com>
	<20060829143902.a6aa2712.akpm@osdl.org>
	<m1k64rf9om.fsf@ebiederm.dsl.xmission.com>
Date: Wed, 30 Aug 2006 06:39:49 -0600
In-Reply-To: <m1k64rf9om.fsf@ebiederm.dsl.xmission.com> (Eric W. Biederman's
	message of "Tue, 29 Aug 2006 16:39:53 -0600")
Message-ID: <m164gafld6.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Andrew Morton <akpm@osdl.org> writes:
>
>> So in general, yes, the driver should be converted to the kthread API -
>> this is a requirement for virtualisation, but I forget why, and that's the
>> "standard" way of doing it.
>
> With the kthread api new kernel threads are started as children of keventd
> in well defined circumstances.  If you don't do this kernel threads
> can wind up sharing weird parts of a parent process's resources and
> locking resources in the kernel long past the time when they are
> actually used by anything a user space process can kill.
>
> We have actually witnessed this problem with the kernels filesystem mount
> namespace.  Mostly daemonize in the kernel unshares everything that
> could be a problem but the problem is sufficiently subtle it makes
> more sense to the change kernel threads.  So these weird and subtle
> dependencies go away.
>
> So in essence the container work needs the new kthread api for the
> same reasons everyone else does it is just more pronounced in that
> case.

That plus the obvious bit.  For the pid namespace we have to declare
war on people storing a pid_t values.  Either converting them to
struct pid * or removing them entirely.  Doing the kernel_thread to
kthread conversion removes them entirely.

Eric
