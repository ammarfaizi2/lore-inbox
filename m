Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264590AbTFYPe7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Jun 2003 11:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264593AbTFYPe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Jun 2003 11:34:59 -0400
Received: from nat9.steeleye.com ([65.114.3.137]:24326 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S264590AbTFYPex (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Jun 2003 11:34:53 -0400
Subject: Re: Large backwards time steps panic 2.5.73
From: James Bottomley <James.Bottomley@steeleye.com>
To: john stultz <johnstul@us.ibm.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
In-Reply-To: <1056485215.1032.197.camel@w-jstultz2.beaverton.ibm.com>
References: <1056472020.2085.81.camel@mulgrave>
	<1056484203.1033.192.camel@w-jstultz2.beaverton.ibm.com>
	<1056485244.1825.173.camel@mulgrave> 
	<1056485215.1032.197.camel@w-jstultz2.beaverton.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-9) 
Date: 25 Jun 2003 10:49:00 -0500
Message-Id: <1056556141.1846.16.camel@mulgrave>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-24 at 15:06, john stultz wrote:
> The only bits the patch should touch are used in adjtimex, and adjtimex
> is very limited on how much it can adjust time. If you're a year off or
> whatever, its more likely ntpdate is calling stime/settimeofday. 
> 
> Could you boot w/o ntp starting up, then manually run  "ntpdate -b
> <server>" to see if that causes it as well? 

I can't seem to reproduce this with any sort of regularity.  The only
data points I have are

- It doesn't occur when the adjtimex reversion is backed out
- It seems to occur shortly after the machine is rebooted with the clock
set to the future.
- it reproduces much more readily if ntpd is running

I've stuck some debugging code in there and find that the ->base for the
timer is NULL and the timer function is igmp_ifc_timer_expire.

I'll continue looking at this.

James



