Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261336AbVARQQj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261336AbVARQQj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 11:16:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261343AbVARQQj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 11:16:39 -0500
Received: from mail.joq.us ([67.65.12.105]:20893 "EHLO sulphur.joq.us")
	by vger.kernel.org with ESMTP id S261336AbVARQQd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 11:16:33 -0500
To: hihone@bigpond.net.au
Cc: Con Kolivas <kernel@kolivas.org>, linux <linux-kernel@vger.kernel.org>,
       CK Kernel <ck@vds.kolivas.org>, rlrevell@joe-job.com,
       paul@linuxaudiosystems.com
Subject: Re: [ck] [PATCH][RFC] sched: Isochronous class for unprivileged
 soft rt	scheduling
References: <41ED08AB.5060308@kolivas.org> <41ED2F1F.1080905@bigpond.net.au>
From: "Jack O'Quin" <joq@io.com>
Date: Tue, 18 Jan 2005 10:17:50 -0600
In-Reply-To: <41ED2F1F.1080905@bigpond.net.au> (Cal's message of "Wed, 19
 Jan 2005 02:45:35 +1100")
Message-ID: <87d5w2u2xd.fsf@sulphur.joq.us>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Corporate Culture,
 linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Cal <hihone@bigpond.net.au> writes:

> There's a collection of test summaries from jack_test3.2 runs at
> <http://www.graggrag.com/ck-tests/ck-tests-0501182249.txt>
>
> Tests were run with iso_cpu at 70, 90, 99, 100, each test was run
> twice. The discrepancies between consecutive runs (with same
> parameters) is puzzling.  Also recorded were tests with SCHED_FIFO and
> SCHED_RR.

It's probably suffering from some of the same problems of thread
granularity we saw running nice --20.  It looks like you used
schedtool to start jackd.  IIUC, that will cause all jackd processes
to run in the specified scheduling class.  JACK is carefully written
not to do that.  Did you also use schedtool to start all the clients?

I think your puzzling discrepancies are probably due to interference
from non-realtime JACK threads running at elevated priority.

> Before drawing any hardball conclusions, verification of the results
> would be nice. At first glance, it does seem that we still have that
> fateful gap between "harm minimisation" (policy) and "zero tolerance"
> (audio reality requirement).

I still have not found time to run Con's latest version.  I've been
too busy trying to hack JACK into working with nice(-20), which has
turned out to be quite difficult.  The interfaces we need don't work,
and the ones that do are not what we need.  :-(

I believe Con's latest sched patch should work fine with the normal
jack_test3.2 using the -R option of jackd.  That should produce more
consistent results.
-- 
  joq
