Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932433AbWFSMvo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932433AbWFSMvo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jun 2006 08:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932434AbWFSMvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jun 2006 08:51:44 -0400
Received: from mail26.syd.optusnet.com.au ([211.29.133.167]:23483 "EHLO
	mail26.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932433AbWFSMvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jun 2006 08:51:43 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jan Engelhardt <jengelh@linux01.gwdg.de>
Subject: Re: 2.6.17-ck1
Date: Mon, 19 Jun 2006 22:51:21 +1000
User-Agent: KMail/1.9.3
Cc: ck list <ck@vds.kolivas.org>, linux list <linux-kernel@vger.kernel.org>
References: <200606181736.38768.kernel@kolivas.org> <200606190111.54914.kernel@kolivas.org> <Pine.LNX.4.61.0606191353210.31576@yvahk01.tjqt.qr>
In-Reply-To: <Pine.LNX.4.61.0606191353210.31576@yvahk01.tjqt.qr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200606192251.22236.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 19 June 2006 21:54, Jan Engelhardt wrote:
> >Were you running them SCHED_IDLEPRIO or in compute mode? They would do
> > that.
>
> I have not changed anything, so I presume SCHED_NORMAL.
> Unless they have been made SCHED_IDLEPRIO/compute by staircase's logic...

No it wouldn't do that. 

I've not seen what you describe happening but definitely the timing of 
parallelising jobs in 'make' completely changes with cpu scheduler changes 
and with I/O scheduler changes. 

However if it's purely unrelated cpu bound tasks running and no disk I/O 
involved then full timeslices run out at ~114ms at 1000HZ (longer at lower 
HZ) so that should be the longest period one task of the same priority could 
possibly run before the others do. That sort of timeslice you would not pick 
up at .1s interval 'top's but I find 'top' can be very deceiving if its 
timing happens to be exactly what the intervals are it can look like only one 
thing is running or one thing is stuck at the same priority and so on. 

With actual numbers from interbench testing of fully cpu bound tasks (under 
what's called benchmarking cpu of Gaming) the average and max scheduling 
delays look of the same magnitude as mainline.

-- 
-ck
