Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261371AbUJZSWe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261371AbUJZSWe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Oct 2004 14:22:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261342AbUJZSWd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Oct 2004 14:22:33 -0400
Received: from mx1.redhat.com ([66.187.233.31]:44768 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261371AbUJZSVf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Oct 2004 14:21:35 -0400
Date: Tue, 26 Oct 2004 14:22:08 -0400 (EDT)
From: Jason Baron <jbaron@redhat.com>
X-X-Sender: jbaron@dhcp83-105.boston.redhat.com
To: John Richard Moser <nigelenki@comcast.net>
cc: akpm@osdl.org, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] fix altsysrq deadlock
In-Reply-To: <417E8CC4.4010706@comcast.net>
Message-ID: <Pine.LNX.4.44.0410261413240.12088-100000@dhcp83-105.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 26 Oct 2004, John Richard Moser wrote:

> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> 
> 
> Jason Baron wrote:
> | hi,
> |
> 
> HI!  ^_^
> 
> [...]
> 
> |  An
> | altsyrq that produces no output might seem troublesome, but it is
> | primarily used as a debugging tool, so trying it again seems reasonable.
> 
> Actually, I use sysrq as if it's just another feature.  It should (I
> think it does. . . not sure) only work on the console directly, for
> security reasons; but it's great when things like X misbehave, or when
> I've damaged something and the system doesn't want to shut down.  AS-E
> AS-I AS-U AS-S AS-O.  :)  I actually tried making an N sysrq, for
> "semi-Normal shutdown."  It would send TERM, wait 5S, send KILL, wait
> 5S, unmount, sync, reboot.
> 
> Just thought it might be interesting to point out that magic-sysrq can
> be a helpful feature for someone not hacking the kernel.
> 

The patch only drops a sysrq that is about to cause a system deadlock. So
if you haven't had any deadlocks this patch shouldn't have a noticeable
affect.

If a caller wants to rely on handle_sysrq, then it should not be called
from interrupt context. handle_sysrq can not defer the work, since the
point of sysrq is to be able get information out when the system is
potentially unusable. How would you know when to defer the work and when
not to?

-Jason




