Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132911AbRDQWYt>; Tue, 17 Apr 2001 18:24:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132910AbRDQWYj>; Tue, 17 Apr 2001 18:24:39 -0400
Received: from m110-mp1-cvx1c.col.ntl.com ([213.104.76.110]:5280 "EHLO
	[213.104.76.110]") by vger.kernel.org with ESMTP id <S132908AbRDQWY2>;
	Tue, 17 Apr 2001 18:24:28 -0400
To: "Grover, Andrew" <andrew.grover@intel.com>
Cc: "'Pavel Machek'" <pavel@suse.cz>,
        Simon Richter <Simon.Richter@phobos.fachschaften.tu-muenchen.de>,
        Andreas Ferber <aferber@techfak.uni-bielefeld.de>,
        <linux-kernel@vger.kernel.org>
Subject: Re: Let init know user wants to shutdown
In-Reply-To: <4148FEAAD879D311AC5700A0C969E8905DE847@orsmsx35.jf.intel.com>
From: John Fremlin <chief@bandits.org>
Date: 17 Apr 2001 23:23:32 +0100
In-Reply-To: "Grover, Andrew"'s message of "Tue, 17 Apr 2001 09:45:07 -0700"
Message-ID: <m24rvntbbv.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "Grover, Andrew" <andrew.grover@intel.com> writes:

> Hi Pavel,
> 
> I think init is doing a perfect job WRT UPSs because this is a
> trivial application of power management. init wasn't really meant
> for this.  According to its man page:
> 
> "init...it's primary role is to create processes from a script in
> the file /etc/inittab...It also controls autonomous processes
> required by any particular system"
> 
> We are going to need some software that handles button events, as
> well as thermal events, battery events, polling the battery, AC
> adapter status changes, sleeping the system, and more.

Dealing with events should be disjoint from polling the battery or
powerstatus. Many processes might reasonably simultaneously want to
provide a display to the user of the current power status.

However, button presses and so on should be handled by a single
process. Otherwise the kernel is unreasonably complicated by having to
deal with multiple processes' veto power, which could just as well and
more flexibly be handled in userspace.

I don't why there needs to be an additional daemon constantly running
to deal with button presses and power status changes. Apparently init
is already handling similar things: why should it not be extended to
include button presses?

Alternatively, why not forgo a daemon altogether? (This scheme is
already implemented in the pmpolicy patch, i.e. it is already
working.)

> We need WAY more flexibility than init provides. 

Examples please.

[...]

-- 

	http://www.penguinpowered.com/~vii
