Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261598AbVGPNuV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261598AbVGPNuV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Jul 2005 09:50:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261608AbVGPNuV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Jul 2005 09:50:21 -0400
Received: from cpu2485.adsl.bellglobal.com ([207.236.16.208]:29163 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S261598AbVGPNuT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Jul 2005 09:50:19 -0400
Date: Fri, 15 Jul 2005 10:33:07 +0200
From: Pavel Machek <pavel@ucw.cz>
To: Andy Isaacson <adi@hexapodia.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: resuming swsusp twice
Message-ID: <20050715083307.GA1772@elf.ucw.cz>
References: <20050713185955.GB12668@hexapodia.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713185955.GB12668@hexapodia.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> Yesterday I booted my laptop to 2.6.13-rc2-mm1, suspended to swsusp, and
> then resumed.  It ran fine overnight, including a fair amount of IO
> (running firefox, rsyncing ~/Mail/archive from my mail server, hg pull,
> etc).  This morning I did a swsusp:
> 
> 	echo shutdown > /sys/power/disk
> 	echo disk > /sys/power/state
> 
> and got a panic along the lines of "Unable to find swap space, try
> swapon -a".  Unfortunately I was in a hurry and didn't record the error
> messages.  I powered off, then a few minutes later powered on again.
> 
> At this point, it resumed *to the swsusp state from yesterday*!
> As soon as I realized what had happened, I powered off (not
> shutdown) and rebooted.

Bad, very bad.

> On the next boot it did not find a swsusp signature and booted normally;
> ext3 did a normal recovery and seemed OK, but I was suspicious and did a
> fsck -f, which revealed a lot of damage; most of the damage seemed to be
> in the hg repo which had been pulled from www.kernel.org/hg/.

You should not let ext3 do journal replay. At that point, hopefully
damage will be slightly better. 

> It's extremely unfortunate that there is *any* failure mode in swsusp
> that can result in this behavior.

Well, I've never seen that one before...
								Pavel
-- 
teflon -- maybe it is a trademark, but it should not be.
