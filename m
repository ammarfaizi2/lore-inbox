Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262632AbUKLV6Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262632AbUKLV6Q (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 16:58:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262639AbUKLV6P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 16:58:15 -0500
Received: from msgbas1tx.cos.agilent.com ([192.25.240.37]:60146 "EHLO
	msgbas2x.cos.agilent.com") by vger.kernel.org with ESMTP
	id S262636AbUKLV5K convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 16:57:10 -0500
X-MimeOLE: Produced By Microsoft Exchange V6.0.6603.0
content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Subject: RE: [PATCH] handle quoted module parameters
Date: Fri, 12 Nov 2004 14:57:05 -0700
Message-ID: <08A354A3A9CCA24F9EE9BE13600CFBC50F85D4@wcosmb07.cos.agilent.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH] handle quoted module parameters
Thread-Index: AcTI75qusDE/FpZzTpae0/COz5jNqQAEq7HA
From: <yiding_wang@agilent.com>
To: <doogie@debian.org>, <yiding_wang@agilent.com>
Cc: <rddunlap@osdl.org>, <arjan@infradead.org>, <linux-kernel@vger.kernel.org>,
       <rusty@rustcorp.com.au>, <akpm@osdl.org>
X-OriginalArrivalTime: 12 Nov 2004 21:57:05.0817 (UTC) FILETIME=[8C89B890:01C4C902]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>There is *no* difference between:
>foo="111 222 333"\ 444' 555'
>and
>foo='111 222 333 444 555'
>and
>foo="111 222 333 444 555'

But there is a difference between foo="111 222 333" and "foo=111 222 333". The new patch is changing from former to later.

Eddie


-----Original Message-----
From: Adam Heath [mailto:doogie@debian.org]
Sent: Friday, November 12, 2004 11:41 AM
To: yiding_wang@agilent.com
Cc: rddunlap@osdl.org; arjan@infradead.org;
linux-kernel@vger.kernel.org; rusty@rustcorp.com.au; akpm@osdl.org
Subject: RE: [PATCH] handle quoted module parameters


On Fri, 12 Nov 2004,  wrote:

> Hello Randy,
>
> Thanks for your two responses!
>
> Based on your patch, the format of argument will be changed from standard format before:
> Used to be:
> modprm1=first,ext modprm2=second,ext modprm3="third1,ext third2,ext"
> where the quotation in modprm3 represents the whole string, including space, to be the value of third parameter modprm3.
>
> Now the patch changes modprm3 to "modprm3=third1,ext third2,ext" which equivalent to putting quotation mark on normal parameter define "modprm1=first,ext". Do you think linux community will take that change?
>
> Another question is the parameter length is not limited in 2.4.x kernel. Why this is restricted under 2.6.x. (param_set_charp())?

Er, no, that's a wrong assumption.

Quoting like this is handled by the shell.  It tells it how to parse the
single cmdline string, into separate parts.

There is *no* difference between:

foo="111 222 333"\ 444' 555'

and

foo='111 222 333 444 555'

and

foo="111 222 333 444 555'

