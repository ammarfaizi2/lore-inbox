Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265575AbUAIAYN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 19:24:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265625AbUAIAYM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 19:24:12 -0500
Received: from ozlabs.org ([203.10.76.45]:7084 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265575AbUAIAYK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 19:24:10 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16381.61618.275775.487768@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jan 2004 11:07:14 +1100
From: Paul Mackerras <paulus@samba.org>
To: joe.korty@ccur.com
Cc: Paul Jackson <pj@sgi.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
In-Reply-To: <20040108225929.GA24089@tsunami.ccur.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty writes:

> I believe he wants the commas to group the digits by at most eight
> irrespective of architecture.  Which seems reasonable.

Ah, ok, that makes sense.  I guess we need a BITMAP_WORD macro which
looks like this on big-endian 64-bit systems:

#define BITMAP_WORD(p, n)	(((u32 *)(p))[(n) ^ 1])

and this on other systems:

#define BITMAP_WORD(p, n)	(((u32 *)(p))[(n)])

or something like that...

Paul.
