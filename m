Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268066AbUIJEWy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268066AbUIJEWy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 00:22:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268067AbUIJEWy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 00:22:54 -0400
Received: from viper.oldcity.dca.net ([216.158.38.4]:63880 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S268066AbUIJEWv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 00:22:51 -0400
Subject: Re: Updated rtc-debug patch
From: Lee Revell <rlrevell@joe-job.com>
To: "K.R. Foley" <kr@cybsft.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <4141193B.1070006@cybsft.com>
References: <1094770200.1396.18.camel@krustophenia.net>
	 <4141193B.1070006@cybsft.com>
Content-Type: text/plain
Message-Id: <1094790171.1396.195.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Fri, 10 Sep 2004 00:22:51 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-09-09 at 23:02, K.R. Foley wrote:
> Lee Revell wrote:
> > Andrew, this is an updated version of your rtc-debug patch with some
> > minor changes:
> > 
> 
> Thanks Lee. I was just talking about doing this today because now that 
> the latencies are getting better I wanted to be able to generate some 
> nice graphs to show some interested folks.
> 

I think it is a pretty good sign that we are having to "zoom in" these
tools by 10-1000x to analyze the remaining data.

Here are some of my results so far:

http://krustophenia.net/testresults.php?dataset=2.6.9-rc1-bk12-S0

We are getting pretty close to the point where we can analyze those
graphs and be able to say the spike at X is caused by Y code path.  For
example the spikes above 100 usecs are certainly caused by the
netif_receive_skb path.

It might be useful is for the latency tracer to have a
preempt_min_latency as well as a preempt_max_latency setting.  Then, if
you were to hypothesize that the spike between 55 and 60 usecs is caused
by a certain code path, you could set the window and verify this.

Here's a modified version the hist-to-jpg from Andrew's amlat package. 
It to produce graphs in the same format as the right hand graph from my
testresults.php script (PNG format, data style boxes, and logarithmic
scaling on the Y axis).

http://krustophenia.net/hist-to-jpg.sh.txt

Here's the PHP script:

http://krustophenia.net/testresults.phps

I would like to put together a collection of latency profiling tools for
the 2.6 kernel.  Mostly because I am afraid someone will post a link to
my graphs on slashdot and knock me off the internet for a day.

If you have anything you find useful, send it to me and I will put a
page together.  It would be nice to have some standard tools we can use
to compare systems.

Lee

