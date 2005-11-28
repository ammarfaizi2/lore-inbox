Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932134AbVK1SaQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932134AbVK1SaQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Nov 2005 13:30:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbVK1SaP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Nov 2005 13:30:15 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:43442 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932134AbVK1SaO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Nov 2005 13:30:14 -0500
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH & RFC] kdump and stack overflows
References: <1133183463.2327.96.camel@localhost.localdomain>
	<m1lkz8gad7.fsf@ebiederm.dsl.xmission.com>
	<1133200815.2425.98.camel@localhost.localdomain>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 28 Nov 2005 11:29:29 -0700
In-Reply-To: <1133200815.2425.98.camel@localhost.localdomain> (Fernando Luis
 Vazquez Cao's message of "Tue, 29 Nov 2005 03:00:14 +0900")
Message-ID: <m1hd9wfwxi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:

> On Mon, 2005-11-28 at 06:39 -0700, Eric W. Biederman wrote: 
>> Fernando Luis Vazquez Cao <fernando@intellilink.co.jp> writes:

> Regarding the stack overflow audit of the nmi path, we have the problem
> that both nmi_enter and nmi_exit in do_nmi (see code below) make heavy
> use of "current" indirectly (specially through the kernel preemption
> code).

Ok.  I wonder if it would be saner to simply replace the nmi trap
handler on the crash dump path?

>> I believe we have a separate interrupt stack that
>> should help but..
> Yes, when using 4K stacks we have a separate interrupt stack that should
> help, but I am afraid that crash dumping is about being paranoid.

Oh I agree.  If we had a private 4K stack for the nmi handler we
would not need to worry about overflow in that case.  (baring
nmi happening during nmis)  Hmm.  Is there anything to keep
us doing something bad in that case?

I guess as long as we don't clear the high bit of port 0x70 we
should be reasonably safe from the nmi firing multiple times.

Eric
