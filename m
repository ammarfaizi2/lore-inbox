Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266544AbUG0SWZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266544AbUG0SWZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 14:22:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266545AbUG0SWM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 14:22:12 -0400
Received: from fep19.inet.fi ([194.251.242.244]:2988 "EHLO fep19.inet.fi")
	by vger.kernel.org with ESMTP id S266544AbUG0SVt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 14:21:49 -0400
Date: Tue, 27 Jul 2004 21:21:55 +0300
From: pp <inventor@mbnet.fi>
To: linux-kernel@vger.kernel.org
Subject: Re: Remotely triggered kernel panic on IPv6 enabled linux boxes (no
 more PPPoE)
Message-Id: <20040727212155.06bb48b9@lpr2-160.cable.inet.fi>
In-Reply-To: <Pine.GSO.4.58.0407271720390.4851@kekkonen.cs.hut.fi>
References: <Pine.GSO.4.58.0407271720390.4851@kekkonen.cs.hut.fi>
X-Mailer: Sylpheed version 0.9.11claws (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jul 2004 17:38:23 +0300 (EEST)
Pasi Valminen wrote:

> > I can trigger a kernel panic from a remote host using tracepath6.
> > First I connect to the internet using pppoe.
> PPPoE is not needed to crash the kernel. Plain vanilla 2.6.7 will
> crash just fine without it, seems like bringing up an ipv6 tunnel is
> enough. Then just
> 
> $ tracepath6 <your tunnel ipv6 endpoint>
> 
> from a remote host and the kernel panics without any entry in the
> syslog. But there is a quick and easy workaround. If you modprobe
> ip6table_filter, the kernel won't panic!

I can confirm the whole thing.

I have:
cable modem & NIC, using DHCP, no PPPoE or anything like that
heartbeat tunnel from Sixxs.net
Gentoo Linux
Kernel 2.6.7 vanilla, gcc 3.3.3

I have worked with Pasi a couple of days now and he has crashed my
machine many times. With the help of a serial terminal I have gathered
some information about the crashes, including kernel oops/panic messages
and tcpdump output.
The information is here:
http://www.hack.fi/~pq/

My machine crashes immediately when someone runs a tracepath6 on me,
unless I have ip6table_filter module loaded.
To get to the vulnerable state all I have to do is to boot (to single
user mode), bring inet interface up and establish the tunnel.
We have not yet tested if it works with 6to4 connection also.

The data at the URL is somewhat censored, but I can provide the original
data and any other information if needed.
I am also willing to assist in solving the problem, try out patches etc.


I am not a subscriber to LKML.
-- 
Pekka "PQ" Paalanen
