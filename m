Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263858AbTJ1FLm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Oct 2003 00:11:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263861AbTJ1FLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Oct 2003 00:11:42 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:46430 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263858AbTJ1FLk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Oct 2003 00:11:40 -0500
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: fastboot@lists.osdl.org, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [Fastboot] [announce] kexec for 2.6.0-test9
References: <20031027140745.1a5ddc3a.rddunlap@osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 27 Oct 2003 22:09:37 -0700
In-Reply-To: <20031027140745.1a5ddc3a.rddunlap@osdl.org>
Message-ID: <m1ekwy54oe.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> writes:

> Updated kexec patch for 2.6.0-test9 is now available at:
>   http://developer.osdl.org/rddunlap/kexec/2.6.0-test9/
> 
> Testing, feedback, results, etc. to fastboot@lists.osdl.org, please.

If the testing reveals a general bug LKML is fine.

Randy Looking at the code and what it took to merge with the 4G
patch.  identity_map_pages needs to be removed from the generic path.
There needs to be call into the machine specific code to allocate page
tables or whatever it needs.

That piece of code has caused more problems, and has broken more often
than any of the rest of the generic code.  So it looks to me like it should
not be generic.  In particular the ppc people had trouble with it as well,
as various times it has broken on x86.

One property that should be preserved is that the code should not allocate
any memory in machine_kexec.  It is very hard to cope with memory
failures at that point, and in a lot of ways we have already passed
the point of no return.

I will look at more as I get time, and thanks for keeping a working
version around. 

Eric
