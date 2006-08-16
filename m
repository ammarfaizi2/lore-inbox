Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750854AbWHPCws@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbWHPCws (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Aug 2006 22:52:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750852AbWHPCws
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Aug 2006 22:52:48 -0400
Received: from elasmtp-scoter.atl.sa.earthlink.net ([209.86.89.67]:41398 "EHLO
	elasmtp-scoter.atl.sa.earthlink.net") by vger.kernel.org with ESMTP
	id S1750848AbWHPCwr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Aug 2006 22:52:47 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk20050327; d=mindspring.com;
  b=kOT9Pz0qhldWaOgIH95DhbvzVDM43x5VaScTiF2fwtZMcWighL4LYNFRzn3+3Nq8;
  h=Received:Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:X-Mailer:Mime-Version:Content-Type:Content-Transfer-Encoding:X-ELNK-Trace:X-Originating-IP;
Date: Tue, 15 Aug 2006 22:52:37 -0400
From: Bill Fink <billfink@mindspring.com>
To: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
Cc: a.p.zijlstra@chello.nl, davem@davemloft.net, netdev@vger.kernel.org,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 1/1] network memory allocator.
Message-Id: <20060815225237.03df7874.billfink@mindspring.com>
In-Reply-To: <20060815141501.GA10998@2ka.mipt.ru>
References: <20060814110359.GA27704@2ka.mipt.ru>
	<1155558313.5696.167.camel@twins>
	<20060814123530.GA5019@2ka.mipt.ru>
	<1155639302.5696.210.camel@twins>
	<20060815112617.GB21736@2ka.mipt.ru>
	<1155643405.5696.236.camel@twins>
	<20060815123438.GA29896@2ka.mipt.ru>
	<1155649768.5696.262.camel@twins>
	<20060815141501.GA10998@2ka.mipt.ru>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; powerpc-yellowdog-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-ELNK-Trace: c598f748b88b6fd49c7f779228e2f6aeda0071232e20db4d4e88a51f60a7f78a71f2afcdfa99099d350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 68.55.21.22
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 15 Aug 2006, Evgeniy Polyakov wrote:

> On Tue, Aug 15, 2006 at 03:49:28PM +0200, Peter Zijlstra (a.p.zijlstra@chello.nl) wrote:
> 
> > It could if you can provide adequate detection of memory pressure and
> > fallback to a degraded mode within the same allocator/stack and can
> > guarantee limited service to critical parts.
> 
> It is not needed, since network allocations are separated from main
> system ones.
> I think I need to show an example here.
> 
> Let's main system works only with TCP for simplicity.
> Let's maximum allowed memory is limited by 1mb (it is 768k on machine
> with 1gb of ram).

The maximum amount of memory available for TCP on a system with 1 GB
of memory is 768 MB (not 768 KB).

[bill@chance4 ~]$ cat /proc/meminfo
MemTotal:      1034924 kB
...

[bill@chance4 ~]$ cat /proc/sys/net/ipv4/tcp_mem
98304   131072  196608

Since tcp_mem is in pages (4K in this case), maximum TCP memory
is 196608*4K or 768 MB.

Or am I missing something obvious.

						-Bill
