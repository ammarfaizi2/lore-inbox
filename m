Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261704AbTEUIRX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 May 2003 04:17:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261702AbTEUHza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 May 2003 03:55:30 -0400
Received: from zeus.kernel.org ([204.152.189.113]:37591 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261752AbTEUHnN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 May 2003 03:43:13 -0400
Date: Tue, 20 May 2003 21:43:01 -0700
From: Frank Cusack <fcusack@fcusack.com>
To: Menno Smits <menno@netbox.biz>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel panic with pptpd when mss > mtu
Message-ID: <20030520214301.A3632@google.com>
References: <20030521091442.1bfb41b6.menno@netbox.biz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030521091442.1bfb41b6.menno@netbox.biz>; from menno@netbox.biz on Wed, May 21, 2003 at 09:14:42AM +1000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 21, 2003 at 09:14:42AM +1000, Menno Smits wrote:
> I'm seeing a kernel oops with 2.4.20 which seems to be related to the
> PopTop PPTP server. When certain clients connect in (seems to be
> Win98) and begin large data transfers the kernel will reliably oops.
> The system crashes hard, the oops doesn't make it to the logs.
...
> I have been able to deal with the issue by using the workaround
> suggested in the the second post. That is, adding netfilter rules with
> the TCPMSS target to limit the TCP MSS to PMTU - 40. Apparently the
> problem is triggered by the MSS being bigger than the MTU (which is
> 750 in this case).

Yup.  win98 ignores the negotiated MRU from the PPP peer (MTU on the win98
side) and sends PPP packets larger than MTU.  As you've discovered. :-)

Linux doesn't allocate enough space for the decompressor output, and the
mppe module doesn't properly check that enough space exists.  (That's
because PPP MPPE packets *shrink* after "decompression", and the mppe
module assumes at least the same amount of space as the PPP packet is
allocated for the decompressor.)

Grab the latest ftp://ftp.samba.org/pub/unpacked/ppp which corrects both
of the above problems.

I'll be posting a patch to lkml to correct the decompressor allocation
problem, shortly (a few weeks).

/fc
