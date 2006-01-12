Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161344AbWALWCB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161344AbWALWCB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Jan 2006 17:02:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161343AbWALWCA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Jan 2006 17:02:00 -0500
Received: from stinky.trash.net ([213.144.137.162]:5804 "EHLO stinky.trash.net")
	by vger.kernel.org with ESMTP id S1161341AbWALWB7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Jan 2006 17:01:59 -0500
Message-ID: <43C6D1A6.1090207@trash.net>
Date: Thu, 12 Jan 2006 23:01:10 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051017)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: "Rafael J. Wysocki" <rjw@sisk.pl>, linux-kernel@vger.kernel.org,
       netdev@vger.kernel.org
Subject: Re: 2.6.15-mm3
References: <20060111042135.24faf878.akpm@osdl.org>	<200601122205.04714.rjw@sisk.pl> <20060112135839.2e74d8a8.akpm@osdl.org>
In-Reply-To: <20060112135839.2e74d8a8.akpm@osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
>>Hi,
>>
>>On Wednesday, 11 January 2006 13:21, Andrew Morton wrote:
>>
>>>ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm3/
>>
>>I got that on system shutdown (x86-64, 1 CPU):
> 
> 
> Thanks.   ipv6 died.  I think shemminger had a recent problem with ipv6 too?
> 
> I don't think there were any core networking changes in -mm3 which weren't
> in linus-at-that-time.
> 
> 
>>Unable to handle kernel NULL pointer dereference at 00000000000001b4 RIP:
>><ffffffff881cba51>{:ipv6:ip6_xmit+593}

That crash is already fixed in Linus' latest tree by this patch:

tree 3d4ce288b86cb2845d79c6adec9e254054bb0e02
parent a7768097557be91d0d4c37e8f2e38cd126c4cdf9
author David Woodhouse <dwmw2@infradead.org> Thu, 12 Jan 2006 07:53:04 -0800
committer David S. Miller <davem@sunset.davemloft.net> Thu, 12 Jan 2006 
08:32:13 -0800

[IPV6]: Avoid calling ip6_xmit() with NULL sk
The ip6_xmit() function now assumes that its sk argument is non-NULL,
which isn't currently true when TCPv6 code is sending RST or ACK
packets. This fixes that code to use a socket of its own for sending
such packets, as TCPv4 does. (Thanks Andi for the pointer).

Signed-off-by: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: David S. Miller <davem@davemloft.net>


