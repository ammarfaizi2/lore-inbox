Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314467AbSDRVlH>; Thu, 18 Apr 2002 17:41:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314468AbSDRVlG>; Thu, 18 Apr 2002 17:41:06 -0400
Received: from zero.tech9.net ([209.61.188.187]:13835 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S314467AbSDRVlF>;
	Thu, 18 Apr 2002 17:41:05 -0400
Subject: Re: [PATCH] migration thread fix
From: Robert Love <rml@tech9.net>
To: William Lee Irwin III <wli@holomorphy.com>
Cc: Erich Focht <efocht@ess.nec.de>, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@elte.hu>, torvalds@transmeta.com
In-Reply-To: <20020418212851.GW21206@holomorphy.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 18 Apr 2002 17:41:04 -0400
Message-Id: <1019166066.5395.99.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-04-18 at 17:28, William Lee Irwin III wrote:
> I have a patch to fix #2 as well. Did you see it? Did you try it?

Eric, I am interested in your opinion of wli's patch, too.  I really
liked his approach.

You seem to remove a lot of code since, after starting the first thread,
you rely on set_cpus_allowed and the existing migration_thread to push
the task to the correct place.  I suppose this will work .. but it may
depend implicitly on behavior of the migration_threads and load_balance
(not that the current code doesn't rely on load_balance - it does).

What happens if a migration_thread comes up on a CPU without a migration
thread and then you call set_cpus_allowed?

I am also curious what causes #1 you mention.  Do you see it in the
_normal_ code or just with your patch?  I cannot see what we race
against wrt interrupts ... disabling interrupts, however, would disable
load_balance and that is a potential pitfall with using
migration_threads to migrate migration_threads as noted above.

	Robert Love

