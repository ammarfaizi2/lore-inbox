Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261823AbVEJV6L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVEJV6L (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 May 2005 17:58:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261829AbVEJV6K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 May 2005 17:58:10 -0400
Received: from smtp.lnxw.com ([207.21.185.24]:13061 "EHLO smtp.lnxw.com")
	by vger.kernel.org with ESMTP id S261823AbVEJV6B (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 May 2005 17:58:01 -0400
Date: Tue, 10 May 2005 15:01:24 -0700
To: kus Kusche Klaus <kus@keba.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       Lee Revell <rlrevell@joe-job.com>
Subject: Re: Real-Time Preemption: BUG initializing kgdb
Message-ID: <20050510220124.GA16828@nietzsche.lynx.com>
References: <AAD6DA242BC63C488511C611BD51F367323209@MAILIT.keba.co.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AAD6DA242BC63C488511C611BD51F367323209@MAILIT.keba.co.at>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2005 at 02:34:54PM +0200, kus Kusche Klaus wrote:
> I tried to merge the kgdb and the rt patches (not too difficult, only
> three rejects, and they all look trivial). The resulting kernel
> compiles, boots, and works fine.
...
> Any hints or suggestions?

Revert all spinlock_t types that kgdb uses to raw_spinlock_t to get the
actual spinlock code. A compile trick matches up the right functions
with the struct definition so that changes to the kernel code is minimized.
The spinlock_t defintion in the RT patch is #defined to be a blocking lock
which is not what kgdb wants in order to be happy.

Also, make the interrupt handler setup uses SA_NODELAY or something like
that from my memory. The rest is relatively trivial.

Thanks for making the attempt. Somebody needed to do this a long time
ago. :)

bill

