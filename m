Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264582AbUEYLSo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264582AbUEYLSo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 07:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264588AbUEYLSo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 07:18:44 -0400
Received: from ozlabs.org ([203.10.76.45]:58826 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S264582AbUEYLSn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 07:18:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16563.11211.535326.625711@cargo.ozlabs.ibm.com>
Date: Tue, 25 May 2004 21:19:39 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, anton@samba.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IRQ stacks for PPC64
In-Reply-To: <20040525040934.14e20635.akpm@osdl.org>
References: <16563.9827.783950.254480@cargo.ozlabs.ibm.com>
	<20040525040934.14e20635.akpm@osdl.org>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> Your show_stack()-from-irq code will need a bit of work to hop across to
> the next stack.

That's taken care of already; the stack frames are linked together on
ppc64, and show_stack follows those links.  The change to validate_sp
means that we treat stack addresses as valid if they are on the
process stack or on the hardirq or softirq stack for the cpu that the
process is on.

We have in fact been using this patch in some pretty intensive testing
and we have seen stack traces (from other bugs :) that do hop from one
stack to another.  So I am confident that it does work.

Regards,
Paul.
