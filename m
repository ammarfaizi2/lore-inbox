Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263713AbUCPJUU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:20:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263714AbUCPJUU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:20:20 -0500
Received: from gate.firmix.at ([80.109.18.208]:3806 "EHLO gate.firmix.at")
	by vger.kernel.org with ESMTP id S263713AbUCPJUB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:20:01 -0500
Subject: Re: finding out the value of HZ from userspace
From: Bernd Petrovitsch <bernd@firmix.at>
To: Peter Williams <peterw@aurema.com>
Cc: Andi Kleen <ak@muc.de>, linux-kernel@vger.kernel.org
In-Reply-To: <40569655.2030802@aurema.com>
References: <1zkOe-Uc-17@gated-at.bofh.it> <1zl7M-1eJ-43@gated-at.bofh.it>
	 <1zn9p-3mW-5@gated-at.bofh.it> <1znj5-3wM-15@gated-at.bofh.it>
	 <1AaWr-655-7@gated-at.bofh.it> <m3fzc9o7bc.fsf@averell.firstfloor.org>
	 <40569655.2030802@aurema.com>
Content-Type: text/plain
Organization: Firmix Software GmbH
Message-Id: <1079428604.32739.26.camel@tara.firmix.at>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 10:16:45 +0100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Die, 2004-03-16 at 06:53, Peter Williams wrote:
> Andi Kleen wrote:
> > Peter Williams <peterw@aurema.com> writes:
[...]
> > Already exists for a long time - AT_CLKTCK. glibc has a nice wrapper
> > for it too (sysconf)
> 
> So it does and POSIX.1 (_SC_CLK_TCK) compliant as well.  Unfortunately, 
> the presence of this functionality makes it VERY difficult to understand 
> why ticks are being converted from HZ==1000 values to HZ=100 values when 
> they are being exported to user space especially as this conversion 
> throws away precision.  Can anyone enlighten me?

1) Because Linux had long time HZ=100 hardcoded (except on Alphas) and
   lots of applications probably use that value today (as HZ in their
   source and not sysconf(...))  - especially since 2.4 (at least most
   of them) has HZ=100 except for 64bit CPUs).
2) There are patches which dynamically change the CPU speed. And it
   probably (IMHO) makes sense to change HZ dynamically too in that
   situations. And a over-time changing HZ value is useless in
   user-space.

	Bernd
-- 
Firmix Software GmbH                   http://www.firmix.at/
mobil: +43 664 4416156                 fax: +43 1 7890849-55
          Embedded Linux Development and Services

