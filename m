Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272162AbTHRSZc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 14:25:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272223AbTHRSZc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 14:25:32 -0400
Received: from kinesis.swishmail.com ([209.10.110.86]:30476 "HELO
	kinesis.swishmail.com") by vger.kernel.org with SMTP
	id S272162AbTHRSZb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 14:25:31 -0400
Message-ID: <3F411DD7.10606@techsource.com>
Date: Mon, 18 Aug 2003 14:41:27 -0400
From: Timothy Miller <miller@techsource.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020823 Netscape/7.0
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Peter Kjellerstedt <peter.kjellerstedt@axis.com>
CC: "'Daniel Forrest'" <forrest@lmcg.wisc.edu>,
       "'Willy Tarreau'" <willy@w.ods.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: generic strncpy - off-by-one error
References: <D069C7355C6E314B85CF36761C40F9A42E20BE@mailse02.se.axis.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Peter Kjellerstedt wrote:

> For unaligned source or destination the "Multi copy & fill" 
> would degenerate into "Multi byte fill". However, for
> architectures like ix86 and CRIS that can do unaligned long
> access, it would be a win to remove the UNALIGNED() check,
> and use long word copying all the time.

In fact, it's possible to do the copy even if the source and dest are 
not aligned.  It requires holding pieces of source in a register and 
doing shifts.  If the CPU is much faster than the memory, this can be a 
huge win.


> Then whether using memset() or your filling is a win depends
> on the architecture and how many bytes needs to be filled.
> For a slow processor with little function call overhead (like
> CRIS), using memset seems to be a win almost immediately.
> However, for a fast processor like my P4, the call to memset
> is not a win until some 1500 bytes need to be filled.

What is in memset that isn't in the fill code I suggested?


