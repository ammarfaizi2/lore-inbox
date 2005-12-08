Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965014AbVLHFic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965014AbVLHFic (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Dec 2005 00:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965065AbVLHFic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Dec 2005 00:38:32 -0500
Received: from dsl027-180-168.sfo1.dsl.speakeasy.net ([216.27.180.168]:58811
	"EHLO sunset.davemloft.net") by vger.kernel.org with ESMTP
	id S965014AbVLHFic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Dec 2005 00:38:32 -0500
Date: Wed, 07 Dec 2005 21:38:25 -0800 (PST)
Message-Id: <20051207.213825.27890558.davem@davemloft.net>
To: davej@redhat.com
Cc: ak@suse.de, linux-kernel@vger.kernel.org
Subject: Re: for_each_online_cpu broken ?
From: "David S. Miller" <davem@davemloft.net>
In-Reply-To: <20051208053302.GA28201@redhat.com>
References: <20051208050738.GE24356@redhat.com>
	<20051208052632.GF11190@wotan.suse.de>
	<20051208053302.GA28201@redhat.com>
X-Mailer: Mew version 4.2.53 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Jones <davej@redhat.com>
Date: Thu, 8 Dec 2005 00:33:02 -0500

> On Thu, Dec 08, 2005 at 06:26:32AM +0100, Andi Kleen wrote:
> 
>  > The possible map is fixed kind of BTW in 2.6.15rc*. It was a side effect
>  > of CPU hotplug, which now uses a better algorithm to guess the 
>  > number of possible CPUs. In 2.6.15 you will just get half the number
>  > of available CPUs in addition by default
> 
> Yep, I noticed it offers a maximum of 6 cpus on my way.
> As a sidenote, seems kinda funny (and wasteful maybe?), doing this
> on a lot of hardware that isn't hotplug capable. (Whilst I could
> disable cpu hotplug in my local build, this isn't an answer for
> a generic distro kernel).

This can be dangerous btw, as some subsystem such as netfilter
allocate enormous datastructures based upon the largest possible
cpu number in the system.

In 2.6.16 it will use something a bit more intelligent, but
overestimating the possible cpu set can be quite a waste.
