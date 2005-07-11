Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261549AbVGKJav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261549AbVGKJav (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 05:30:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261476AbVGKJau
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 05:30:50 -0400
Received: from gw1.cosmosbay.com ([62.23.185.226]:50388 "EHLO
	gw1.cosmosbay.com") by vger.kernel.org with ESMTP id S261549AbVGKJ3K
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 05:29:10 -0400
Message-ID: <42D23BDF.8020701@cosmosbay.com>
Date: Mon, 11 Jul 2005 11:29:03 +0200
From: Eric Dumazet <dada1@cosmosbay.com>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Davide Libenzi <davidel@xmailserver.org>
Subject: Re: [PATCH] eventpoll : Suppress a short lived lock from struct	file
References: <4263275A.2020405@lab.ntt.co.jp>	 <20050418040718.GA31163@taniwha.stupidest.org>	 <4263356D.9080007@lab.ntt.co.jp>  <20050418044223.GB15002@nevyn.them.org>	 <1113800136.355.1.camel@localhost.localdomain>	 <Pine.LNX.4.58.0504172159120.28447@bigblue.dev.mdolabs.com>	 <42D21D43.3060300@cosmosbay.com> <1121070867.24086.6.camel@localhost.localdomain>
In-Reply-To: <1121070867.24086.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.6 (gw1.cosmosbay.com [172.16.8.80]); Mon, 11 Jul 2005 11:29:05 +0200 (CEST)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra a écrit :
> On Mon, 2005-07-11 at 09:18 +0200, Eric Dumazet wrote:
> 
> Have you tested the impact of this change on big SMP/NUMA machines?
> I hate to see an Altrix crashing to its knees :-)
> 

I tested on a small NUMA machine (2 nodes), with a epoll enabled application,
that use around 100 epoll ctl per second.

Of course, one may write a special benchmark on a BIG SMP/NUMA machine that
  defeat these patch, using thousands of epoll ctl per second, but, a normal (well written ?)
epoll application doesnt constantly add/remove epoll ctl.

Should we waste 8 bytes per 'struct file' for a very unlikely micro benchmark ?

Eric

