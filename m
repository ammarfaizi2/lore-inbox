Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261474AbUHRG65@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261474AbUHRG65 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 02:58:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262380AbUHRG65
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 02:58:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:32178 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S261474AbUHRG64 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 02:58:56 -0400
Date: Wed, 18 Aug 2004 09:00:13 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Maurer <Jens.Maurer@gmx.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
Message-ID: <20040818070013.GA11048@elte.hu>
References: <4121A211.8080902@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4121A211.8080902@gmx.net>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Jens Maurer <Jens.Maurer@gmx.net> wrote:

> The attached patch (against kernel 2.6.8.1) enables using SSE
> instructions for copy_page and clear_page.

besides the cache arguments Arjan raised, you are also corrupting SSE
registers big way. You are saving/clearing/restoring the TS but that's
not enough - what if e.g. a pagefault happened while userspace code
executed SSE code? You are corrupting those registers.

check out raid6_before_sse()/raid6_after_sse() how to write proper SSE
code for the kernel.

	Ingo
