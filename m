Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267946AbTGHXT5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 19:19:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267950AbTGHXT5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 19:19:57 -0400
Received: from air-2.osdl.org ([65.172.181.6]:14485 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267946AbTGHXTw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 19:19:52 -0400
Date: Tue, 8 Jul 2003 16:34:24 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: "Nakajima, Jun" <jun.nakajima@intel.com>
cc: linux-kernel@vger.kernel.org, "Saxena, Sunil" <sunil.saxena@intel.com>,
       "Mallick, Asit K" <asit.k.mallick@intel.com>,
       "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] idle using PNI monitor/mwait
In-Reply-To: <3014AAAC8E0930438FD38EBF6DCEB5640201719C@fmsmsx407.fm.intel.com>
Message-ID: <Pine.LNX.4.44.0307081630380.2416-100000@home.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 8 Jul 2003, Nakajima, Jun wrote:
> 
> Attached is a patch that enables PNI (Prescott New Instructions)
> monitor/mwait in kernel idle (opcodes are now public). Basically MWAIT
> is similar to hlt, but you can avoid IPI to wake up the processor
> waiting. A write (by another processor) to the address range specified
> by MONITOR would wake up the processor waiting on MWAIT.

How about spinlocks? Does it make sense to make the contention code use 
mwait too, or are the latencies too high? Not that we have a lot of 
high-contention locks any more, so maybe it doesn't much matter.

Also, wasn't there some flag to set the "mwait" granularity? I don't see 
anything like that in the patch..

		Linus


