Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261259AbVG0Eyo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261259AbVG0Eyo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Jul 2005 00:54:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVG0Eyo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Jul 2005 00:54:44 -0400
Received: from smtp.osdl.org ([65.172.181.4]:40869 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261259AbVG0Eyn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Jul 2005 00:54:43 -0400
Date: Tue, 26 Jul 2005 21:53:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "H. J. Lu" <hjl@lucon.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: define-auxiliary-vector-size-at_vector_size.patch added to -mm
 tree
Message-Id: <20050726215323.0070c867.akpm@osdl.org>
In-Reply-To: <20050727002608.GA7469@lucon.org>
References: <200507262144.j6QLiJVC015284@shell0.pdx.osdl.net>
	<20050727002608.GA7469@lucon.org>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"H. J. Lu" <hjl@lucon.org> wrote:
>
> My patch breaks x86_64 build. This patch will fix x86_64 build. I am
>  also enclosing the updated full patch.

It now breaks ppc64

include/asm/elf.h: In function `dump_task_regs':
include/asm/elf.h:177: error: dereferencing pointer to incomplete type

That's because pt_regs isn't known, because sched.h is including elf.h
before pt_regs gets defined.  This is a pretty fragile area I'm afraid.
