Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265796AbUFSEHM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265796AbUFSEHM (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Jun 2004 00:07:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265808AbUFSEHM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Jun 2004 00:07:12 -0400
Received: from mail002.syd.optusnet.com.au ([211.29.132.32]:60606 "EHLO
	mail002.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S265796AbUFSEHJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Jun 2004 00:07:09 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Grzegorz Kulewski <kangur@polcom.net>
Subject: Re: 2.6.7-ck1
Date: Sat, 19 Jun 2004 14:06:45 +1000
User-Agent: KMail/1.6.1
Cc: Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>
References: <200406162122.51430.kernel@kolivas.org> <1087576093.2057.1.camel@teapot.felipe-alfaro.com> <Pine.LNX.4.58.0406182004370.32121@alpha.polcom.net>
In-Reply-To: <Pine.LNX.4.58.0406182004370.32121@alpha.polcom.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200406191406.45750.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 19 Jun 2004 04:35, Grzegorz Kulewski wrote:
> Hi Con,
>
> I have two problems with 2.6.7-ck1. My distribution is Gentoo Linux
> unstable with all latest updates. Oh, yes, both 2.6.7-ck1 and 2.6.7-rc3
> I tested have vesafb-tng applied from http://dev.gentoo.org/~spock/, but
> it should not cause any problems because it is very non-intrusive patch I
> think. Maybe you should include this in your patchset?
>
> 1. When booting init script freezes after starting input hotplugging (it
> is udev system). The only way to make it run is to press Ctrl-Alt-SysRQ
> and various keys to display kernel state several times. After that system
> starts normally. I do not know if it is only -ck problem because I had
> no time to test 2.6.7 vanilla, but 2.6.7-rc3 worked fine. (Log included.)

Yes I have a sneaking suspicion it's related to the fact kernel threads are 
fixed priority at the moment in staircase (they dont descend priority like 
normal tasks so act like relatively low priority real time tasks). I'm 
addressing that for the next version so hopefully that will fix it.

> 2. In Gentoo we are often using rsync to sync with newest ebuilds database
> (called Portage). Whole portage is something about 300 MB I think. But the
> part to upgrade is only about 1 MB at most. When I try to rsync the only
> process running on my system is kswapd and all my RAM is used (I have 512
> MB of RAM and 768 MB of swap). System uses 90 MB of swap and top shows
> that only 20 MB are cached. This causes rsync server to terminate
> connection because of timeout. There is nothing big running on my box
> besides GNOME and rsync at this time. Here are some /proc files:

Sounds like you need to disable the autoswappiness for this load and set a 
static value. In fact you may find a very high value useful in speeding this 
load up. The older "linear" design for autoswappiness may have been a more 
correct way to tackle it, although desktop users have enjoyed swapping even 
less using the -as patch. To recreate the older design edit mm/vmscan.c and 
comment out line 724 like so:

-			vm_swappiness = vm_swappiness * vm_swappiness / 100;
+			// vm_swappiness = vm_swappiness * vm_swappiness / 100;

Con
