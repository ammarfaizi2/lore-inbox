Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263322AbTEVVPA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 May 2003 17:15:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263332AbTEVVPA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 May 2003 17:15:00 -0400
Received: from tux.rsn.bth.se ([194.47.143.135]:62654 "EHLO tux.rsn.bth.se")
	by vger.kernel.org with ESMTP id S263322AbTEVVO6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 May 2003 17:14:58 -0400
Subject: Re: kernel panic on heavily loaded 2.4.20 router
From: Martin Josefsson <gandalf@wlug.westbo.se>
To: Frank Dekervel <kervel-lkml@drie.kotnet.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200305222147.39687.kervel-lkml@drie.kotnet.org>
References: <200305222147.39687.kervel-lkml@drie.kotnet.org>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Organization: 
Message-Id: <1053638881.9483.75.camel@tux.rsn.bth.se>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 22 May 2003 23:28:01 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-05-22 at 21:47, Frank Dekervel wrote:
> hello,
> 
> a linux-2.4.20 (vanilla) machine we use as a router/iptables firewall 
> crashes once a month in what seems to be the IP stack 
> (see the lspci/lsmod/ksymoops output below). Does somebody know
> what the cause could be ?

> Module                  Size  Used by    Not tainted
> ipt_limit                960  19  (autoclean)
> ip_conntrack_ftp        3776   0  (unused)
> ipt_state                608   4  (autoclean)
> ipt_LOG                 3232  13  (autoclean)
> iptable_nat            14452   1  (autoclean)
> ip_conntrack           16716   3  (autoclean) [ip_conntrack_ftp ipt_state iptable_nat]
> iptable_filter          1728   1  (autoclean)
> ip_tables              10624   7  [ipt_limit ipt_state ipt_LOG iptable_nat iptable_filter]
> serial                 42336   0  (autoclean)
> ne2k-pci                4832   2
> 8390                    5952   0  [ne2k-pci]
> via-rhine              11912   1
> mii                     2288   0  [via-rhine]
> 3c59x                  24712   1

Kernel 2.4.20 contains a bug in conntrack (memory-corruption) that can
be triggered when using conntrack helpers. It's fixed in 2.4.21-rc2 so I
suggest you try that. The crashes you see might be the result of this
bug, or maybe not.

I suggest you send this report to linux-net@vger.kernel.org and ask if
it looks like a real bug or if it's memory-corruption.
But you really should upgrade your kernel.

-- 
/Martin
