Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263795AbUGADff@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263795AbUGADff (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 23:35:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263802AbUGADff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 23:35:35 -0400
Received: from holomorphy.com ([207.189.100.168]:25012 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S263795AbUGADfX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 23:35:23 -0400
Date: Wed, 30 Jun 2004 20:35:18 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Jamie Lokier <jamie@shareable.org>
Cc: linux-kernel@vger.kernel.org, Michael Kerrisk <michael.kerrisk@gmx.net>
Subject: Re: Testing PROT_NONE and other protections, and a surprise
Message-ID: <20040701033518.GT21066@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Jamie Lokier <jamie@shareable.org>, linux-kernel@vger.kernel.org,
	Michael Kerrisk <michael.kerrisk@gmx.net>
References: <20040630024434.GA25064@mail.shareable.org> <20040630033841.GC21066@holomorphy.com> <20040701032606.GA1564@mail.shareable.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040701032606.GA1564@mail.shareable.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III wrote:
>> It would be a bug if copy_to_user()/copy_from_user() failed to return
>> errors on attempted copies to/from areas with PROT_NONE protection.
>> I recommend writing a testcase and submitting it to LTP. I'll follow up
>> with an additional suggestion.

On Thu, Jul 01, 2004 at 04:26:06AM +0100, Jamie Lokier wrote:
> I've just written a thorough test.  The attached program tries every
> combination of PROT_* flags, and tells you what protection you really get.
> I don't know how tests get into LTP; perhaps I can leave that to you?
> When running it on i386, I got a *huge* surprise (to me).  A
> PROT_WRITE-only page can sometimes fault on read or exec.  This is the
> output:

This is unsurprising. The permissions can't be represented in pagetables,
but can opportunistically be enforced when exceptions are taken for other
reasons (e.g. TLB invalidations related to page replacement).


-- wli
