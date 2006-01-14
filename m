Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751495AbWANONy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751495AbWANONy (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Jan 2006 09:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751527AbWANONy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Jan 2006 09:13:54 -0500
Received: from deine-taler.de ([217.160.107.63]:32184 "EHLO
	p15091797.pureserver.info") by vger.kernel.org with ESMTP
	id S1751522AbWANONx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Jan 2006 09:13:53 -0500
Date: Sat, 14 Jan 2006 15:13:39 +0100 (CET)
From: Ulrich Kunitz <kune@deine-taler.de>
To: "John W. Linville" <linville@tuxdriver.com>
cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: wireless: recap of current issues (stack)
In-Reply-To: <20060113213200.GG16166@tuxdriver.com>
Message-ID: <Pine.LNX.4.58.0601141448480.5587@p15091797.pureserver.info>
References: <20060113195723.GB16166@tuxdriver.com> <20060113212605.GD16166@tuxdriver.com>
 <20060113213200.GG16166@tuxdriver.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 13 Jan 2006, John W. Linville wrote:

> Can the in-kernel stack be saved?  With the addition of softmac?
> Is it possible to extend softmac to support virtual wlan devices?
> If not, how do we proceed?

I don't think, that we can continue with the current model of the
stacks. There appears a great variance in the HOST-device
interfaces between WLAN devices of several vendors. The other
problem is, that there is a difference depending on the bus the
device is connected to. Register accesses in USB devices should be
able to sleep. However the 80211 stacks I've seen so far have a
fixed set of capabilities and do also assume, that at the driver
layer everything can be done in atomic mode, which is only true
for buses that support memory-mapping.

In my point of view each stack layer must allow drivers to
overwrite all entry-functions. Drivers could then do
cherry-picking of the provided standard-functions. This is of
course the library approach. The discussion about multiple
stacks will then be muted, because we would have several stacks in
the kernel and on the devices, which would have compatible interfaces.

> Do we need to have both wireless-stable and wireless-devel kernels?
> What about the suggestion of having both stacks in the kernel at once?
> I'm not very excited about two in-kernel stacks.  Still, consolidating
> wireless drivers down to two stacks is probably better than what we
> have now...?  Either way, we would have to have general understanding
> that at some point (not too far away), one of the stacks would have
> to disappear.

See above.

-- 
Ulrich Kunitz - kune@deine-taler.de
