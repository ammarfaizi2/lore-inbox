Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271707AbTHMJAw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Aug 2003 05:00:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271712AbTHMJAw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Aug 2003 05:00:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:25018 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S271707AbTHMJAv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Aug 2003 05:00:51 -0400
Date: Wed, 13 Aug 2003 02:01:17 -0700
From: Andrew Morton <akpm@osdl.org>
To: Roland McGrath <roland@redhat.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] read_trylock for i386
Message-Id: <20030813020117.0acc5383.akpm@osdl.org>
In-Reply-To: <200308130614.h7D6EHv07972@magilla.sf.frob.com>
References: <200308130614.h7D6EHv07972@magilla.sf.frob.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roland McGrath <roland@redhat.com> wrote:
>
>  The following header patches add the read_trylock macro, implementing it
>  fully for i386 and leaving other architectures with an always-fail fallback.

Looks reasonable, and we do need read_trylock() for symmetry at least.  And
I did need it for the CONFIG_PREEMT low-latency read_lock() implementation.

Please note that the lockmeter patch in -mm kernels has implementations of
_raw_read_trylock() for sparc64, alpha and ia64.  ppc64 already implements
it.

So it would be better if someone could sweep all those together, implement
the necessary stubs for uniprocessor builds on all architectures and
apologetically break the build on the remaining SMP architectures.

That would appear to be mips, parisc, s390, sparc and x86_64.

