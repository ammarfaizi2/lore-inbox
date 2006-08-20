Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbWHTHwr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbWHTHwr (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Aug 2006 03:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751129AbWHTHwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Aug 2006 03:52:47 -0400
Received: from main.gmane.org ([80.91.229.2]:52889 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751083AbWHTHwq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Aug 2006 03:52:46 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Kari Hurtta <hurtta+gmane@siilo.fmi.fi>
Subject: Re: [PATCH] set*uid() must not fail-and-return on OOM/rlimits
Date: 20 Aug 2006 10:52:34 +0300
Message-ID: <5dwt933ku5.fsf@attruh.keh.iki.fi>
References: <20060820003840.GA17249@openwall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: cs181108174.pp.htv.fi
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Solar Designer <solar@openwall.com> writes in gmane.linux.kernel

> Attached is a trivial patch (extracted from 2.4.33-ow1) that makes
> set*uid() kill the current process rather than proceed with -EAGAIN when
> the kernel is running out of memory.  Apparently, alloc_uid() can't fail
> and return anyway due to properties of the allocator, in which case the
> patch does not change a thing.  But better safe than sorry.
> 
> As you're probably aware, 2.6 kernels are affected to a greater extent,
> where set*uid() may also fail on trying to exceed RLIMIT_NPROC.  That
> needs to be fixed, too.
> 
> Opinions are welcome.

Perhaps stupid suggestion:

Should there be new signal for 'failure to drop privileges' ?
( perhaps SIGPRIV or is this name free )

By default signal terminates process.  

By setting this to SIG_IGN this allows deamons handle situation when 
becoming to user failed and give proper error message.

Still unaware root processes are killed and not causing privilge escalation.

/ Kari Hurtta

