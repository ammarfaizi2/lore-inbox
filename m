Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293589AbSCKDPy>; Sun, 10 Mar 2002 22:15:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293590AbSCKDPp>; Sun, 10 Mar 2002 22:15:45 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:55942 "EHLO
	lacrosse.corp.redhat.com") by vger.kernel.org with ESMTP
	id <S293589AbSCKDPf>; Sun, 10 Mar 2002 22:15:35 -0500
Date: Sun, 10 Mar 2002 22:15:30 -0500
From: Benjamin LaHaise <bcrl@redhat.com>
To: "David S. Miller" <davem@redhat.com>
Cc: whitney@math.berkeley.edu, rgooch@ras.ucalgary.ca,
        linux-kernel@vger.kernel.org
Subject: Re: Broadcom 5700/5701 Gigabit Ethernet Adapters
Message-ID: <20020310221530.A28821@redhat.com>
In-Reply-To: <200203110205.g2B25Ar05044@adsl-209-76-109-63.dsl.snfc21.pacbell.net> <20020310.180456.91344522.davem@redhat.com> <20020310212210.A27870@redhat.com> <20020310.183033.67792009.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020310.183033.67792009.davem@redhat.com>; from davem@redhat.com on Sun, Mar 10, 2002 at 06:30:33PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 06:30:33PM -0800, David S. Miller wrote:
> Syskonnect sk98 with jumbo frames gets ~107MB/sec TCP bandwidth
> without NAPI, there is no reason other cards cannot go full speed as
> well.
> 
> NAPI is really only going to help with high packet rates not with
> thinks like raw bandwidth tests.

Well, the thing that hurts the 83820 is that its interrupt 
mitigation capabilities are rather limited.  This is where napi 
helps: by turning off the rx interrupt for the duration of packet 
processing, cpu cycles aren't wasted on excess rx irqs.

As to the lack of bandwidth, it stems from far too much interrupt 
overhead and the currently braindead attempt at irq mitigation.  
Since the last time I worked on it, a number of potential techniques 
have come up that should bring it into the 100MB realm (assuming it 
doesn't get trampled on by ksoftirqd).

		-ben
-- 
"A man with a bass just walked in,
 and he's putting it down
 on the floor."
