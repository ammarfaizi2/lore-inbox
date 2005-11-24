Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751387AbVKXTWc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751387AbVKXTWc (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 14:22:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbVKXTWc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 14:22:32 -0500
Received: from teetot.devrandom.net ([66.35.250.243]:49847 "EHLO
	teetot.devrandom.net") by vger.kernel.org with ESMTP
	id S1750745AbVKXTWb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 14:22:31 -0500
Date: Thu, 24 Nov 2005 11:24:14 -0800
From: thockin@hockin.org
To: Andi Kleen <ak@suse.de>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Gerd Knorr <kraxel@suse.de>,
       Linus Torvalds <torvalds@osdl.org>, Dave Jones <davej@redhat.com>,
       Zachary Amsden <zach@vmware.com>, Pavel Machek <pavel@ucw.cz>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Ingo Molnar <mingo@elte.hu>
Subject: Re: [patch] SMP alternatives
Message-ID: <20051124192414.GA3670@hockin.org>
References: <m1zmnugom7.fsf@ebiederm.dsl.xmission.com> <20051124133907.GG20775@brahms.suse.de> <1132842847.13095.105.camel@localhost.localdomain> <20051124142200.GH20775@brahms.suse.de> <1132845324.13095.112.camel@localhost.localdomain> <20051124145518.GI20775@brahms.suse.de> <m1psoqgk18.fsf@ebiederm.dsl.xmission.com> <20051124153635.GJ20775@brahms.suse.de> <20051124191207.GB2468@hockin.org> <20051124191445.GR20775@brahms.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051124191445.GR20775@brahms.suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 24, 2005 at 08:14:46PM +0100, Andi Kleen wrote:
> > I'm curious about that too.  Even with k8 you can get down to a
> > chip-select, but that doesn't necessarily map to a DIMM in any useful way,
> > unless you have some mobo knowledge.  Are we going to need a new BIOS
> 
> Yeah that's my problem.
> 
> It's not theoretical. We had cases where someone had to go 
> through 10+ DIMMs on a big machine in try and error to find
> out which one is wrong. Very bad situation.

I have the exact same problem right now.  Part of our early bootup we run
a simplish memory test.  Basically it's a "can the memory hold state"
test.  If anything fails, we have to identify as exactly as possible WHICH
DIMM needs to be replaced, so the hardware ops people can do it at
assembly/test time.

We implemented AMD's reference algorithm, and made it work in the presence
of a hardware IO hole.  It seems to work beautifully, but the last step is
turning a (node:chip-select) into a (node:dimm).  Simple boards will use
simple mappings, but we can't know that without board specific info.
Especially with quad-rank DIMMs. :)

> > table to map chip-selects onto DIMMs? :)
> 
> I proposed something like that - best with an ASCII string
> ("First DIMM on the top left corner") But getting such stuff into BIOS 
> is difficult and long winded.

It would be easy enough to get into LinuxBIOS. :)

Seriously, this is work that is *long* overdue.  I have been wanting to
look at this for over a year, but I have not had time.

Doing proper architecture and chipset-specific ECC/error handling which
ties into a bigger abstracted error system is going to be really nice.
