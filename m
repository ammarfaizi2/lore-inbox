Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbUCRVGH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:06:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262951AbUCRVGG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:06:06 -0500
Received: from mx2.elte.hu ([157.181.151.9]:31873 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262962AbUCRVFm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:05:42 -0500
Date: Thu, 18 Mar 2004 22:06:32 +0100
From: Ingo Molnar <mingo@elte.hu>
To: David Lang <david.lang@digitalinsight.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Christoph Hellwig <hch@infradead.org>,
       Ulrich Drepper <drepper@redhat.com>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: sched_setaffinity usability
Message-ID: <20040318210632.GA11529@elte.hu>
References: <40595842.5070708@redhat.com> <20040318112913.GA13981@elte.hu> <20040318120709.A27841@infradead.org> <Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org> <20040318182407.GA1287@elte.hu> <Pine.LNX.4.58.0403181248440.4976@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0403181248440.4976@dlang.diginsite.com>
User-Agent: Mutt/1.4.1i
X-ELTE-SpamVersion: MailScanner 4.26.8-itk2 (ELTE 1.1) SpamAssassin 2.63 ClamAV 0.65
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	autolearn=not spam, BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* David Lang <david.lang@digitalinsight.com> wrote:

> Doesn't /proc/config.gz answer this question?

no. /proc as an interface has the same disadvantages as the /etc
approach.

(there was talk about something like /proc/vdso.so - but in this special
case the kernel is much better at mapping the vdso pages: why spend
three syscalls and a pagefault on something that can be done zero-cost.)

99.9% of userspace code is modularized around the concept of ELF DSOs.
They are well-understood and have a history of providing good control of
backwards and forwards compatibility. They are flexible and they dont
really have any baggage that affects performance. A DSO is the ideal
interface to attach the kernel to glibc. Code and constant data can
reside in this DSO just fine. (even non-constant data can reside in the
DSO.) I'd really not want to reinvent the wheel and put yet another
concept of a dynamic shared object into the kernel (and make that
per-platform too).

	Ingo
