Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261530AbUCGGvJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 01:51:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261772AbUCGGvJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 01:51:09 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:31395 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S261530AbUCGGvG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 01:51:06 -0500
Subject: Re: 2.4.23aa2 (bugfixes and important VM improvements for the high
	end)
From: Peter Zaitsev <peter@mysql.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrea Arcangeli <andrea@suse.de>, Andrew Morton <akpm@osdl.org>,
       riel@redhat.com, mbligh@aracnet.com, linux-kernel@vger.kernel.org
In-Reply-To: <20040305150225.GA13237@elte.hu>
References: <20040228072926.GR8834@dualathlon.random>
	 <Pine.LNX.4.44.0402280950500.1747-100000@chimarrao.boston.redhat.com>
	 <20040229014357.GW8834@dualathlon.random>
	 <1078370073.3403.759.camel@abyss.local>
	 <20040303193343.52226603.akpm@osdl.org>
	 <1078371876.3403.810.camel@abyss.local> <20040305103308.GA5092@elte.hu>
	 <20040305141504.GY4922@dualathlon.random> <20040305143425.GA11604@elte.hu>
	 <20040305145947.GA4922@dualathlon.random>  <20040305150225.GA13237@elte.hu>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1078642207.2600.848.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 06 Mar 2004 22:50:08 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-03-05 at 07:02, Ingo Molnar wrote:
> * Andrea Arcangeli <andrea@suse.de> wrote:
> 
> > I thought time() wouldn't be called more than 1 per second anyways,
> > why would anyone call time more than 1 per second?
> 
> if mysql in fact calls time() frequently, then it should rather start a
> worker thread that updates a global time variable every second.

Ingo, Andrea,

I would not say MySQL calls time that often, it is normally 2 times per
query (to measure query execution time), might be couple of times more.

Looking at typical profiling results it takes much less than 1% of time,
even for  very simple query loads. 

Rather than changing design how time is computed I think we would better
to go to better accuracy - nowadays 1 second is far too raw.


-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

