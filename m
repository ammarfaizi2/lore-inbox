Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289346AbSAJFs6>; Thu, 10 Jan 2002 00:48:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289347AbSAJFss>; Thu, 10 Jan 2002 00:48:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:33803 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S289346AbSAJFsm>;
	Thu, 10 Jan 2002 00:48:42 -0500
Subject: Re: lock order in O(1) scheduler
From: Robert Love <rml@tech9.net>
To: kevin@koconnor.net
Cc: mingo@elte.hu, linux-kernel@vger.kernel.org
In-Reply-To: <20020110001002.A13456@arizona.localdomain>
In-Reply-To: <20020110001002.A13456@arizona.localdomain>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 10 Jan 2002 00:51:03 -0500
Message-Id: <1010641864.3225.298.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-01-10 at 00:10, kevin@koconnor.net wrote:

> I was unable to figure out what the logic of the '(smp_processor_id() <
> p->cpu)' test is..  (Why should the CPU number of the process being awoken
> matter?)  My best guess is that this is to enforce a locking invariant -
> but if so, isn't this test backwards?  If p->cpu > current->cpu then
> p->cpu's runqueue is locked first followed by this_rq - locking greatest to
> least, where the rest of the code does least to greatest..

OK, I replied I was unsure of the validity, but looking this over, I now
suspect it is wrong.

The test should be (smp_processor_id() > p->cpu).  Thus it would be safe
to lock this_rq since it is of a lower cpu id than p's rq.

	Robert Love

