Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263723AbUAOWyN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 17:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263734AbUAOWyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 17:54:13 -0500
Received: from tolkor.sgi.com ([198.149.18.6]:6328 "EHLO tolkor.sgi.com")
	by vger.kernel.org with ESMTP id S263723AbUAOWyJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 17:54:09 -0500
Date: Thu, 15 Jan 2004 14:53:57 -0800
From: Paul Jackson <pj@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: joe.korty@ccur.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115145357.1033d65a.pj@sgi.com>
In-Reply-To: <20040115081533.63c61d7f.akpm@osdl.org>
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
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew wrote:
> Gad.

Could you elaborate a bit on this critique, Andrew?

You sketch an alternative, that loops by bit, with an sprintf each
nibble, instead of looping by u32 word.  By the time that alternative is
fancied up to handle (optionally) suppression of leading zero words and
(vital, for very long masks) a 32-bit word separator, and various other
details, I doubt that it will be any simpler than the corresponding bit
of code in my patch:

        int i = maskbytes/sizeof(u32) - 1;
        int len = 0;
        char *sep = "";

        while (i >= 1 && wordp[M32X(i)] == 0)
                i--;
        while (i >= 0) {
                len += snprintf(buf+len, buflen-len,
                        "%s%x", sep, wordp[M32X(i)]);
                sep = ",";
                i--;
        }

I am at a loss to understand why the above u32 loop version of this code
is so much worse that it only merits a "Gad".

Did I provide too many comments?


> It is hardly performance-critical.

I quite agree on that.  One thing I _do_ try to optimize in most code is
the number of "fussy details".  The few operations, conditions, special
cases, and such, the better, given the finite limits of human brain power.

-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
