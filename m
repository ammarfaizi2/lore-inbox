Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266514AbUHXFCq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266514AbUHXFCq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Aug 2004 01:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266527AbUHXFCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Aug 2004 01:02:45 -0400
Received: from mustang.oldcity.dca.net ([216.158.38.3]:54208 "HELO
	mustang.oldcity.dca.net") by vger.kernel.org with SMTP
	id S266514AbUHXFCm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Aug 2004 01:02:42 -0400
Subject: Re: [patch] voluntary-preempt-2.6.8.1-P8
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <412ABC8B.5080608@cybsft.com>
References: <20040816040515.GA13665@elte.hu>
	 <1092654819.5057.18.camel@localhost> <20040816113131.GA30527@elte.hu>
	 <20040816120933.GA4211@elte.hu> <1092716644.876.1.camel@krustophenia.net>
	 <20040817080512.GA1649@elte.hu> <20040819073247.GA1798@elte.hu>
	 <20040820133031.GA13105@elte.hu> <20040820195540.GA31798@elte.hu>
	 <20040821140501.GA4189@elte.hu>  <20040823210151.GA10949@elte.hu>
	 <1093312154.862.17.camel@krustophenia.net>  <412ABC8B.5080608@cybsft.com>
Content-Type: text/plain
Message-Id: <1093323762.817.3.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Tue, 24 Aug 2004 01:02:42 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2004-08-23 at 23:56, K.R. Foley wrote:
> Lee Revell wrote:
> > On Mon, 2004-08-23 at 17:01, Ingo Molnar wrote:
> > 
> > 
> >> - reduce netdev_max_backlog to 8 (Mark H Johnson)
> >>
> > 
> > 
> > On my system this setting has absolutely no effect on the skb related
> > latencies.  I tested setting netdev_max_backlog to every power of two 
> > between 1 and 128, and regardless of this setting, I can produce a
> > 450-600 usec latency with:
> > 
> > ping -s 65507 -f $DEFAULT_GATEWAY
> > 
> > Looks like skb_checksum is the problem.  Here is one of the traces:
> > 
> > http://krustophenia.net/testresults.php?dataset=2.6.8.1-P8#/var/www/2.6.8.1-P8/trace14.txt
> > 
> > Lee
> > 
> > -
> 
> Setting netdev_max_backlog doesn't seem to have any effect for me either.
> 
> I get a similar latency when I try to reproduce your result above, ~612 
> usec. However, my trace is very different than yours:
> 
> http://www.cybsft.com/testresults/2.6.8.1-P8/latency_trace3.txt
>

I have some that are similar to this.  Looks like many of the
differences are due to different network drivers (e100 vs via-rhine).

> In fact most any network activity, with the POSSIBLE exception of 
> already open connections, seem to be able to trigger higher latencies. 
> As you can see here:
> 
> http://www.cybsft.com/testresults/2.6.8.1-P8/
> 

Looks like except for the one above, all of these involve the
extract_entropy issue.  I am using a hack to disable the random driver
to avoid these latencies.

There are a few other threads going on discussing a real solution to the
extract_entropy issue.  However, none of the solutions that has been
posted yet fix the problem.

Lee


