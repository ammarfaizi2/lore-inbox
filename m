Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVETS7L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVETS7L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 14:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261547AbVETS7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 14:59:11 -0400
Received: from mail.dvmed.net ([216.237.124.58]:42168 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S261549AbVETS7G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 14:59:06 -0400
Message-ID: <428E3372.403@pobox.com>
Date: Fri, 20 May 2005 14:58:58 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050328 Fedora/1.7.6-1.2.5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Grant Grundler <grundler@parisc-linux.org>, akpm@osdl.org
CC: T-Bone@parisc-linux.org, varenet@parisc-linux.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Netdev <netdev@oss.sgi.com>
Subject: Re: patch tulip-natsemi-dp83840a-phy-fix.patch added to -mm tree
References: <200505101955.j4AJtX9x032464@shell0.pdx.osdl.net> <42881C58.40001@pobox.com> <20050516050843.GA20107@colo.lackof.org> <4288CE51.1050703@pobox.com> <20050516222612.GD9282@colo.lackof.org>
In-Reply-To: <20050516222612.GD9282@colo.lackof.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: 0.0 (/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Grant Grundler wrote:
> After three years of using/maintaining the (trivial) tulip patch
> in parisc-linux tree (and shipped with RH/SuSe ia64 releases),
> I don't recall anyone complaining that udelays in tulip phy reset
> caused them problems. Sorry, I'm unmotivated to revisit this.
> Convince someone else to make tulip to use workqueues and I'll
> resubmit a clean patch on top of that for the phy init sequences.


Long delays are unacceptable in new drivers, and we are working to 
remove them from older drivers.  Lack of complaints is irrelevant -- its 
a design requirement of all drivers.

Ingo and the real-time crowd are fighting against every delay, because 
every delay causes a spin, a blip in latency, an increase in CPU usage, 
and a complete stoppage of ALL work on a uniprocessor machine.

Your patch is not a special case.  We have been communicating this 
message on udelay/mdelay for -years-.  All your patch [as-is] does is 
cause more work for someone else.

This also presents a problem that Andrew points out on occasion:
what happens when a patch is useful, but the patch author isn't (for 
whatever reason) doing the legwork necessary to get it into the mainline 
kernel?  We certainly DON'T want to lose this patch, as the changes are 
useful.

	Jeff


