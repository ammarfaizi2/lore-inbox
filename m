Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262593AbVAQSyI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262593AbVAQSyI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 13:54:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVAQSyI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 13:54:08 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:37567 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S262593AbVAQSxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 13:53:55 -0500
Date: Mon, 17 Jan 2005 10:53:19 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       LKML <linux-kernel@vger.kernel.org>, Paul Mackerras <paulus@samba.org>,
       Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH] __get_cpu_var should use __smp_processor_id() not smp_processor_id()
Message-ID: <20050117185319.GA20328@taniwha.stupidest.org>
References: <20050117055044.GA3514@taniwha.stupidest.org> <20050117073809.GA3654@taniwha.stupidest.org> <20050117144016.GC10341@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050117144016.GC10341@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2005 at 03:40:16PM +0100, Ingo Molnar wrote:

> no ... normally you should only use __get_cpu_var() if you know that
> you are in a non-preempt case. It's a __ internal function for a
> reason.  Where did it trigger?

XFS has statistics which are 'per cpu' but doesn't use per_cpu
variables, __get_cpu_var(foo)++ is used (it doesn't have to be preempt
safe since it's just stats and who cares if they are a bit wrong).
