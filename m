Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261662AbTI3TIM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 15:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261665AbTI3TIM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 15:08:12 -0400
Received: from ns.suse.de ([195.135.220.2]:51603 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261662AbTI3TIE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 15:08:04 -0400
To: Dave Jones <davej@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Mutilated form of Andi Kleen's AMD prefetch errata patch
References: <20030930073814.GA26649@mail.jlokier.co.uk.suse.lists.linux.kernel>
	<20030930132211.GA23333@redhat.com.suse.lists.linux.kernel>
	<20030930133936.GA28876@mail.shareable.org.suse.lists.linux.kernel>
	<20030930135324.GC5507@redhat.com.suse.lists.linux.kernel>
	<20030930144526.GC28876@mail.shareable.org.suse.lists.linux.kernel>
	<20030930150825.GD5507@redhat.com.suse.lists.linux.kernel>
	<20030930165450.GF28876@mail.shareable.org.suse.lists.linux.kernel>
	<20030930172618.GE5507@redhat.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 Sep 2003 21:08:01 +0200
In-Reply-To: <20030930172618.GE5507@redhat.com.suse.lists.linux.kernel>
Message-ID: <p73pthiyu0e.fsf@oldwotan.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones <davej@redhat.com> writes:
> 
>  > Anyway, it should complain about lack of cmov not crash :)
> 
> not easy, given we execute cmov instructions before we even hit
> a printk. Such a test & output needs to be done in assembly in early
> startup.

I implemented it for long mode on x86-64.

It has to be done before the vesafb is initialized too, otherwise
you cannot see the error message.

You could copy the code from arch/x86_64/boot/setup.S 
(starting with /* check for long mode. */) and change it to
check for the CPUID bits you want. x86-64 checks a basic collection
that has been determined to be the base set of x86-64 supporting CPUs.
But it could be less or more.

-Andi
