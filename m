Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264832AbTFBSdp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 14:33:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264833AbTFBSdo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 14:33:44 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:9636 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id S264832AbTFBSdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 14:33:44 -0400
Date: Mon, 2 Jun 2003 11:47:05 -0700
Message-Id: <200306021847.h52Il5V06194@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Anton Blanchard <anton@samba.org>
X-Fcc: ~/Mail/linus
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
Subject: Re: FP state in threaded coredumps
In-Reply-To: Anton Blanchard's message of  Tuesday, 3 June 2003 04:30:47 +1000 <20030602183047.GF1169@krispykreme>
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I was adding threaded coredump support to ppc64 and noticed that the
> ELF_CORE_SYNC hook was never called. It looks like we need something
> like this on archs that do lazy FP save/restore to ensure the FP state
> for threads running on other cpus is up to date.

All the threads already synchronize with coredump_wait in __exit_mm.  A
thread reaching that point already has control of the CPU that might be
holding its FPU state.  It seems to me it would be simplest and most
efficient to just do any necessary copy-in there, before
`complete(mm->core_startup_done)'.


Thanks,
Roland
