Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265432AbSJSA43>; Fri, 18 Oct 2002 20:56:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265434AbSJSA43>; Fri, 18 Oct 2002 20:56:29 -0400
Received: from ns.suse.de ([213.95.15.193]:18195 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S265432AbSJSA42>;
	Fri, 18 Oct 2002 20:56:28 -0400
Date: Sat, 19 Oct 2002 03:02:29 +0200
From: Andi Kleen <ak@suse.de>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
Cc: Andi Kleen <ak@suse.de>, "David S. Miller" <davem@redhat.com>,
       torvalds@transmeta.com, linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: Re: [PATCH] fixes for building kernel using Intel compiler
Message-ID: <20021019030229.A31702@wotan.suse.de>
References: <F2DBA543B89AD51184B600508B68D4000E6ADE6B@fmsmsx103.fm.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <F2DBA543B89AD51184B600508B68D4000E6ADE6B@fmsmsx103.fm.intel.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 18, 2002 at 05:45:08PM -0700, Nakajima, Jun wrote:
> No, it removes most of such cases. It happens only for a general boolean
> controlling expression, and this is the only spot as far as we tested. But

	So it would be optimized away if changed to 

	if ((offsetof(struct task_struct, thread.i387.fxsave) & 15) != 0) {

	?

> our argument is that the checking code is not required because
> thread.i387.fxsave is __attribute__ ((aligned (16))). If __attribute__
> ((aligned (...))) is broken, we should see more problems.

I think it would be better to keep the check, even with attribute aligned. These bugs
are nasty to debug when they happen.

-Andi
