Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275099AbTHGCfn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 22:35:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275100AbTHGCfn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 22:35:43 -0400
Received: from c210-49-248-224.thoms1.vic.optusnet.com.au ([210.49.248.224]:39091
	"EHLO mail.kolivas.org") by vger.kernel.org with ESMTP
	id S275099AbTHGCfm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 22:35:42 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Cliff White <cliffw@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Re: 2.6.0-test2-mm3 osdl-aim-7 regression
Date: Thu, 7 Aug 2003 12:40:54 +1000
User-Agent: KMail/1.5.3
Cc: Cliff White <cliffw@osdl.org>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
References: <200308061910.h76JAYw16323@mail.osdl.org>
In-Reply-To: <200308061910.h76JAYw16323@mail.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308071240.54863.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 7 Aug 2003 05:10, Cliff White wrote:
> > Binary searching (insert gratuitous rant about benchmarks that take more
> > than two minutes to complete) reveals that the slowdown is due to
> > sched-2.6.0-test2-mm2-A3.

This is most likely the round robinning of tasks every 25ms. The extra 
overhead of nanosecond timing I doubt could make that size difference (but I 
could be wrong). There is some tweaking of this round robinning in my code 
which may help this, but it won't bring it back up to original performance I 
believe. Two things to try are add my patches up to O12.3int first to see how 
much (if at all!) it helps, and change TIMESLICE_GRANULARITY in sched.c to 
(MAX_TIMESLICE) which basically disables it completely. If there is still  a 
drop in performance with this, the remainder is the extra locking/overhead in 
nanosecond timing.

Con

