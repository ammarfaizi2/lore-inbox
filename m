Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423089AbWAMXDQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423089AbWAMXDQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 18:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423090AbWAMXDP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 18:03:15 -0500
Received: from relay01.pair.com ([209.68.5.15]:37638 "HELO relay01.pair.com")
	by vger.kernel.org with SMTP id S1423089AbWAMXDO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 18:03:14 -0500
X-pair-Authenticated: 67.163.102.102
From: Chase Venters <chase.venters@clientec.com>
Organization: Clientec, Inc.
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
       Jiri Benc <jbenc@suse.cz>, Stefan Rompf <stefan@loplof.de>,
       Mike Kershaw <dragorn@kismetwireless.net>,
       Krzysztof Halasa <khc@pm.waw.pl>, Robert Hancock <hancockr@shaw.ca>,
       Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Denis Vlasenko <vda@ilport.com.ua>,
       Danny van Dyk <kugelfang@gentoo.org>,
       Stephen Hemminger <shemminger@osdl.org>, feyd <feyd@nmskb.cz>,
       Andreas Mohr <andim2@users.sourceforge.net>,
       Bas Vermeulen <bvermeul@blackstar.nl>, Jean Tourrilhes <jt@hpl.hp.com>,
       Daniel Drake <dsd@gentoo.org>, Ulrich Kunitz <kune@deine-taler.de>,
       Phil Dibowitz <phil@ipom.com>, Simon Kelley <simon@thekelleys.org.uk>,
       Michael Buesch <mbuesch@freenet.de>,
       Marcel Holtmann <marcel@holtmann.org>,
       Patrick McHardy <kaber@trash.net>, Ingo Oeser <netdev@axxeo.de>,
       Harald Welte <laforge@gnumonks.org>,
       Ben Greear <greearb@candelatech.com>, Thomas Graf <tgraf@suug.ch>
Subject: Re: wireless: recap of current issues (stack)
Date: Fri, 13 Jan 2006 17:03:28 -0600
User-Agent: KMail/1.9
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com> <20060113213200.GG16166@tuxdriver.com>
In-Reply-To: <20060113213200.GG16166@tuxdriver.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601131703.29677.chase.venters@clientec.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 13 January 2006 15:32, John W. Linville wrote:
> Do we need to have both wireless-stable and wireless-devel kernels?
> What about the suggestion of having both stacks in the kernel at once?
> I'm not very excited about two in-kernel stacks.  Still, consolidating
> wireless drivers down to two stacks is probably better than what we
> have now...?  Either way, we would have to have general understanding
> that at some point (not too far away), one of the stacks would have
> to disappear.

Having not had experience coding for the stacks, I'm not inclined to form an 
opinion on which is better. I think on a realistic footing, a stack switch 
should only occur if it doesn't come at great expense (unless that great 
expense is less than the expense of making the existing stack capable enough 
to handle all the devices we want to support).

But I have to NAK the idea of two stacks. There are implications in the 'here 
and now', so to speak, but what worries me the most is long term. You know 
how it's no fun fixing bugs when you could be adding new features? Let's say 
that on May 2006, you drop the hammer and decide that Stack B is the winner. 
You've now got to convince / motivate the Stack A users to stop what they're 
doing and work hard to migrate to Stack B. There might be stragglers, so 
let's say you set a "drop dead date". Now what happens if we reach that date 
and some drivers still aren't ready. "Tough," you say, "you've had ample 
notice and time to port." Now we've got a flamewar on our hands, because no 
one wants to release a new kernel that drops support for things people are 
using.

By contrast, if we got softmac in, ieee80211 may still be lacking in some 
areas, but if we do the hard work to port a few drivers and get them in-tree 
and working well, you start to have happy users. Motivation will build for 
others to port and get into the tree (partly because no one wants to be the 
odd man out, and their users will probably be frustrated by it too), and part 
of the motivation should extend naturally onto improving in-kernel ieee80211 
enough to support whatever odd-ball implementations they're dealing with. So 
I think you end up with a nice snowball effect.

As an aside to this whole thing, I know we're talking about *kernel* wireless 
but it's worthless to most people without good userland support as well. 
Anyone have any thoughts and feelings on what things look like on the 
desktop? I think if we work closely with some desktop people, we can shepard 
in some wonderful new desktop support on top of the new netlink API.

Cheers,
Chase Venters
