Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261299AbTISEnS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 00:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261294AbTISEnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 00:43:18 -0400
Received: from ns.suse.de ([195.135.220.2]:51392 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261296AbTISEnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 00:43:16 -0400
Date: Fri, 19 Sep 2003 06:43:15 +0200
From: Andi Kleen <ak@suse.de>
To: Grant Grundler <iod00d@hp.com>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030919044315.GC7666@wotan.suse.de>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au> <20030919043847.GA2996@cup.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919043847.GA2996@cup.hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 18, 2003 at 09:38:47PM -0700, Grant Grundler wrote:
> On Fri, Sep 19, 2003 at 02:16:29PM +1000, Peter Chubb wrote:
> > The obvious approach of realigning the SKB by 2 bytes seems not to
> > work.
> 
> Could you be more detailed about the "obvious approach"?
> ie show the diff of what you changed.
> 
> Several other NIC driver "alias" (as davidm describes it) the buffer
> by reserving two bytes at the beginning of the recieve buffer
> where header and payload data are DMAd on inbound traffic.

It is a mixed blessing, because the result is a non cache line 
aligned buffer. Some NIC chipsets don't like this because they have
to do a read-modify-write cycle for the first cache line and cannot
burst the full packet.

-Andi
