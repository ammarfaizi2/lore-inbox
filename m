Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292631AbSCGWZa>; Thu, 7 Mar 2002 17:25:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310554AbSCGWZU>; Thu, 7 Mar 2002 17:25:20 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:13756 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292631AbSCGWZD>; Thu, 7 Mar 2002 17:25:03 -0500
Subject: [PATCH] Fix for get_pid hang
From: Paul Larson <plars@austin.ibm.com>
To: Marcelo Tosati <marcelo@conectiva.com.br>,
        lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1015539061.16836.10.camel@plars.austin.ibm.com>
In-Reply-To: <200203072045.PAA08386@egenera.com> 
	<1015539061.16836.10.camel@plars.austin.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 07 Mar 2002 16:23:58 -0600
Message-Id: <1015539839.16835.18.camel@plars.austin.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-03-07 at 16:11, Paul Larson wrote:
> On Thu, 2002-03-07 at 14:45, Patrick O'Rourke wrote:
> > It is possible on large memory systems that the default process limits
> > can exceed PID_MAX.  This will allow a non-root user to consume all pids
> > resulting in the kernel to basically hang in get_pid().
> > 
>   
> > +	/* don't let threads go beyond PID_MAX */
> > +	if (max_threads > PID_MAX) {
> > +		max_threads = PID_MAX;
> > +	}
> > +
> The problem with this approach is that it doesn't take into account
> pgrp, tgids, etc... I submitted the following patch a couple of weeks
> ago that fixes the problem a better way.
> 
> Thanks,
> Paul Larson

Marcelo, any chance of getting this accepted into the next 2.4.19-pre? 
It is obviously a bug that is afecting several others as well.  I think
the LSE team is looking at some performance enhancements to get_pid, but
from what I've seen so far they will be working on top of this bug fix. 
I just verified that the patch still applies cleanly against
2.4.19-pre2.

Thanks,
Paul Larson



