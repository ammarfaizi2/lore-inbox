Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261407AbTIKRK6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 13:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261416AbTIKRK6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 13:10:58 -0400
Received: from amdext.amd.com ([139.95.251.1]:51671 "EHLO amdext.amd.com")
	by vger.kernel.org with ESMTP id S261407AbTIKRKy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 13:10:54 -0400
Message-ID: <99F2150714F93F448942F9A9F112634C0638B198@txexmtae.amd.com>
From: richard.brunner@amd.com
To: jamie@shareable.org
cc: linux-kernel@vger.kernel.org
Subject: RE: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
Date: Thu, 11 Sep 2003 12:09:58 -0500
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
X-WSS-ID: 137E73F57704544-01-01
Content-Type: text/plain;
 charset=iso-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If the program is doing lots of page faults to SEGV signals 
intentionally, each of those transitions (exception to-> kernel ->
process -> signal-back to user) is already pretty expensive.
I would think that the slight overhead that is_prefetch() 
adds in this case is pretty low in comparision because 
the transitions themselves are very expensive in cycles. 
Most of the time, is_prefetch should be able to tell if 
it is a prefetch from just reading the first byte 
(one memory access).

We can measure this for such programs if need be, but, I would bet
we won't see any difference.

Having said that, I'm agnostic to whether is_prefetch() 
gets compiled out for non-AMD processors. I defer to 
all the kernel experts here if that is feasible or not.


] -Rich ...
] AMD Fellow
] richard.brunner at amd com 

> -----Original Message-----
> From: Jamie Lokier [mailto:jamie@shareable.org] 
> Sent: Thursday, September 11, 2003 9:55 AM
> To: Brunner, Richard
> Cc: linux-kernel@vger.kernel.org
> Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
> 
> 
> richard.brunner@amd.com wrote:
> > Don't worry! I am pretty certain the patch won't impact the 
> > performance of the 2.6 kernel on processors from other vendors ;-)
> 
> is_prefetch() will slow down programs which depend on lots of SEGV
> signals: those garbage collectors which use mprotect and SIGSEGV to
> track dirty pages.
> 
> I wonder how much it will slow them down.
> 
> -- Jamie
> 

