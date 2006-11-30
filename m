Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030827AbWK3RVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030827AbWK3RVJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 12:21:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030835AbWK3RVJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 12:21:09 -0500
Received: from rune.pobox.com ([208.210.124.79]:55221 "EHLO rune.pobox.com")
	by vger.kernel.org with ESMTP id S1030827AbWK3RVI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 12:21:08 -0500
Date: Thu, 30 Nov 2006 11:20:58 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Jens Axboe <jens.axboe@oracle.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, pavel@ucw.cz, bryce@osdl.org,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>
Subject: Re: CPU hotplug broken with 2GB VMSPLIT
Message-ID: <20061130172058.GC22050@localdomain>
References: <20061130090348.GK5400@kernel.dk> <20061130091334.GM5400@kernel.dk> <20061130164347.GB22050@localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061130164347.GB22050@localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Lynch wrote:
> Jens Axboe wrote:
> > On Thu, Nov 30 2006, Jens Axboe wrote:
> > > Hi,
> > > 
> > > Just got a new notebook (Lenovo X60), setup a custom kernel and then I
> > > noticed that suspend to ram doesn't work anymore. The machine suspends
> > > just fine, on resume it brings back the text display but reboots after
> > > it has stalled for a few seconds. On the suggestion of Pavel, I tried
> > > testing CPU hotplug, and indeed he was right: I can offline 1 of the
> > > cores fine, bringing it back online freezes the machine for 3-4 seconds
> > > and then reboots.
> > > 
> > > carl:/sys/devices/system/cpu/cpu1 # echo 0 > online 
> > > carl:/sys/devices/system/cpu/cpu1 # dmesg
> > > Breaking affinity for irq 219
> > > CPU 1 is now offline
> > > SMP alternatives: switching to UP code
> > > carl:/sys/devices/system/cpu/cpu1 # echo 1 > online 
> > > Read from remote host carl: Connection reset by peer
> > > 
> > > Booting with maxcpus=1 and resume works fine. Does this ring a bell with
> > > anyone? With highmem enabled and the standard vmsplit, cpu hotplug works
> > > fine for me.
> > 
> > Some more clues - booting with noreplacement doesn't fix it, so I think
> > the alternatives code is off the hook.
> 
> I don't think this adds any new information, but it has been open
> awhile:
> 
> http://bugme.osdl.org/show_bug.cgi?id=6542
> 
> I was able to narrow it down to the vmsplit setting but I wasn't able
> to debug it further.

Hmm, I'm pretty sure this is the same problem I reported in March,
there might be some more information in that thread:

http://marc.theaimsgroup.com/?t=114039363100002&r=1&w=1

but I didn't realize it was vmsplit-related at that time.

