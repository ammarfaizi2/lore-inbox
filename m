Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932281AbVIFCY0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932281AbVIFCY0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVIFCY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:24:26 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:39855 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S1751254AbVIFCYZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:24:25 -0400
Date: Tue, 6 Sep 2005 03:24:23 +0100
From: viro@ZenIV.linux.org.uk
To: "David S. Miller" <davem@davemloft.net>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Kconfig fix (GEN_RTC dependencies)
Message-ID: <20050906022423.GT5155@ZenIV.linux.org.uk>
References: <20050906005645.GQ5155@ZenIV.linux.org.uk> <20050905.185141.44096788.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905.185141.44096788.davem@davemloft.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 06:51:41PM -0700, David S. Miller wrote:
> Admittedly, the whole RTC situation is quite a mess I have to
> agree.
> 
> To make the problem worse, we have two sets of RTC ioctls
> which userland makes use of on Sparc.  The older ones which
> the SBUS RTC driver exported and supported, and the normal
> ones the rest of the world uses.  Because the normal RTC driver
> gets used as well, userland actually tries both ioctl sets.
> Therefore, it probably would work to completely do away with
> the SBUS RTC ioctl support, and only use the normal ones.
> 
> This would make using the generic RTC driver much easier, I
> would think.

Yeah...  Note that what you've just called "generic RTC driver" is
*not* GEN_RTC; it's RTC.

>From my reading of that code, GEN_RTC should've been called FAKE_RTC...
AFAICS, more or less clean solution would be to split the damn thing
into frontend (parsing of ioctls, hopefully very few API variants) and
backend (set of methods for talking to real hardware, or, in this case,
fake of a hardware).  With at most one backend selectable (i.e. select
in Kconfig) and frontend available if backend is selected.  With any
luck we could eventually get frontends down to one; in any case, their
APIs have no place in include/asm-*

Note that e.g. fsckloads of MIPS RTC drivers would simply become backends
in that scheme; lots of duplicated glue would disappear from them...
I'll look into that once the things settle down a bit with handling the
-bird tree; if you get there first with the work you've mentioned above -
even better ;-)
