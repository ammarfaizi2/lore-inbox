Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261679AbVDRFaL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261679AbVDRFaL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Apr 2005 01:30:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbVDRFaL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Apr 2005 01:30:11 -0400
Received: from smtp.Lynuxworks.com ([207.21.185.24]:40720 "EHLO
	smtp.lynuxworks.com") by vger.kernel.org with ESMTP id S261679AbVDRFaF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Apr 2005 01:30:05 -0400
Date: Sun, 17 Apr 2005 22:30:42 -0700
To: Inaky Perez-Gonzalez <inaky@linux.intel.com>
Cc: Bill Huey <bhuey@lnxw.com>, Steven Rostedt <rostedt@goodmis.org>,
       dwalker@mvista.com, mingo@elte.hu, linux-kernel@vger.kernel.org,
       Esben Nielsen <simlo@phys.au.dk>
Subject: Re: FUSYN and RT
Message-ID: <20050418053042.GA11399@nietzsche.lynx.com>
References: <Pine.OSF.4.05.10504130056271.6111-100000@da410.phys.au.dk> <1113352069.6388.39.camel@dhcp153.mvista.com> <1113407200.4294.25.camel@localhost.localdomain> <20050415225137.GA23222@nietzsche.lynx.com> <16992.20513.551920.826472@sodium.jf.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16992.20513.551920.826472@sodium.jf.intel.com>
User-Agent: Mutt/1.5.9i
From: Bill Huey (hui) <bhuey@lnxw.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 04:37:05PM -0700, Inaky Perez-Gonzalez wrote:
> By following your method, the pi engine becomes unnecesarily complex;
> you have actually two engines following two different propagation
> chains (one kernel, one user). If your mutexes/locks/whatever are the
> same with a different cover, then you can simplify the whole
> implementation by leaps.

The main comment that I'm making here (so it doesn't get lost) is that,
IMO, you're going to find that there is a mismatch with the requirements
of Posix threading verse kernel uses. To drop the kernel mutex in 1:1 to
back a futex-ish entity is going to be problematic mainly because of how
kernel specific the RT mutex is (or any future kernel mutex) for debugging,
etc... and I think this is going to be clear as it gets progressively
implemented.

I think folks really need to think about this clearly before moving into
any direction prematurely. That's what I'm saying. PI is one of those
issues, but ultimately it's the fundamental differences between userspace
and kernel work.

LynxOS (similar threading system) keep priority calculations of this kind
seperate between user and kernel space. I'll have the ask one of our
engineers here why again that's the case, but I suspect it's for the
reasons I've discussed previously.

bill

