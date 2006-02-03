Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750746AbWBCMgn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750746AbWBCMgn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 07:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750750AbWBCMgn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 07:36:43 -0500
Received: from moutng.kundenserver.de ([212.227.126.188]:21452 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750746AbWBCMgm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 07:36:42 -0500
Date: Fri, 3 Feb 2006 13:09:25 +0100
From: Holger Eitzenberger <holger@my-eitzenberger.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Greg KH <gregkh@suse.de>, linux-kernel@vger.kernel.org, stable@kernel.org,
       torvalds@osdl.org
Subject: Re: Linux 2.6.15.2
Message-ID: <20060203120925.GA4393@kruemel.my-eitzenberger.de>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, Greg KH <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
References: <20060131070642.GA25015@kroah.com> <20060130233427.5e7912ae.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060130233427.5e7912ae.akpm@osdl.org>
User-Agent: Mutt/1.5.9i
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:8548cd0e00552bb75411ff34ad15700a
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, 2006 at 11:34:27PM -0800, Andrew Morton wrote:

> - A skbuff_head_cache leak causes oom-killings.
> 
> All of these only seem to affect a small minority of machines.

Hi,

I have searched for a description for the above mentioned bug report,
but havent found any.  Can you tell me?

The reason why I am asking that I am facing a similar problem on
kernel 2.6.10.  During performance tests (Intel XEON, SMP, PCI-X,
e1000, 2 - 4 Gig RAM) the machine was out of memory.

Tests showed that LowFree went linearly down to a few megabytes, where
most of the memory was used in skb_head_cache and size-1024 slab
caches.  These two summed up to ~270 MG, which was the reason for
that.

/proc/net/tcp showed that most of the memory was stuck in the RX
queues of some processes (two processes with ~1000 sockets each).

A look into /proc/sys/net/ipv4/tcp_mem showed that that the values in
there were way to high.  I hope that a reduction of these values will
help (not done yet).

/holger

-- 
ICQ 2882018 ++ Jabber: octavian@amessage.de ++
