Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTHTOXE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Aug 2003 10:23:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261982AbTHTOXE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Aug 2003 10:23:04 -0400
Received: from 153.Red-213-4-13.pooles.rima-tde.net ([213.4.13.153]:29702 "EHLO
	small.felipe-alfaro.com") by vger.kernel.org with ESMTP
	id S261977AbTHTOXA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Aug 2003 10:23:00 -0400
Subject: Re: [OT] Connection tracking for IPSec
From: Felipe Alfaro Solana <felipe_alfaro@linuxmail.org>
To: Christophe Saout <christophe@saout.de>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1061381498.4210.16.camel@chtephan.cs.pocnet.net>
References: <1061378568.668.9.camel@teapot.felipe-alfaro.com>
	 <1061381498.4210.16.camel@chtephan.cs.pocnet.net>
Content-Type: text/plain
Message-Id: <1061389376.3804.16.camel@teapot.felipe-alfaro.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Wed, 20 Aug 2003 16:22:57 +0200
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2003-08-20 at 14:11, Christophe Saout wrote:
> Am Mi, 2003-08-20 um 13.22 schrieb Felipe Alfaro Solana:
> 
> > When using IPSec, if I open up protocols 50 and 51, all IPSec-protected
> > traffic passes through the firewall, but it's not checked against the
> > connection tracking module. How can I configure iptables so an
> > IPSec-protected packet, after being classified as IP protocol 50 or 51,
> > loop back one more time to pass through the connection tracking module?
> 
> You're saying it's not honouring the netfilter rules at all?

No... What I'm saying is that normal IP traffic is processed by the
firewall. However, if the incoming traffic is protected with IPSec,
since I opened up protocols 50 and 51, the IPSec traffic is admitted
without passing any remaining firewall filters. The machine in question
is an end host (not a router).

I want something like this:

1. If an IPSec-protected IP packet arrives and since we're not operating
in tunnel mode (the machine is an end host and not a router), the IP
header contains the destination host and is readable. Since we're using
ESP and the packet is intended for us, decrypt the payload to get access
to the TCP/UDP/ICMP data.
2. Else, if the incoming packet is not IPSec-protected, the TCP/UDP/ICMP
payload is already in plaintext.
3. At this point, we have a plaintext TCP/UDP/ICMP payload.
4. If the TCP/UDP/ICMP incoming packet belongs to an existing
connection, that was initiated locally, let the packet pass.
5. Else, the packet is silently discarded.

