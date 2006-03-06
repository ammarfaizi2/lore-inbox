Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750999AbWCFReG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750999AbWCFReG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Mar 2006 12:34:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751956AbWCFReG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Mar 2006 12:34:06 -0500
Received: from adsl-71-140-189-62.dsl.pltn13.pacbell.net ([71.140.189.62]:29363
	"EHLO aexorsyst.com") by vger.kernel.org with ESMTP
	id S1750999AbWCFReF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Mar 2006 12:34:05 -0500
From: "John Z. Bohach" <jzb@aexorsyst.com>
Reply-To: jzb@aexorsyst.com
To: "PaNiC" <panic@klippanlan.net>, <linux-kernel@vger.kernel.org>
Subject: Re: Problem: NIC transmit timeouts
Date: Mon, 6 Mar 2006 09:33:57 -0800
User-Agent: KMail/1.5.2
References: <001501c64119$6d8e7bc0$072011ac@majestix>
In-Reply-To: <001501c64119$6d8e7bc0$072011ac@majestix>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603060933.57036.jzb@aexorsyst.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 06 March 2006 04:28, PaNiC wrote:
> 1. The problem is that the outbound interface in a Sun Enterprise 250
> running maquerade gets transmit timeouts frequently.
>
> 2. I get the error "NETDEV WATCHDOG: eth0: transmit timed out" and a
> couple of seconds later the     interface jumps back up again. This

I can't say what the cause of your particular NETDEV WATCHDOG timeout may
be, but I had the same problem, and I root-caused it to the host bus <--> PCI bridge
configuration.  In particular, the multi-transaction timeout register in the bridge
wasn't programmed, and heavy PCI traffic would cause aborts.  Also, the
ICH configuration register had to be programmed according to the manufacturer's
recommendations.

This was on Intel h/w, and the registers to which I refer are
proprietary, so its a bit difficult to know what values to program where,
but it might give you a place to start.  On the other hand, some people have
reported issues with their device driver causing some timeouts, but your symptoms
seem to more closely resemble what I was seeing than those folks who had
s/w issues.

Regards,
John

