Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbTIKRXj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261434AbTIKRSA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:18:00 -0400
Received: from amdext2.amd.com ([163.181.251.1]:64988 "EHLO amdext2.amd.com")
	by vger.kernel.org with ESMTP id S261426AbTIKROx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:14:53 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B199@txexmtae.amd.com>
From: richard.brunner@amd.com
To: jamie@shareable.org, ak@suse.de
cc: linux-kernel@vger.kernel.org, akpm@osdl.org, torvalds@osdl.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Thu, 11 Sep 2003 12:14:21 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 137E72F92315006-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Potentially, any address can be a candidate. If you assume a sequential
access pattern for data, addresses toward the back of the cache-line
(but not the last few bytes) are less likely to hit the errata
because hopefully the page that the cacheline is in is 
already "faulted in". But that is no guarantee.


] -Rich ...
] AMD Fellow
] richard.brunner at amd com 

> -----Original Message-----
> From: Jamie Lokier [mailto:jamie@shareable.org] 
> Sent: Thursday, September 11, 2003 9:59 AM
> To: Andi Kleen
> Cc: Brunner, Richard; linux-kernel@vger.kernel.org; 
> akpm@osdl.org; torvalds@osdl.org
> Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> 
> Andi Kleen wrote:
> > +static int is_prefetch(struct pt_regs *regs, unsigned long addr)
> 
> Do I understand that certain values of "addr" can't be due to the
> erratum?
> 
> In which case, could you skip most of the is_prefetch() instruction
> decoder with a test like this?:
> 
> 	if ((addr & 3) == 0)
> 		return 0;
> 
> I'm not sure from the description of the erratum what, exactly, are
> the possible addresses which can appear in the fault information.
> 
> -- Jamie
> 

