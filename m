Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932289AbVJQMmy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932289AbVJQMmy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 08:42:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932298AbVJQMmy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 08:42:54 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:29654 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S932289AbVJQMmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 08:42:53 -0400
Date: Mon, 17 Oct 2005 18:06:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Jean Delvare <khali@linux-fr.org>, torvalds@osdl.org,
       Serge Belyshev <belyshev@depni.sinp.msu.ru>,
       LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [RCU problem] was VFS: file-max limit 50044 reached
Message-ID: <20051017123655.GD6257@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <Pine.LNX.4.64.0510161912050.23590@g5.osdl.org> <JTFDVq8K.1129537967.5390760.khali@localhost> <20051017084609.GA6257@in.ibm.com> <43536A6C.102@cosmosbay.com> <20051017103244.GB6257@in.ibm.com> <435394A1.7000109@cosmosbay.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <435394A1.7000109@cosmosbay.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 17, 2005 at 02:10:09PM +0200, Eric Dumazet wrote:
> Dipankar Sarma a écrit :
> >On Mon, Oct 17, 2005 at 11:10:04AM +0200, Eric Dumazet wrote:
> >
> >Agreed. It is not designed to work that way, so there must be
> >a bug somewhere and I am trying to track it down. It could very well
> >be that at maxbatch=10 we are just queueing at a rate far too high
> >compared to processing.
> >
> 
> I can freeze my test machine with a program that 'only' use dentries, no 
> files.
> 
> No message, no panic, but machine becomes totally unresponsive after few 
> seconds.
> 
> Just greping for call_rcu in kernel sources gave me another call_rcu() use 
> from syscalls. And yes 2.6.13 has the same problem.

Can you try it with rcupdate.maxbatch set to 10000 in boot
command line ?

FWIW, the open/close test problem goes away if I set maxbatch to
10000. I had introduced this limit some time ago to curtail
the effect long running softirq handlers have on scheduling
latencies, which now conflicts with OOM avoidance requirements.

Thanks
Dipankar
