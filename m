Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964807AbVJDPb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964807AbVJDPb5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 11:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964808AbVJDPb5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 11:31:57 -0400
Received: from mx1.suse.de ([195.135.220.2]:61602 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964807AbVJDPb4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 11:31:56 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 1/2] x86_64 nmi_watchdog: Make check_nmi_watchdog static
Date: Tue, 4 Oct 2005 17:32:06 +0200
User-Agent: KMail/1.8.2
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       fastboot@osdl.org
References: <m17jct8ggh.fsf@ebiederm.dsl.xmission.com> <200510041721.09736.ak@suse.de> <m1y859716y.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1y859716y.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510041732.07007.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 October 2005 17:26, Eric W. Biederman wrote:
> Andi Kleen <ak@suse.de> writes:
> > On Tuesday 04 October 2005 17:11, Eric W. Biederman wrote:
> >> By using a late_initcall as i386 does we don't need to call
> >> check_nmi_watchdog manually after SMP startup, and we don't
> >> need different code paths for SMP and non SMP.
> >>
> >> This paves the way for moving apic initialization into init_IRQ,
> >> where it belongs.
> >
> > I don't like it. I want to see a clear message in the log when
> > the NMI watchdog doesn't work and with your patch that comes too late.
>
> Why is it to late?

It's after too much of the boot. e.g. consider analyzing log with a boot hang.
It's important to know if the NMI watchdog runs or not. For that it is
best when the test of it happens as early as possible.

>
> > -Andi (who has rejected similar patches before)
>
> Would it be more appropriate to make this a per cpu check?

That would be fine as long as it's as early as possible.
But I suspect you'll always need special cases for the BP
because it needs the timer running first.

-Andi
