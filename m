Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750799AbWAaMua@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750799AbWAaMua (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Jan 2006 07:50:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750796AbWAaMua
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Jan 2006 07:50:30 -0500
Received: from stinky.trash.net ([213.144.137.162]:38126 "EHLO
	stinky.trash.net") by vger.kernel.org with ESMTP id S1750781AbWAaMu3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Jan 2006 07:50:29 -0500
Message-ID: <43DF5D11.2040703@trash.net>
Date: Tue, 31 Jan 2006 13:50:25 +0100
From: Patrick McHardy <kaber@trash.net>
User-Agent: Debian Thunderbird 1.0.7 (X11/20051019)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Reuben Farrelly <reuben-lkml@reub.net>
CC: Harald Welte <laforge@netfilter.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
       Linux Netdev List <netdev@vger.kernel.org>
Subject: Re: ip_conntrack related slab error (Re: Fw: Re: 2.6.16-rc1-mm3)
References: <20060130221429.5f12d947.akpm@osdl.org> <20060131092447.GL4603@sunbeam.de.gnumonks.org> <43DF36FD.70305@reub.net>
In-Reply-To: <43DF36FD.70305@reub.net>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reuben Farrelly wrote:
> tornado.reub.net login: BUG: unable to handle kernel paging request at
> virtual address 00200200

This means ct->nat.info.bysource was already removed from the list,
which can only happen if the conntrack entry is destroyed twice.

I can't find how this could have happened, please enable
CONFIG_NETFILTER_DEBUG, the DPRINTK defines in
ip_conntrack_{standalone,core,netlink}.c and ip_nat_{core,standalone}.c
and logging of invalid packets ("echo 255 >
/proc/sys/net/ipv4/netfilter/ip_conntrack_log_invalid"). I hope this
will give some clues ..
