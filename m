Return-Path: <linux-kernel-owner+w=401wt.eu-S1030339AbWLTUK0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030339AbWLTUK0 (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 15:10:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030349AbWLTUKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 15:10:25 -0500
Received: from mx1.redhat.com ([66.187.233.31]:38125 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030339AbWLTUKZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 15:10:25 -0500
Message-ID: <458997B5.3040607@redhat.com>
Date: Wed, 20 Dec 2006 15:06:13 -0500
From: =?ISO-8859-1?Q?Kristian_H=F8gsberg?= <krh@redhat.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Stefan Richter <stefanr@s5r6.in-berlin.de>
CC: linux-kernel@vger.kernel.org, linux1394-devel@lists.sourceforge.net
Subject: Re: [PATCH 0/4] New firewire stack - updated patches
References: <20061220005822.GB11746@devserv.devel.redhat.com> <458913AC.7080300@s5r6.in-berlin.de> <45897478.6070308@redhat.com> <45898785.4000209@s5r6.in-berlin.de>
In-Reply-To: <45898785.4000209@s5r6.in-berlin.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stefan Richter wrote:
...
>> And Windows Vista will drop the IP over 1394 functionality,
>> which is another data point about how widely used this standard is.
> 
> If we cared what Windows supports or does not support, we would have gap
> count optimization by now, but no support of IEEE 1394b-2002.

Yeah, my point wasn't that we need to drop it because Windows dropped it, it 
was just a data point backing up the claim that IP 1394 isn't very widely used.

And as for gap count optimization, I just added that to my git repo.  I 
thought about adding it before sending out these patches, but I was running 
late on getting them out -- I ended up spending too much time chasing down a 
stupid spinlock recursion.  It is pretty simple to implement in the new stack, 
since we have all the topology information available.  I did a quick, 
unscientific benchmark (md5summing 10 32M files) and the optimization is 
definitely noticable.  This is  a setup where the box and the disk are both 
connected to a hub so the max hops is 2, so we're using gap count 4:

	real    0m10.021s
	user    0m1.435s
	sys     0m0.356s

compared to no optimization, ie gap count 63:

	real    0m14.537s
	user    0m1.390s
	sys     0m0.402s

Though I see that Mac OS X uses a more conservative setting for a similiar 
topology, so maybe we need to add a bit or "margin" to the numbers from the 
table from 1394.

>> I'm not planning to port the pcilynx driver either.  I think it's a sore
>> point for the old stack as it is - nobody uses it or tests it and it's
>> continously bit-rotting.  So I'd rather not support it.
> 
> Here I agree.
> 
>> However, it can
>> perform as well as an OHCI card for SBP-2.  If you set up a
>> self-modifying DMA program it can read and write system memory without
>> CPU intervention too.
> 
> OK, I didn't know that although I suspected something like this might be
> possible. Of course this remains a potential feature as long as there is
> no manpower to actually implement it. (Nor is there a userbase to speak
> of to appreciate such an effort.)

Exactly.  It's a cool hack (it's mentioned briefly in appendix E.1 of the 
PCILynx functional specification) and it would be fun to make it work, but I 
don't really see a userbase here.  And if somebody has a PCILynx card and want 
to use the new stack, I'll trade them for a OHCI controller :)  I have a much 
more useful way to put PCILynx cards to work using my firewire sniffer 
(http://bitplanet.net/nosy).

cheers,
Kristian

