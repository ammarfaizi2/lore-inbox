Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932853AbWGBTy2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932853AbWGBTy2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Jul 2006 15:54:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932841AbWGBTy2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Jul 2006 15:54:28 -0400
Received: from liaag2ab.mx.compuserve.com ([149.174.40.153]:63949 "EHLO
	liaag2ab.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S932822AbWGBTy1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Jul 2006 15:54:27 -0400
Date: Sun, 2 Jul 2006 15:51:07 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Oops / BUG? (2.6.17.2 on VIA Epia CL6000)
To: Udo van den Heuvel <udovdh@xs4all.nl>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200607021553_MC3-1-C400-31EE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <44A7AADB.8040106@xs4all.nl>

On Sun, 02 Jul 2006 13:15:39 +0200, Udo van den Heuvel wrote:

> On my otherwise stable Via EPIA CL6000 I experienced an OOPS.
> Hardware should be OK. I was unable to reproduce the event, so far.
> In what part of the kernel did things go wrong?

Your kernel stack has been overwritten with seemingly-random data.
This is impossible to diagnose -- some module possibly scribbled
over the stack.

> Process named (pid: 1431, threadinfo=dd070000 task=ddf61a90)

> EIP: [<52786fdd>] 0x52786fdd SS:ESP 0068:dd071f38

Threadinfo is at dd070000 so end-of-stack is at dd071ff8
dd071ff8 - dd071f38 = 192 (decimal) so there are 192 bytes on the
kernel stack.  We can see 192 bytes and there is no sensible regs
information at the end, just random junk.

> What can I do to help fix the bug? (if it is indeed a bug)

Where did these modules come from?

        ipt_TARPIT
        vt1211

-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
