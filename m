Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267350AbTBUKgi>; Fri, 21 Feb 2003 05:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267357AbTBUKga>; Fri, 21 Feb 2003 05:36:30 -0500
Received: from ns.suse.de ([213.95.15.193]:2572 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S267362AbTBUKff>;
	Fri, 21 Feb 2003 05:35:35 -0500
Date: Fri, 21 Feb 2003 11:45:41 +0100
From: Andi Kleen <ak@suse.de>
To: "David S. Miller" <davem@redhat.com>
Cc: ak@suse.de, sim@netnation.com, linux-kernel@vger.kernel.org,
       linux-net@vger.kernel.org
Subject: Re: Longstanding networking / SMP issue? (duplextest)
Message-ID: <20030221104541.GA18417@wotan.suse.de>
References: <20030221072719.GD25144@wotan.suse.de> <20030221.014316.69598293.davem@redhat.com> <20030221102257.GA10108@wotan.suse.de> <20030221.021125.66547838.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030221.021125.66547838.davem@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2003 at 02:11:25AM -0800, David S. Miller wrote:
>    From: Andi Kleen <ak@suse.de>
>    Date: Fri, 21 Feb 2003 11:22:58 +0100
>    
>    Doesn't work on preemptive, does it? How do you keep it on a single CPU
>    when it runs in process context ?
> 
> What runs in process context?  ICMP responses are generated from BH's.

hmm, i was thinking about tcp process context, but you're right it can
only generate icmps for dead ports and that happens while still in
tcp_v4_rcv().

at least ipip.c will send icmps from process context (ipip_tunnel_xmit)

netfilter will probably do too.

-Andi
