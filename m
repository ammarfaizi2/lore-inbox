Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750762AbWBPBzK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750762AbWBPBzK (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Feb 2006 20:55:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750880AbWBPBzJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Feb 2006 20:55:09 -0500
Received: from ozlabs.org ([203.10.76.45]:21681 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750762AbWBPBzI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Feb 2006 20:55:08 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17395.56186.238204.312647@cargo.ozlabs.ibm.com>
Date: Thu, 16 Feb 2006 12:55:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [PATCH] Provide an interface for getting the current tick
 length
In-Reply-To: <20060215173545.43a7412d.akpm@osdl.org>
References: <17395.53939.795908.336324@cargo.ozlabs.ibm.com>
	<20060215173545.43a7412d.akpm@osdl.org>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton writes:

> >  +	if ((time_adjust_step = time_adjust) != 0 ) {
> 
> <mutters something about coding style>

Seems perfectly plain to me, but if you don't like it I can change it.

> 
> >  +		/*
> >  +		 * Limit the amount of the step to be in the range
> >  +		 * -tickadj .. +tickadj
> >  +		 */
> >  +		time_adjust_step = min(time_adjust_step, (long)tickadj);
> >  +		time_adjust_step = max(time_adjust_step, (long)-tickadj);
> >  +	}
> >  +	delta_nsec = tick_nsec + time_adjust_step * 1000;
> 
> Is that going to overflow if sizeof(long) == 4?

No.  time_adjust_step is in microseconds and is restricted to the
range -tickadj .. tickadj, and tickadj is between 1 and 10 (assuming
HZ >= 50).  tick_nsec is around 1e9 / HZ.  There's no way delta_nsec
could end up less than 0 or larger than around 20 million for any
reasonable HZ value (i.e. >= 50).

Paul.
