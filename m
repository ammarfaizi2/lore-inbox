Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267177AbSLQVpk>; Tue, 17 Dec 2002 16:45:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267178AbSLQVpj>; Tue, 17 Dec 2002 16:45:39 -0500
Received: from to-velocet.redhat.com ([216.138.202.10]:38387 "EHLO
	touchme.toronto.redhat.com") by vger.kernel.org with ESMTP
	id <S267177AbSLQVpi>; Tue, 17 Dec 2002 16:45:38 -0500
Date: Tue, 17 Dec 2002 16:53:37 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "H. Peter Anvin" <hpa@transmeta.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       Dave Jones <davej@codemonkey.org.uk>, Ingo Molnar <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
Subject: Re: Intel P6 vs P7 system call performance
Message-ID: <20021217165337.F10781@redhat.com>
References: <Pine.LNX.4.44.0212162204300.1800-100000@home.transmeta.com> <Pine.LNX.4.50.0212162241150.26163-100000@twinlark.arctic.org> <3DFF76D7.2050403@transmeta.com> <20021217163954.D10781@redhat.com> <3DFF9A23.1090607@transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3DFF9A23.1090607@transmeta.com>; from hpa@transmeta.com on Tue, Dec 17, 2002 at 01:41:55PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 17, 2002 at 01:41:55PM -0800, H. Peter Anvin wrote:
> > No, just take the number of context switches before and after the attempt 
> > to read the time of day.

> How do you do that from userspace, atomically?  A counter in the shared
> page?

Yup.  You need some shared data for the TSC offset such anyways, so 
moving the context switch counter onto such a page won't be much of 
a problem.  Using the %tr trick to get the CPU number would allow for 
some of these data structures to be per-cpu without incurring any LOCK 
overhead, too.

		-ben
-- 
"Do you seek knowledge in time travel?"
