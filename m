Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261163AbTEKSzg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 14:55:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261166AbTEKSzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 14:55:36 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:29775 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP id S261163AbTEKSzf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 14:55:35 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: CaT <cat@zip.com.au>, Andi Kleen <ak@muc.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Use correct x86 reboot vector
References: <20030510025634.GA31713@averell>
	<20030510033504.GA1789@zip.com.au>
	<1052578182.16166.6.camel@dhcp22.swansea.linux.org.uk>
	<m1bry9746i.fsf@frodo.biederman.org>
	<1052673863.29921.17.camel@dhcp22.swansea.linux.org.uk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 11 May 2003 13:04:59 -0600
In-Reply-To: <1052673863.29921.17.camel@dhcp22.swansea.linux.org.uk>
Message-ID: <m11xz5719g.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> On Sul, 2003-05-11 at 19:01, Eric W. Biederman wrote:
> > > At least some SMP boxes freak if you do a poweroff request on CPU != 0
> > 
> > As per the MP spec.  The system should reboot on the bootstrap cpu.
> > smp_processor_id() == 0 on x86.  apicid??
> 
> APM now makes its calls on CPU#0 which was the trigger for these
> problems

I have a couple of issues with the current state of affairs.
1) We should always do this to be safe.
2) Reboot has this issue as well.
3) The way APM does it overrides the kernel command line option,
   and apm_power_off forces the cpu twice.
4) We have this implemented in 3 different ways in 3 different places.
5) machine_reboot needs this to do this in interrupt context for
   Sys-req-B and certain cases of panic and that is not currently handled.

On a related note do you know why machine_halt and machine_power_off return?
After shutting everything down that seems very much like the wrong thing
to do.

Eric
