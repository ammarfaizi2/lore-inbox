Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314584AbSEHQbb>; Wed, 8 May 2002 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314620AbSEHQba>; Wed, 8 May 2002 12:31:30 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:55290 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP
	id <S314584AbSEHQba>; Wed, 8 May 2002 12:31:30 -0400
Subject: Re: O(1) scheduler gives big boost to tbench 192
From: Robert Love <rml@tech9.net>
To: Jussi Laako <jussi.laako@kolumbus.fi>
Cc: Mike Kravetz <kravetz@us.ibm.com>, mingo@elte.hu,
        linux-kernel@vger.kernel.org
In-Reply-To: <3CD94582.DE18AB99@kolumbus.fi>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-4) 
Date: 08 May 2002 09:31:39 -0700
Message-Id: <1020875500.2078.117.camel@bigsur>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2002-05-08 at 08:34, Jussi Laako wrote:

> Mike Kravetz wrote:
> > 
> > I'd really like to know if there are any real workloads that
> > benefited from this feature, rather than just some benchmark.
> 
> Maybe this is the reason why O(1) scheduler has big latencies with
> pthread_cond_*() functions which original scheduler doesn't have?
> I think I tracked the problem down to try_to_wake_up(), but I was unable to
> fix it.

Ah this could be the same case.  I just looked into the definition of
the conditional variable pthread stuff and it looks like it _could_ be
implemented using pipes but I do not see why it would per se.  If it
does not use pipes, then this sync issue is not at hand (only the pipe
code passed 1 for the sync flag).

If it does not use pipes, we could have another problem - but I doubt
it.  Maybe the benchmark is just another case where it shows worse
performance due to some attribute of the scheduler or load balancer?

	Robert Love

