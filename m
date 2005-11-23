Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932103AbVKWQ76@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103AbVKWQ76 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 11:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932104AbVKWQ76
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 11:59:58 -0500
Received: from mailwasher.lanl.gov ([192.65.95.54]:43360 "EHLO
	mailwasher-b.lanl.gov") by vger.kernel.org with ESMTP
	id S932103AbVKWQ7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 11:59:33 -0500
Message-ID: <43849FA5.4020201@lanl.gov>
Date: Wed, 23 Nov 2005 09:58:13 -0700
From: Ronald G Minnich <rminnich@lanl.gov>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: yhlu <yhlu.kernel@gmail.com>, discuss@x86-64.org, linuxbios@openbios.org,
       linux-kernel@vger.kernel.org
Subject: Re: [LinuxBIOS] x86_64: apic id lift patch
References: <86802c440511211349t6a0a9d30i60e15fa23b86c49d@mail.gmail.com> <20051121220605.GD20775@brahms.suse.de>
In-Reply-To: <20051121220605.GD20775@brahms.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-PMX-Version: 4.7.1.128075
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:

> Please note there is a high barrier of entry for any kind of BIOS workarounds -
> in particular for LinuxBIOS i'm not very motivated because you guys can
> just fix the BIOS.

Hi Andi, just wanted to let you know, that I do agree that this is a 
good policy in general. In terms of LinuxBIOS, now that we're starting 
to approach 2M nodes out in the field, fixing it is geting a wee bit 
harder. Again, I'm not disagreeing with the point above, just mentioning 
that "just fix the BIOS" is not as easy as it was when we had all the 
LinuxBIOS nodes in the world -- all 13 of them -- in my lab :-)

This APIC lifting thing has been a real mess, and IIRC what really 
pushed it originally was the island aruma, with its 32 PCI busses. It's 
amazing how PC architectures always seem to involve over-running 
bit-fields -- 4 bits, 6 bits, 8 bits, 10 bits, whatever.

Getting it all to work has involved lots of backtracking, as we found 
that fixing this problem HERE broke that legacy system THERE -- where 
legacy seems to mean "more than 3 weeks old". The mail traffic on the 
linuxbios list on this issue has been interesting, and in some cases, 
more than I can keep up with. Part of the issue is that we all have 
mutually exclusive hardware, and we keep running into hardware 
limitations that don't seem to be known to even the guys who make the 
chips. So we think we have the permanent fix, and somebody pops up to 
report we just broke their mainboard -- and they're the only ones with 
that mainboard, so testing is hard.

At the same time, we seem to be treading in territory where the fuctory 
BIOSes have not yet been. We're in the weird position, at times, of 
finding things out before the proprietary BIOSes get there.

Sometimes the ease of updating the BIOS can cause troubles you don't 
expect. Fuctory BIOSes seem to count on infrequent updates, forked code 
bases, and so on, so that you have to update each mainboard source base 
individually -- they have the disadvantage of a forked code base, but 
the one advantage is that a mod to fix one platform won't ever break 
another.

At some point I had understood that linux was going to be able to 
function without resorting to SRAT tables -- has that changed? Is this 
patch really intrusive enough that it is not acceptable? The issue is 
that we get LinuxBIOS right on a platform, and then some new rev of the 
CPU comes along, and LinuxBIOS gets updated in a way that is not 
obviously going to cause trouble for the older stuff -- but then it 
does, for some other reason. I am hoping this apic lifting will settle 
down in the next while, but it's been hard.

thanks

ron
