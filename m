Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265110AbUAOQQZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Jan 2004 11:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265128AbUAOQQZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Jan 2004 11:16:25 -0500
Received: from fw.osdl.org ([65.172.181.6]:29675 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265110AbUAOQQX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Jan 2004 11:16:23 -0500
Date: Thu, 15 Jan 2004 08:15:33 -0800
From: Andrew Morton <akpm@osdl.org>
To: Paul Jackson <pj@sgi.com>
Cc: joe.korty@ccur.com, paulus@samba.org, linux-kernel@vger.kernel.org
Subject: Re: seperator error in __mask_snprintf_len
Message-Id: <20040115081533.63c61d7f.akpm@osdl.org>
In-Reply-To: <20040114204009.3dc4c225.pj@sgi.com>
References: <20040107165607.GA11483@rudolph.ccur.com>
	<20040107113207.3aab64f5.akpm@osdl.org>
	<20040108051111.4ae36b58.pj@sgi.com>
	<16381.57040.576175.977969@cargo.ozlabs.ibm.com>
	<20040108225929.GA24089@tsunami.ccur.com>
	<16381.61618.275775.487768@cargo.ozlabs.ibm.com>
	<20040114150331.02220d4d.pj@sgi.com>
	<20040115002703.GA20971@tsunami.ccur.com>
	<20040114204009.3dc4c225.pj@sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Jackson <pj@sgi.com> wrote:
>
> Ok - here is a patch that should fix lib/mask.c displaying and parsing
>  cpumasks for 64 bit big endian architectures.

Gad.

> + * This layout of masks is determined by the macros in bitops.h,
> + * which pre-date masks.  The bitop operations were formalized
> + * before the mask data type to which they apply.

So why not simply iterate across it with test_bit()?

	val = 0;
	for (bit = maskbytes * 8; bit >= 0; bit--) {
		val <<= 1;
		if (__test_bit(maskp, bit))
			val |= 1;
		if ((bit & 15) == 15) {
			sprintf(buf, "%x", val);
			buf++;
			val = 0;
		}
	}

(plus bounds checking, null-termination, etc)?  It is hardly
performance-critical.


