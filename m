Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263777AbUAPBF7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 20:05:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUAPBF7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 20:05:59 -0500
Received: from fw.osdl.org ([65.172.181.6]:20625 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S264446AbUAPBF4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 20:05:56 -0500
Date: Thu, 15 Jan 2004 17:06:24 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: joe.korty@ccur.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115170624.2851e19a.akpm@osdl.org>
In-Reply-To: <20040115145357.1033d65a.pj@sgi.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
	<20040115081533.63c61d7f.akpm@osdl.org>
	<20040115145357.1033d65a.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Andrew wrote:
> > Gad.
> 
> Could you elaborate a bit on this critique, Andrew?

The code seems very complex for such a conceptually simple problem.

And doubts remain whether it is correct on particular wordsize/endianness
machines.

It seems that there is a layering violation in which this code is poking
around inside representations which should known only to the particular
architecture.  Hence, if we can find a way to provide this function using
existing architecture API's (test_bit) then everything is solved.

If this code needs some arch-provided support function then so be it. 
That's better than adding a tangle of ifdefs in generic code.

> Did I provide too many comments?

You can never provide too many comments!

Anyway, please wake me up again when you and Joe have finished.  (I agree
that making that function take a number of bits is better than taking a
number of bytes btw).

