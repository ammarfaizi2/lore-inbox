Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751326AbWHVA3L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751326AbWHVA3L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Aug 2006 20:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751325AbWHVA3L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Aug 2006 20:29:11 -0400
Received: from sj-iport-1-in.cisco.com ([171.71.176.70]:29779 "EHLO
	sj-iport-1.cisco.com") by vger.kernel.org with ESMTP
	id S1751309AbWHVA3J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Aug 2006 20:29:09 -0400
To: David Miller <davem@davemloft.net>
Cc: linas@austin.ibm.com, arnd@arndb.de, shemminger@osdl.org, akpm@osdl.org,
       netdev@vger.kernel.org, jklewis@us.ibm.com,
       linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
       Jens.Osterkamp@de.ibm.com, jgarzik@pobox.com
Subject: Re: [RFC] HOWTO use NAPI to reduce TX interrupts
X-Message-Flag: Warning: May contain useful information
References: <44E7BB7F.7030204@osdl.org> <200608191325.19557.arnd@arndb.de>
	<20060821235244.GJ5427@austin.ibm.com>
	<20060821.165616.107936004.davem@davemloft.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 21 Aug 2006 17:29:05 -0700
In-Reply-To: <20060821.165616.107936004.davem@davemloft.net> (David Miller's message of "Mon, 21 Aug 2006 16:56:16 -0700 (PDT)")
Message-ID: <adaac5x3966.fsf@cisco.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.18 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 22 Aug 2006 00:29:07.0974 (UTC) FILETIME=[FB08AA60:01C6C581]
Authentication-Results: sj-dkim-2.cisco.com; header.From=rdreier@cisco.com; dkim=pass (
	sig from cisco.com verified; ); 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    David> Don't touch interrupts until both RX and TX queue work is
    David> fullydepleted.  You seem to have this notion that RX and TX
    David> interrupts are seperate.  They aren't, even if your device
    David> can generate those events individually.  Whatever interrupt
    David> you get, you shut down all interrupt sources and schedule
    David> the ->poll().  Then ->poll() does something like:

This is a digression from spidernet, but what if a device is able to
generate separate MSIs for TX and RX?  Some people from IBM have
suggested that it is beneficial for throughput to handle TX work and
RX work for IP-over-InfiniBand in parallel on separate CPUs, and
handling everything through the ->poll() method would defeat this.

 - R.
