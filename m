Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268270AbUJVWyr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268270AbUJVWyr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 18:54:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268265AbUJVWyS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 18:54:18 -0400
Received: from fw.osdl.org ([65.172.181.6]:32900 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S268283AbUJVWxk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 18:53:40 -0400
Date: Fri, 22 Oct 2004 15:53:38 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] pmac_cpufreq msleep cleanup/fixes
In-Reply-To: <1098484616.6028.80.camel@gaston>
Message-ID: <Pine.LNX.4.58.0410221552320.2101@ppc970.osdl.org>
References: <200410221906.i9MJ63Ai022889@hera.kernel.org> <1098484616.6028.80.camel@gaston>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Sat, 23 Oct 2004, Benjamin Herrenschmidt wrote:
> 
> Please revert that change until we have made absolutely sure that msleep(1)
> on a HZ=1000 machine will actually sleep at least 1ms, this is really not
> clear since it will end up doing schedule_timeout(1) which, afaik, will
> only guarantee to sleep up to the next jiffie, which can be a lot shorter
> than the actual duration of a jiffie.

In that case I'd much prefer to revert the whole previous "cleanup" as 
well, since it obviously isn't really. Having

	msleep(1 + jiffy_to_ms(1));

is just not a cleanup to me.

		Linus
