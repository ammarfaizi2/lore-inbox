Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265161AbUITAaU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265161AbUITAaU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Sep 2004 20:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265195AbUITAaU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Sep 2004 20:30:20 -0400
Received: from ip214-49.coastside.net ([207.213.214.33]:25806 "EHLO
	jlundell.local") by vger.kernel.org with ESMTP id S265161AbUITAaM
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Sep 2004 20:30:12 -0400
Mime-Version: 1.0
Message-Id: <p0611043abd73d36c9a7b@[10.2.4.30]>
In-Reply-To: <20040919165000.GI1191@gallifrey>
References: <1095396793.10407.9.camel@sli10-desk.sh.intel.com>
 <20040916221406.1f3764e0.akpm@osdl.org>
 <1095411933.10407.29.camel@sli10-desk.sh.intel.com>
 <20040917161920.16d18333.akpm@osdl.org> <414B7470.4000703@pobox.com>
 <p06110429bd735d9afd46@[10.2.4.30]> <20040919165000.GI1191@gallifrey>
Date: Sun, 19 Sep 2004 17:30:07 -0700
To: "Dr. David Alan Gilbert" <gilbertd@treblig.org>
From: Jonathan Lundell <linux@lundell-bros.com>
Subject: Re: hotplug e1000 failed after 32 times
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 5:50 PM +0100 9/19/04, Dr. David Alan Gilbert wrote:
>* Jonathan Lundell (linux@lundell-bros.com) wrote:
>
>>  Out of curiosity, though, isn't there a residual related problem, in
>>  that a reinserted card gets a new eth# as well? Not insurmountable, I
>>  suppose, but a bitch to automate.
>
>I do wonder why the eth# still gets exported to users - its a royal
>pain when you have multiple cards.  I guess naming by mac address
>isn't ideal either when you want to hot swap one!  Naming by
>pci slot would be kind of nice.

It's a little tricky doing that, since PCI buses get moved around 
dynamically as well. A typical quad Ethernet board (Intel's quad gig, 
for example) has a bridge onboard that creates an internal PCI bus. 
PCI numbers by bus:device:function. It happens that device tends to 
correspond to slot, but that's not at all necessary. And of course we 
can't assume that all systems use PCI buses.

In our systems, where we have lots of ports, we rename our eth's 
along these lines: eth1a, eth1b, eth2a, eth3a, where 1,2,3 are slots 
(we use 0 for motherboard ports) and a,b,c,d are ports on the card.

But doing that requires a per-system-type configuration file that 
describes how to determine which device is in which slot, and that's 
a little tricky because of the way PCI buses get renumbered.

MAC address makes a lousy port name, IMO, since the user typically 
has no way of knowing which port has which address. (And I'm reminded 
of the Solaris convention where by default all ports in the system 
have the same MAC address...).
-- 
/Jonathan Lundell.
