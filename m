Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750918AbWEZWBS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750918AbWEZWBS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 18:01:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWEZWBS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 18:01:18 -0400
Received: from e36.co.us.ibm.com ([32.97.110.154]:5287 "EHLO e36.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750914AbWEZWBR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 18:01:17 -0400
Date: Fri, 26 May 2006 17:01:15 -0500
To: Robert Hancock <hancockr@shaw.ca>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PCI reset using x86 or x86-64 BIOS calls?
Message-ID: <20060526220115.GA21605@austin.ibm.com>
References: <6gr2t-1Pp-9@gated-at.bofh.it> <44765F57.90703@shaw.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44765F57.90703@shaw.ca>
User-Agent: Mutt/1.5.9i
From: linas@austin.ibm.com (Linas Vepstas)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 25, 2006 at 07:52:23PM -0600, Robert Hancock wrote:
> Linas Vepstas wrote:
> >I've go a newbie x86 BIOS question:  is there a BIOS function that 
> >can be called to reset a PCI device? (By "reset a device" I mean
> >raise the #RST PCI signal line to electrical high for 1.5 seconds).
> >I know that BIOS does this during a soft reboot, but I was wondering
> >if there's a stand-alone function for doing this while the system is up
> >and running.
> 
> Unlikely - if you mean just resetting one PCI device, it's likely 
> electrically impossible on many, if not most machines as the RST lines 
> will be tied together on all slots.

I was afraid of that.

> In any case, I don't think - or at least would hope - that a PCI device 
> going so far into the weeds that it can't be recovered without a RST 
> would be a rare situation.

Well, this comes up in the case of having kexec take over from a crashed 
kernel; the state of any given PCI card is unclear, and its conceptually
easiest to hit them with a hammer to put them back into a known state.

For hotplug slots, this can be accomplished by toggling power to a slot,
but not all slots out there are hot-pluggable. 

The other situation where this is useful is in recovering from a PCI bus
error (e.g. parity error); but his has additional complications.

I've got someone here  asking about the LSI megaraid controller; 
appearently its under-documented, and it can hang hard on kexec. 
Hitting it with a reset would make life simpler.

--linas

