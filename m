Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbTHYEF1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 00:05:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261465AbTHYEF1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 00:05:27 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:40836 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S261452AbTHYEFU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 00:05:20 -0400
Date: Mon, 25 Aug 2003 05:05:14 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jim Houston <jim.houston@comcast.net>
Cc: linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: [PATCH] Pentium Pro - sysenter - doublefault
Message-ID: <20030825040514.GA20529@mail.jlokier.co.uk>
References: <1061498486.3072.308.camel@new.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1061498486.3072.308.camel@new.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Houston wrote:
> On my cpu model=1 and mask=9, it doesn't clear 86_FEATURE_SEP.
> This results in a double-fault when init starts.  The double-fault
> happens on the sysexit.  The new double-fault handler caught this
> nicely, and I was able to debug this with kgdb.

Does anyone know what the syenter & sysexit instructions do on these
early PPro CPUs?

The Intel documentation is vague, saying only to avoid using them.
I'd like to know what happens if userspace does "sysenter" on one of
these systems.  Does it issue Invalid Opcode, General Protection
fault, or something else?

Jim you can answer this as you have such a Ppro.  Could you please run
this very simple userspace program for me, and report the result?

	int main() { __asm__ ("sysenter"); return 0; }

I expect it to die with SIGILL on Pentium and earlier chips, and
SIGSEGV on "good" PPro and later chips running kernels which don't
enable the sysenter instruction.

But what does it do on your early Intel PPro, the one which is the
subject of this thread?

Thanks,
-- Jamie
