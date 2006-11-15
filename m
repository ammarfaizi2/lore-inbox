Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966671AbWKOIXA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966671AbWKOIXA (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 03:23:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966681AbWKOIXA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 03:23:00 -0500
Received: from mail.gmx.de ([213.165.64.20]:14061 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S966671AbWKOIW7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 03:22:59 -0500
X-Authenticated: #14349625
Subject: Re: [patch] sched: optimize activate_task for RT task - v2
From: Mike Galbraith <efault@gmx.de>
To: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Cc: nickpiggin@yahoo.com.au, "'Ingo Molnar'" <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <1163574019.6175.30.camel@Homer.simpson.net>
References: <000401c70848$520252e0$d834030a@amr.corp.intel.com>
	 <1163574019.6175.30.camel@Homer.simpson.net>
Content-Type: text/plain
Date: Wed, 15 Nov 2006 09:24:06 +0100
Message-Id: <1163579046.7035.29.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-15 at 08:00 +0100, Mike Galbraith wrote:

> Personally, I think it's best to leave it as it is.  With that change,
> if someone changes policy while the task is waiting to get cpu, it will
> be requeued, and the on-runqueue bonus logic will then end up using
> wildly inaccurate information.

Bah, that's inverted.  interactive_sleep() will never be true after a
rt->non-rt policy change while enqueued with your change, so on-runqueue
bonus will be disabled where it otherwise might have been enabled.  Not
terribly interesting in any case given the likelihood, but still...

	-Mike

