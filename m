Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262132AbUC1Rhw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:37:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbUC1Rhv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:37:51 -0500
Received: from mail.shareable.org ([81.29.64.88]:59794 "EHLO
	mail.shareable.org") by vger.kernel.org with ESMTP id S262244AbUC1Rge
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:36:34 -0500
Date: Sun, 28 Mar 2004 18:36:23 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
Message-ID: <20040328173623.GA1087@mail.shareable.org>
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org> <40670A36.3000005@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <40670A36.3000005@pobox.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik wrote:
> >Does TCQ-on-write allow you to do ordered write commits, as with barriers,
> >but without needing full cache flushes, and still get good performance?
> 
> Nope, TCQ is just a bunch of commands rather than one.  There are no 
> special barrier indicators you can pass down with a command.

I meant without barrier indicators (although that would've been nice).

This is what I mean: turn off write cacheing, and performance on PATA
drops because of the serialisation and lost inter-command time.

With TCQ-on-write, you can turn off write cacheing and in theory
performance doesn't have to drop, is that right?

In addition, you can implement ordered writes by waiting until
"before" writes in a partial order are completed prior to sending
"after" writes to the drive.  Meanwhile, because of the TCQ, other
read and write transactions can continue to take place, even if the
disk takes a long time to commit those writes that you're waiting on.

I'm wondering if that sort of strategy gives good performance with
TCQ-on-write drives, so that full-cache-flush barrier commands aren't
useful.

-- Jamie
