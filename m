Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030453AbVKCTcc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030453AbVKCTcc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Nov 2005 14:32:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030454AbVKCTcb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Nov 2005 14:32:31 -0500
Received: from e33.co.us.ibm.com ([32.97.110.151]:29837 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S1030453AbVKCTcb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Nov 2005 14:32:31 -0500
Subject: Re: NTP broken with 2.6.14
From: john stultz <johnstul@us.ibm.com>
To: Jean-Christian de Rivaz <jc@eclis.ch>
Cc: linux-kernel@vger.kernel.org, dean@arctic.org
In-Reply-To: <43697550.7030400@eclis.ch>
References: <4369464B.6040707@eclis.ch>
	 <1130973717.27168.504.camel@cog.beaverton.ibm.com>
	 <43694DD1.3020908@eclis.ch>
	 <1130976935.27168.512.camel@cog.beaverton.ibm.com>
	 <43695D94.10901@eclis.ch>
	 <1130980031.27168.527.camel@cog.beaverton.ibm.com>
	 <43697550.7030400@eclis.ch>
Content-Type: text/plain; charset=ISO-8859-1
Date: Thu, 03 Nov 2005 11:32:28 -0800
Message-Id: <1131046348.27168.537.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-11-03 at 03:26 +0100, Jean-Christian de Rivaz wrote:
> john stultz a écrit :
> > Hmm. Ok, so network wise you seem to be communicating with the server
> > without an issue. The other reasons for a reject condition are sync-loop
> > (your NTP server isn't synced to your box I'd assume), or your host is
> > drifting too severely from the NTP server for ntpd to compensate.
> > 
> > Attached is a cruddy python script I wrote that should provide you with
> > your ppm drift from your server.
> > To run:
> > o Disable ntpd
> > o Run "./drift-test.py <server>"
> > o Let it run for 10 minutes to get a decent drift value.

[snip]
> So with 2.6.8 this machine have a working ntpd. Now I stopped ntpd and 
> used your script with the server 10.0.0.1:
> 
> 03 Nov 02:36:32         offset: -6.9e-05        drift: -77.0 ppm
> 03 Nov 02:37:32         offset: -0.005162       drift: -84.7540983607 ppm
> 03 Nov 02:38:32         offset: -0.011573       drift: -95.7107438017 ppm
> 03 Nov 02:39:32         offset: -0.019045       drift: -105.26519337 ppm
> 03 Nov 02:40:32         offset: -0.02732        drift: -113.394190871 ppm
> 03 Nov 02:41:32         offset: -0.036287       drift: -120.581395349 ppm
> 03 Nov 02:42:32         offset: -0.045824       drift: -126.958448753 ppm
> 03 Nov 02:43:32         offset: -0.055755       drift: -132.45368171 ppm
> 03 Nov 02:44:33         offset: -0.065992       drift: -136.929460581 ppm
> 03 Nov 02:45:33         offset: -0.076472       drift: -141.10701107 ppm
> 03 Nov 02:46:33         offset: -0.087156       drift: -144.790697674 ppm

[snip]
> As before, the ntpd is not working properly with the 2.6.14 kernel. Now 
> I stopped ntpd and used your script with the 10.0.0.1 server:
> 
> 03 Nov 02:54:56         offset: -0.008247       drift: -4236.0 ppm
> 03 Nov 02:55:56         offset: -0.828716       drift: -13519.7540984 ppm
> 03 Nov 02:56:57         offset: -1.593172       drift: -13025.9098361 ppm
> 03 Nov 02:57:57         offset: -2.817531       drift: -15458.9010989 ppm
> 03 Nov 02:58:57         offset: -3.442019       drift: -14206.6446281 ppm
> 03 Nov 02:59:57         offset: -4.070492       drift: -13465.1688742 ppm
> 03 Nov 03:00:57         offset: -4.658962       drift: -12858.980663 ppm
> 03 Nov 03:01:57         offset: -5.267374       drift: -12472.4241706 ppm
> 03 Nov 03:02:57         offset: -5.843858       drift: -12115.8651452 ppm
> 03 Nov 03:03:57         offset: -7.052287       drift: -13004.199262 ppm
> 03 Nov 03:04:58         offset: -7.564786       drift: -12538.5986733 ppm
> 
> Interresting! So if I understand correctly the ntpd problem is because 
> the kernel 2.6.14 kernel show a drift about 100 time bigger than with 
> the kernel 2.6.8 on the same hardware. For information the mainboard is 
> the MSI K7N2 (nForce 2). Here is the cpuinfo in case that matter:

Yep. Thats what I was guessing. For some reason time is running too
quickly on your system. Since it is more then +/-500ppm NTP gives up and
won't sync.

Time running too fast can have a number of causes.

Could you open a bugme bug on this and tag me as the owner?
http://bugzilla.kernel.org

Also attach dmesg output and we'll see if that doesn't provide more
clues.

> > Would you mind confirming 2.6.12 does not have the issue on the same
> > hardware?
> 
> The kernel 2.6.12 run on a different hardware and is not configured to 
> work on the hardware that have the problem with 2.6.14, so I can't 
> confime exactly your question yet. If you don't have any better idea, I 
> can try several kernel version to find when the problem start. But I 
> will make that after I sleep because I you look at the time field into 
> the test result this is very late now for me...

When you get a chance starting with a binary search of kernel versions
would help narrow down the issue (start w/ 2.6.8 vanilla to make sure
something in the distro tree isn't avoiding this issue). 

> Thanks for you support, I hope we will quicky find to solution.

I really appreciate your immediate feedback and testing! I'm sure we can
resolve this soon, esp since you do have a working configuration to
compare against.

thanks
-john

