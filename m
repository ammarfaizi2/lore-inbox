Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261243AbVAMRK7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261243AbVAMRK7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jan 2005 12:10:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261263AbVAMRKA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jan 2005 12:10:00 -0500
Received: from c-24-1-16-159.client.comcast.net ([24.1.16.159]:28888 "EHLO
	leaper.linuxtx.org") by vger.kernel.org with ESMTP id S261249AbVAMRHu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jan 2005 12:07:50 -0500
Date: Thu, 13 Jan 2005 11:07:33 -0600
From: "Justin M. Forbes" <jmforbes@linuxtx.org>
To: Raphael Jacquot <raphael.jacquot@imag.fr>
Cc: sander@humilis.net, Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Sergey S. Kostyliov" <rathamahata@ehouse.ru>
Subject: Re: NUMA or not on dual Opteron
Message-ID: <20050113170733.GA14524@linuxtx.org>
References: <Pine.LNX.4.58.0501112100250.2373@ppc970.osdl.org> <200501121824.44327.rathamahata@ehouse.ru> <Pine.LNX.4.58.0501120730490.2373@ppc970.osdl.org> <20050113094537.GB2547@favonius> <41E6472B.5020701@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41E6472B.5020701@imag.fr>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2005 at 11:02:19AM +0100, Raphael Jacquot wrote:
> >I was under the impression that NUMA is useful on > 2-way systems only.
> >Is this true, and if not, under what circumstances is NUMA useful on
> >2-way Opteron systems?
> >
> >In other words: why should one want NUMA to be enabled or disabled for
> >dual Opteron?
> >
> >Thanks in advance.
> >
> 
> Numa needs to be enabled on bi-opteron systems because each processor 
> controls part of the memory. unlike the intel memory architecture, where 
> processors share the same bus to access memory.
> Numa in opteron systems is thus required to allow sharing of memory .

This is somewhat true.  There are 2 types of dual opteron boards. Those in
the $200 US range only have one memory bank, which is attached to CPU0.
They operate as a single node, and may perform better with numa turned off.
Those in the $400+ range tend to have one bank per CPU and will certainly
perform better with numa on.  They do usually have a bios option to
interleave the nodes which would show up as a single node, and probably
perform better with numa turned off, but a better solution is to turn off
the node interleave in bios and run the kernel with numa support.
Basically if you have 2 CPUs and only one memory bank, maybe turning numa
off will give better performance, but if you have one memory bank per CPU
numa should be on.

Justin
