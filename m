Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274870AbTGaWzI (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 18:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S274885AbTGaWzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 18:55:07 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:39664 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S274870AbTGaWy5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 18:54:57 -0400
Subject: Re: [PATCH] protect migration/%d etc from sched_setaffinity
From: Robert Love <rml@tech9.net>
To: joe.korty@ccur.com
Cc: torvalds@osdl.org, akpm@digeo.com, linux-kernel@vger.kernel.org
In-Reply-To: <20030731224604.GA24887@tsunami.ccur.com>
References: <20030731224604.GA24887@tsunami.ccur.com>
Content-Type: text/plain
Message-Id: <1059692548.931.329.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-5) 
Date: 31 Jul 2003 16:02:29 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-07-31 at 15:46, Joe Korty wrote:

> Lock out users from changing the cpu affinity of those per-cpu system
> daemons which cannot survive such a change, such as migration/%d.
> 
> Passes basic handtest of sched_setaffinity(2) on various locked and
> unlocked processes on a i386, otherwise untested except by eyeball.
> 
> Except for one line in i386, no arch needed any changes to support
> this patch.

I have been wondering what to do about processor affinity and kernel
threads. I just concluded "only root can change it, and we can let root
stab herself if she really wants to."

But if this is really an issue, why not just do:

	ret = -EINVAL;
	if (!p->mm)
		goto out_unlock;

in sys_sched_setaffinity ?

	Robert Love


