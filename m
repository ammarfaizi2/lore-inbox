Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269131AbUIHL5T@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269131AbUIHL5T (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 07:57:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269135AbUIHL5T
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 07:57:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:59100 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S269131AbUIHL5M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 07:57:12 -0400
From: Jeff Moyer <jmoyer@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16702.62225.57927.948523@segfault.boston.redhat.com>
Date: Wed, 8 Sep 2004 07:54:57 -0400
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org
Subject: Re: netpoll trapped question
In-Reply-To: <E1C4xuo-0005zw-00@gondolin.me.apana.org.au>
References: <E1C4xil-0005yZ-00@gondolin.me.apana.org.au>
	<E1C4xuo-0005zw-00@gondolin.me.apana.org.au>
X-Mailer: VM 7.14 under 21.4 (patch 13) "Rational FORTRAN" XEmacs Lucid
Reply-To: jmoyer@redhat.com
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
X-PCLoadLetter: What the f**k does that mean?
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

==> Regarding Re: netpoll trapped question; Herbert Xu <herbert@gondor.apana.org.au> adds:

herbert> Herbert Xu <herbert@gondor.apana.org.au> wrote:
>> Jeff Moyer <jmoyer@redhat.com> wrote:
>>>
mpm> Yes, true. But we're still in trouble if we have nic irq handler ->
mpm> take private lock -> printk -> netconsole -> nic irq handler -> take
mpm> private lock. See?
>>> Okay, so that one has to be addressed on a per-driver basis.  There's
>>> no way for us to detect that situation.  And how do drivers address
>>> this?  Simply don't printk inside the lock?  I think that's reasonable.

>> Why not queue the message whenever you're in IRQ context, and only print
>> when you are not?

This question has been answered before.  We don't want to defer the output
of say an oops or panic message, since we may never get back to process
context.

herbert> Actually how can this happen at all? The IRQ handler should've
herbert> disabled local IRQs which prevents the second handler from
herbert> occuring.

The netpoll infrastructure calls into the device's netpoll routine.  This
will, in turn, call the interrupt routine for the device.

-Jeff
