Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751485AbWFPQhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751485AbWFPQhY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Jun 2006 12:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751486AbWFPQhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Jun 2006 12:37:24 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35728 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751485AbWFPQhX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Jun 2006 12:37:23 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
To: "Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [Fastboot] [PATCH] kdump: add a missing notifier before crashing
References: <20060615201621.6e67d149.akiyama.nobuyuk@jp.fujitsu.com>
	<m1d5d9pqbr.fsf@ebiederm.dsl.xmission.com>
	<20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
Date: Fri, 16 Jun 2006 10:37:05 -0600
In-Reply-To: <20060616211555.1e5c4af0.akiyama.nobuyuk@jp.fujitsu.com>
	(Nobuyuki Akiyama's message of "Fri, 16 Jun 2006 21:15:55 +0900")
Message-ID: <m1odwtnjke.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Akiyama, Nobuyuki" <akiyama.nobuyuk@jp.fujitsu.com> writes:

>> I am sympathetic but this interface seems to set expectations that
>> we can the impossible, and it still appears unnecessary to me.
>
> As I mentioned many times, this notifier is very effective in the
> clustering system. Actually the Red Hat's kernel has a notifier
> at the same point like this patch.

Ok.  Then maybe someone at redhat can help you convince me.
Why is the appropriate redhat person not sending this patch
upstream?

> I know a real system that failover
> of DB server is immediately done by using this notifier.

Agreed the code can be used.  I'm asking if this makes sense,
and if it is reliable, and if it typically meets the deadline.

> It takes much cost to keep consistency of transaction processing
> on DB system. Therefore, to shorten down time, it is very important
> to immediately know that the system dies. In a mission critical system,
> millisecond order or less is demanded.

I'm not arguing against your requirements.  I'm arguing that I don't
see how this allows you to meet your requirements when you can't
with the current kernel code.

If you are an existing user of a panic notifier I can see how
this removes the need to convert code, because the technique
does not change.  Unfortunately this is the only advantage I see
to this patch.

> The processing of the notifier is to make a SCSI adaptor power off to
> stop writing in the shared disk completely and then notify to standby-node.

The kernel has called panic no new SCSI operations were execute.
I'm not saying don't notify your standby-node

> But as you think, it is sure not to necessarily become this scenario.
> For instance, if the kernel hangs, the failure can be detected only
> by heart-beat. In this case the detection time becomes longer.
>
> Anyway this notifier is very effective and important in the actual world. 
> Another example is as follows:

Please walk me through a real world kernel failure, and show me how
your millisecond requirement is met.

In the example please answer:
- What causes the kernel to call panic?
- From the real failure to the kernel calling panic how long
  does it take?
- What actions does the notifier take to tell the other kernel
  it is dead.
- Why do we think the kernel taking that action will be reliable?
- From the point where we call panic() how long does it take until
  the kdump kernel is active?


> Anyway this notifier is very effective and important in the actual world. 
> Another example is as follows:
> 
> http://lists.osdl.org/pipermail/fastboot/2006-June/003028.html

Hmm.  So if I read this correctly all you need to execute is a single
outb instruction?

This is part one of my biggest confusions what do you need to
do to notify the other node that you have died?

Eric
