Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964832AbWJCXf2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964832AbWJCXf2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Oct 2006 19:35:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964848AbWJCXf2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Oct 2006 19:35:28 -0400
Received: from nf-out-0910.google.com ([64.233.182.184]:31082 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S964832AbWJCXf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Oct 2006 19:35:27 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=pnPpt8dnu+b0DKHFG+LoiG+bTqoQYEW9s4m6VS7XT+B51gw9q+iObg1SdXa/3ixsK9zEt4pWaZaZX9Rpqov0mHLJtJi7ogMNWzt6Njmz1kotvNZCvjDkwoXtYuS/ad+PX9vJV6ZowTZq4rlz6FwCIMwGxdqltxoetpqQ+9I38Ag=
Message-ID: <a762e240610031635v73fdf36fk80005c4967b38410@mail.gmail.com>
Date: Tue, 3 Oct 2006 16:35:25 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Manish Neema" <Manish.Neema@synopsys.com>
Subject: Re: System hang problem.
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5A0@US01WEMBX1.internal.synopsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <C9A861D62D068643A0F4A7B1BCB38E2C0327B5A0@US01WEMBX1.internal.synopsys.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/06, Manash Neema <Manish.Neema@synopsys.com> wrote:
> Sorry, I've lost my patience with RedHat so posting here....
>
> We see this problem frequently on RHEL3.0 U5 and U7. System would
> completely hang upon memory shortage. The only option left is
> power-cycle (or 'sysrq + b'). System hang occurs with any of the below 3
> overcommit settings:

In general RHEL3 isn't to good at returning from "memory shortage"
once the oom comes out I would consider the system trashed. You need
to manage it better so you don't overcommit the system resouces.

>    - default (heuristic) overcommit (overcommit_memory=0)
>    - no overcommit handling by kernel (overcommit_memory=1)
>    - restrictive overcommit with ratio=100% (overcommit_memory=2;
> overcommit_ratio=100)
>
> RHEL3.0 U3 would generate an OOM kill "each and every time" it sensed
> system hang but due to other bugs, we had to move away from it. RedHat
> calls the timely (at least for us) invocation of OOM in U3 a buggy
> implementation and the delayed OOM kill in U5 and U7 the right
> implementation (which we rarely get to see resulting in at least 5
> systems hanging daily!)

If you are using too much memory you are using too much memory.  RHEL3
may not be recovering well (by your standards) from this. (perhaps not
any kernel for that matter)

> Changing overcommit to 2 (and ratio to any where from 1 to 99) would
> result in certain OS processes (automount daemon for e.g.) getting
> killed when all the allowed memory is committed. What is the point in
> reserving some memory if a random root process would get killed leaving
> the system in a totally unknown state?

Choosing who to kill is a hard decision.  Stay away from the kernel
oom killer is is a wiley beast.

> Any suggestions on how we can prevent system-hang + not have automount
> (and any other root process) die?

There are a whole bunch of /proc knobs (more than just the overcommit)
in RHEL3 that you may dive into.  You would need to get your RHEL
support to help you out with that.  It is really hard to say what the
deal is but if you application is using too much memory oom is
inevitable.

  As far as having an oom killer that meets you standards... You have
to talk to Redhat about that.

  At a high level I would say add more memory (or reduce the amount
used my the applications) to the box if you can't find the right /proc
bit to work.  Sounds like something has to give.

good luck,
  Keith
