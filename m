Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbUHRHJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbUHRHJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Aug 2004 03:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263555AbUHRHJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Aug 2004 03:09:57 -0400
Received: from mx1.elte.hu ([157.181.1.137]:42936 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S262730AbUHRHJz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Aug 2004 03:09:55 -0400
Date: Wed, 18 Aug 2004 09:11:12 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Jens Maurer <Jens.Maurer@gmx.net>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] Use x86 SSE instructions for clear_page, copy_page
Message-ID: <20040818071112.GA11543@elte.hu>
References: <4121A211.8080902@gmx.net> <20040818070013.GA11048@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040818070013.GA11048@elte.hu>
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


* Ingo Molnar <mingo@elte.hu> wrote:

> executed SSE code? You are corrupting those registers.

doh - should read before i write. The code is perfectly fine.

Arjan's cache arguments remain. What i'd suggest to test is the precise
speed of compiling the kernel, fully done in ramfs. (if you dont have
enough RAM for this then compile a portion of the kernel.) For the
testing, add a /proc/sys switch to turn the SSE functions on/off
runtime, hence you can eliminate the effects of page placement. If the
compilation timings are stable enough then you can try the runtime
switch to see whether it has any effect. There should be a small but
visible change (in one direction or the other), as compilation brings in
lots of new pages and copies around stuff too.

	Ingo
