Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265794AbUBCEiM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Feb 2004 23:38:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265811AbUBCEiM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Feb 2004 23:38:12 -0500
Received: from cpe-24-221-190-179.ca.sprintbbd.net ([24.221.190.179]:54657
	"EHLO myware.akkadia.org") by vger.kernel.org with ESMTP
	id S265794AbUBCEiJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Feb 2004 23:38:09 -0500
Message-ID: <401F25A8.8030800@redhat.com>
Date: Mon, 02 Feb 2004 20:38:00 -0800
From: Ulrich Drepper <drepper@redhat.com>
Organization: Red Hat, Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7a) Gecko/20040118
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: [RFC][PATCH] linux-2.6.2-rc2_vsyscall-gtod_B1.patch
References: <1075344395.1592.87.camel@cog.beaverton.ibm.com> <401894DA.7000609@redhat.com> <20040129132623.GB13225@mail.shareable.org> <40194B6D.6060906@redhat.com> <20040129191500.GA1027@mail.shareable.org> <4019A5D2.7040307@redhat.com> <20040130041708.GA2816@mail.shareable.org> <4019E713.1010107@redhat.com> <20040130092939.GB3841@elte.hu>
In-Reply-To: <20040130092939.GB3841@elte.hu>
X-Enigmail-Version: 0.83.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:

> but i'm a bit worried about the apparent fact that adding 200 more
> symbols (and making the vDSO a real DSO in essence) to abstract the
> kernel syscalls is apparently unacceptable performance-wise. If this is
> true then the whole dynamic linking architecture is much slower than it
> should be, isnt it?

If the syscall entry code in the vdso takes care of the multiplexing we
do not have to add any symbols to the vdso's symbol table.  There are no
additional costs associated with adding more optimized syscalls other
than the multiplexer and that cost would be constant if a jump table is
used.

For now, the simple single cmpl is sufficient.

-- 
➧ Ulrich Drepper ➧ Red Hat, Inc. ➧ 444 Castro St ➧ Mountain View, CA ❖
