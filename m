Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266445AbUF3DjM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266445AbUF3DjM (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 23:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266448AbUF3DjM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 23:39:12 -0400
Received: from holomorphy.com ([207.189.100.168]:51372 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266445AbUF3DjA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 23:39:00 -0400
Date: Tue, 29 Jun 2004 20:38:41 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: Ian Molton <spyro@f2s.com>, Russell King <rmk@arm.linux.org.uk>,
       linux-arm-kernel@lists.arm.linux.org.uk, linux-kernel@vger.kernel.org
Subject: Re: A question about PROT_NONE on ARM and ARM26
Message-ID: <20040630033841.GC21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <jamie@shareable.org>, Ian Molton <spyro@f2s.com>,
	Russell King <rmk@arm.linux.org.uk>,
	linux-arm-kernel@lists.arm.linux.org.uk,
	linux-kernel@vger.kernel.org
References: <20040630024434.GA25064@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040630024434.GA25064@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 30, 2004 at 03:44:34AM +0100, Jamie Lokier wrote:
> Apparently the difference between PAGE_NONE and PAGE_READONLY, in each
> case, is that PAGE_NONE is not readable from userspace but _is_
> readable from kernel space.
> Therefore all user accesses to a PROT_NONE page will cause a fault.
> My question is: if the _kernel_ reads a PROT_NONE page, will it fault?
> It looks likely to me.
> This means that calling write() with a PROT_NONE region would succeed,
> wouldn't it?
> If so, this is a bug.  A minor bug, perhaps, but nonetheless I wish to
> document it.
> I don't know if you would be able to rearrange the pte bits so that a
> PROT_NONE page is not accessible to the kernel either.  E.g. on i386
> this is done by making PROT_NONE not set the hardware's present bit
> but a different bit, and "pte_present()" tests both of those bits to
> test the virtual present bit.

It would be a bug if copy_to_user()/copy_from_user() failed to return
errors on attempted copies to/from areas with PROT_NONE protection.

I recommend writing a testcase and submitting it to LTP. I'll follow up
with an additional suggestion.

-- wli
