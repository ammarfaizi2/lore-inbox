Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262660AbVAEXeR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262660AbVAEXeR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 18:34:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262664AbVAEXeR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 18:34:17 -0500
Received: from hera.kernel.org ([209.128.68.125]:39655 "EHLO hera.kernel.org")
	by vger.kernel.org with ESMTP id S262660AbVAEXd7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 18:33:59 -0500
To: linux-kernel@vger.kernel.org
From: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: 2.6.10 TCP troubles
Date: Wed, 5 Jan 2005 15:33:07 -0800
Organization: Open Source Development Lab
Message-ID: <20050105153307.739ef5d8@dxpl.pdx.osdl.net>
References: <05081I514@server5.heliogroup.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Trace: build.pdx.osdl.net 1104967986 8755 172.20.1.103 (5 Jan 2005 23:33:06 GMT)
X-Complaints-To: abuse@osdl.org
NNTP-Posting-Date: Wed, 5 Jan 2005 23:33:06 +0000 (UTC)
X-Newsreader: Sylpheed-Claws 0.9.13 (GTK+ 1.2.10; x86_64-unknown-linux-gnu)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 05 Jan 2005 08:13:17 GMT
Hubert Tonneau <hubert.tonneau@fullpliant.org> wrote:

> Here is the senario:
> the Linux machine is writting through libsmbclient
> to an OSX machine running Samba
> 
> Switching the Linux machine from 2.6.8 to 2.6.10 made the network speed
> drop drastically: 20 seconds with 2.6.8, 800 seconds with 2.6.10
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

Some possiblities:
	2.6.8 still had the broken TCP segmentation offload that didn't obey
	congestion/slow start.  Are you using hardware that supports TSO?
	Does 2.6.8 behaviour change if you turn TSO off with ethtool?

	Is there window scaling or other issues?  Does 2.6.10 get faster if
	you turn of window scaling sys.net.ipv4.tcp_window_scaling=0?
	Is there a window scale corrupting firewall (like OpenBSD pf)
	in the way?

	Is there more packet loss on the router or the Mac?
