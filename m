Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030333AbVIOB4M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030333AbVIOB4M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:56:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030334AbVIOB4M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:56:12 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:26410
	"EHLO opteron.random") by vger.kernel.org with ESMTP
	id S1030333AbVIOB4L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:56:11 -0400
Date: Thu, 15 Sep 2005 03:56:00 +0200
From: Andrea Arcangeli <andrea@cpushare.com>
Cc: Ryan Anderson <ryan@michonline.com>, linux-kernel@vger.kernel.org,
       klive@cpushare.com, Ian Wienand <ianw@gelato.unsw.edu.au>,
       Sam Ravnborg <sam@ravnborg.org>
Subject: Re: git tag in localversion
Message-ID: <20050915015600.GH4966@opteron.random>
References: <20050912210836.GL13439@opteron.random> <d120d5000509121431765f52c8@mail.gmail.com> <20050912222137.GP13439@opteron.random> <20050913083120.GG5276@mythryan2.michonline.com> <20050913141618.GX13439@opteron.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050913141618.GX13439@opteron.random>
User-Agent: Mutt/1.5.9i
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2005 at 04:16:18PM +0200, Andrea Arcangeli wrote:
> On Tue, Sep 13, 2005 at 04:31:27AM -0400, Ryan Anderson wrote:
> > My suggestion would be to classify these wherever they would fall if the
> > -gXXXXXXXX wasn't present, as they fall into the same category.
> 
> I was considering doing this last night.
> 
> OTOH if I do that, I should merge the -git(\d+) in the same category
> too.

Just an update, I did it right now. I hope this is more useful. Of
course the -rc and the .\d+ are left separated. Only the -git\d+
snapshots and the final -gXXXXXXXX tags are merged into the same group.

If this isn't nicer I can restore the previous behaviour with just a
single command. We can give it a try this way.

BTW, after some discussion with Sven, Debian nicely added a vendor +
kernel_group tag to their /proc/version, this is ideal for people to
specify where their kernels should be grouped and classified in klive
(that way I can even automate the branch classification like I'm already
doing with the architectures).

Their format is like this:

10:49 < waldi> Linux version 2.6.13-1-powerpc64 (Debian 2.6.13-1)
(waldi@debian.org) (gcc version 4.0.2 20050821 (prerelease) (Debian 4.0.1-6))
#1 SMP Wed Sep 14 09:28:56 UTC 2005

So the "(Debian 2.6.13-1)" string is what will tell me in which branch
it will go (Debian), and in which kernel_group it will go (2.6.13-1).

I preferred to have it in a separate file, but this should be good
enough too. Unfortunately I didn't send to the server the /proc/version
string in the client, so this will require a protocol update to
activate. If you've suggestion on other bits to add to the protocol,
please tell on the klive mailing list.

The next protocol will also contemplate how to optionally send oopses to
the server with an udp packet and the session number, and optionally
pciids and stuff like that. I guess the oops and other sensitive payload
could be optionally encrypted using a random symmetric key to set in the
kernel, that way people could use klive to securely store oopses to
retrieve later and to decrypt locally later (no ssl involved at all, all
client side). I know myself that I will encrypt it. This should allow to
never risk to lose an oops (as long as we're connected to the ethernet).
If no encryption is used, the oops can go public automatically.

This isn't going to happen soon, probably 2/3 months before the protocol
is implemented (some other project has higher prio).

There is also a twisted-less client invoked purerly by cron implemented
by Christian Aichinger and almost finished if people don't have other
twisted or python services in the background and they want to save a few
megs (once finished I'll add to the package).

The protocol update will not require client updates, old protocol will
keep going. Anyway I feel this is getting a bit offtopic for l-k sorry!
