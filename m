Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263247AbVHFQ7T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263247AbVHFQ7T (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 12:59:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263263AbVHFQ7T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 12:59:19 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:27018 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S263247AbVHFQ7R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 12:59:17 -0400
To: James Bottomley <James.Bottomley@SteelEye.com>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix voyager compile after machine_emergency_restart
 breakage
References: <1123197649.5026.81.camel@mulgrave>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sat, 06 Aug 2005 10:58:47 -0600
In-Reply-To: <1123197649.5026.81.camel@mulgrave> (James Bottomley's message
 of "Thu, 04 Aug 2005 18:20:49 -0500")
Message-ID: <m1y87fxarc.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley <James.Bottomley@SteelEye.com> writes:

> [PATCH] i386: Implement machine_emergency_reboot
>
> introduced this new function into arch/i386/reboot.c.  However,
> subarchitectures are entitled to implement their own copies of reboot.c
> from which this new function is now missing.
>
> It looks like visws will also need a similar fixup

Yes, except it looks like it can benefit from a real
machine_emergency_restart, if the smp_send_stop in
there is the one I am familiar with.

My apologies I am always finding the subarchitecture support
on x86 non-intuitive.  When you are looking at the primary
code path there is nothing to indicate that there is
a secondary code path out in the machine specific files.
Most other architectures have a machine vector so
you can compile for multiple subarchitectures simultaneously
and then switch between them, at run time.  With an optimization
that if you only compile for one subarchitecture the indirect
function call overhead disappears. 

Anyway I will see about generating the trivial patch later today.

Eric
