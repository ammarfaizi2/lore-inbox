Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261583AbUKCNXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261583AbUKCNXN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 08:23:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261594AbUKCNXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 08:23:13 -0500
Received: from hell.sks3.muni.cz ([147.251.210.30]:22410 "EHLO
	hell.sks3.muni.cz") by vger.kernel.org with ESMTP id S261583AbUKCNXK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 08:23:10 -0500
Date: Wed, 3 Nov 2004 14:22:43 +0100
From: Lukas Hejtmanek <xhejtman@mail.muni.cz>
To: Andrew Morton <akpm@osdl.org>
Cc: Francois Romieu <romieu@fr.zoreil.com>, linux-kernel@vger.kernel.org
Subject: Re: 2.6.9 - e1000 - page allocation failed
Message-ID: <20041103132243.GF25171@mail.muni.cz>
References: <20041021221622.GA11607@mail.muni.cz> <20041021225825.GA10844@electric-eye.fr.zoreil.com> <20041022025158.7737182c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-2
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20041022025158.7737182c.akpm@osdl.org>
X-echelon: NSA, CIA, CI5, MI5, FBI, KGB, BIS, Plutonium, Bin Laden, bomb
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 22, 2004 at 02:51:58AM -0700, Andrew Morton wrote:
> I'd be interested in knowing if this fixes it - I don't expect it will,
> because that's a zero-order allocation failure.  He's really out of memory.
> 
> The e1000 driver has a default rx ring size of 256 which seems a bit nutty:
> a back-to-back GFP_ATOMIC allocation of 256 skbs could easily exhaust the
> page allocator pools.
> 
> Probably this machine needs to increase /proc/sys/vm/min_free_kbytes.

Well is there some possiblility to solve it? I have lots of free memory (300MB)
and it still complains about not enough free memory.

I'm using this:
/sbin/sysctl -w net/core/rmem_max=8388608
/sbin/sysctl -w net/core/wmem_max=8388608
/sbin/sysctl -w net/core/rmem_default=1048576
/sbin/sysctl -w net/core/wmem_default=1048576
/sbin/sysctl -w net/ipv4/tcp_window_scaling=1
/sbin/sysctl -w net/ipv4/tcp_rmem="4096 1048576 8388608"
/sbin/sysctl -w net/ipv4/tcp_wmem="4096 1048576 8388608"
/sbin/ifconfig eth0 txqueuelen 1000

-- 
Luká¹ Hejtmánek
