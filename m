Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265479AbSJSCLV>; Fri, 18 Oct 2002 22:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265480AbSJSCLV>; Fri, 18 Oct 2002 22:11:21 -0400
Received: from fmr01.intel.com ([192.55.52.18]:43472 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S265479AbSJSCLT>;
	Fri, 18 Oct 2002 22:11:19 -0400
Message-ID: <F2DBA543B89AD51184B600508B68D4000E6ADE72@fmsmsx103.fm.intel.com>
From: "Nakajima, Jun" <jun.nakajima@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Saxena, Sunil" <sunil.saxena@intel.com>
Subject: RE: [PATCH] fixes for building kernel using Intel compiler
Date: Fri, 18 Oct 2002 19:17:19 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, Andi.

No, because of (size_t) (it's typedef) from offsetof() and &.  But
	if ( (int) offsetof(struct task_struct, thread.i387.fxsave) % 16) {
would be optiminzed away. So I'll change the patch like that. 

Thanks,
Jun
-----Original Message-----
From: Andi Kleen [mailto:ak@suse.de]
Sent: Friday, October 18, 2002 6:02 PM
To: Nakajima, Jun
Cc: Andi Kleen; David S. Miller; torvalds@transmeta.com;
linux-kernel@vger.kernel.org; Mallick, Asit K; Saxena, Sunil
Subject: Re: [PATCH] fixes for building kernel using Intel compiler


On Fri, Oct 18, 2002 at 05:45:08PM -0700, Nakajima, Jun wrote:
> No, it removes most of such cases. It happens only for a general boolean
> controlling expression, and this is the only spot as far as we tested. But

	So it would be optimized away if changed to 

	if ((offsetof(struct task_struct, thread.i387.fxsave) & 15) != 0) {

	?

> our argument is that the checking code is not required because
> thread.i387.fxsave is __attribute__ ((aligned (16))). If __attribute__
> ((aligned (...))) is broken, we should see more problems.

I think it would be better to keep the check, even with attribute aligned.
These bugs
are nasty to debug when they happen.

-Andi
