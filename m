Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267878AbUGWSfy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267878AbUGWSfy (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jul 2004 14:35:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267877AbUGWSfy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jul 2004 14:35:54 -0400
Received: from [66.35.79.110] ([66.35.79.110]:17561 "EHLO www.hockin.org")
	by vger.kernel.org with ESMTP id S267878AbUGWSfQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jul 2004 14:35:16 -0400
Date: Fri, 23 Jul 2004 11:25:54 -0700
From: Tim Hockin <thockin@hockin.org>
To: Robert Love <rml@ximian.com>
Subject: Re: [patch] kernel events layer
Message-ID: <20040723182554.GA31701@hockin.org>
References: <1090604517.13415.0.camel@lucy>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1090604517.13415.0.camel@lucy>
User-Agent: Mutt/1.4.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 23, 2004 at 01:41:57PM -0400, Robert Love wrote:
> OK, Kernel Summit and my OLS talk are over, so here are the goods.

It's good to see something concrete in this vein.  Is this interface going
to be intended for things like error states?  The first thing that jumps
to mind is all the evlog stuff that was argued about last year.

Is this interface intended to be used in the name of driver "hardening"
and fault handling?

> +		send_kmessage(KMSG_POWER,
> +			"/org/kernel/devices/system/cpu/temperature", "high",
> +			"Cpu: %d\n", cpu);

I have to ask why the path needs to include /org ?  It seems pretty much
like useless stuff.  In fact, why does it need to specify /org/kernel?
Userspace can safely assume that anything that comes out of the netlink
socket is from the kernel, no?

If userspace is going to use this "object" path as a globalish identifier,
it can prepend hatever it needs.  Really, it should prepend some sort of
network id, if this stuff is ever going to find a network, so eliminating
the /org/kernel might just be precedent.

At worst case, why type it in every call to send_kmessage?  If they ALL
start with /org/kernel, just add that inside the send_kmessage() guts.

Further, if you want to eliminate stupid typo errors, these paths cn be
further macro-ized.

	send_kmessage(KMSG_POWER, KMSUBSYS_CPU, "temperature", "high",
		"Cpu: %d", cpu);

KMSUBSYS_CPU can be recognized and expanded to "/devices/system/cpu".
That way, no one ever misspels it, leaving you stuck with it.  Also note
that requiring the caller to pass a '\n' seems pretty dumb.

Just my initial thoughts.  I need to read the paper, still.

Tim
