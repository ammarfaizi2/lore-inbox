Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261314AbTISFEd (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 01:04:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261308AbTISFEd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 01:04:33 -0400
Received: from palrel11.hp.com ([156.153.255.246]:26782 "EHLO palrel11.hp.com")
	by vger.kernel.org with ESMTP id S261309AbTISFEa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 01:04:30 -0400
Date: Thu, 18 Sep 2003 22:04:29 -0700
From: Grant Grundler <iod00d@hp.com>
To: Andi Kleen <ak@suse.de>
Cc: Peter Chubb <peterc@gelato.unsw.edu.au>, linux-ns83820@kvack.org,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: NS83820 2.6.0-test5 driver seems unstable on IA64
Message-ID: <20030919050429.GA3159@cup.hp.com>
References: <16234.33565.64383.838490@wombat.disy.cse.unsw.edu.au> <20030919043847.GA2996@cup.hp.com> <20030919044315.GC7666@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919044315.GC7666@wotan.suse.de>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 06:43:15AM +0200, Andi Kleen wrote:
> It is a mixed blessing, because the result is a non cache line 
> aligned buffer. Some NIC chipsets don't like this because they have
> to do a read-modify-write cycle for the first cache line and cannot
> burst the full packet.

yeah, that reminds me...tulip can only DMA to word aligned addresses.
I looked it up again in DEC 21143 HWREF (page 113 of the pdf):
        Table 4-3. RDES2 Bit Field Description
    Field      Description
    31:0       Buffer Address 1
               Indicates the physical address of buffer 1. 
               The buffer must be longword aligned (RDES2<1:0> = 00).

Same is true for TX/RX descriptor addresses.
Behavior is undefined if the addresses for DMA are not 4-byte aligned.

Anyone know if that's true for NS83820?
I couldn't find which driver controls that chip/NIC via a quick grep.

grant
