Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262953AbVAFRzB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262953AbVAFRzB (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jan 2005 12:55:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262957AbVAFRvo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jan 2005 12:51:44 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:27352 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S262954AbVAFRrV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jan 2005 12:47:21 -0500
Date: Thu, 6 Jan 2005 09:47:08 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: Prezeroing V3 [2/4]: Extension of clear_page to take an order
 parameter
In-Reply-To: <m1652awtp7.fsf@muc.de>
Message-ID: <Pine.LNX.4.58.0501060943002.16240@schroedinger.engr.sgi.com>
References: <B8E391BBE9FE384DAA4C5C003888BE6F02900FBD@scsmsx401.amr.corp.intel.com>
 <41C20E3E.3070209@yahoo.com.au> <Pine.LNX.4.58.0412211154100.1313@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231119540.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231132170.31791@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0412231133130.31791@schroedinger.engr.sgi.com>
 <Pine.GSO.4.61.0501011123550.27452@waterleaf.sonytel.be>
 <Pine.LNX.4.58.0501041510430.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501041513330.1536@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0501051524020.9911@schroedinger.engr.sgi.com> <m1652awtp7.fsf@muc.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Jan 2005, Andi Kleen wrote:

> Christoph Lameter <clameter@sgi.com> writes:
>
> > Here is an updated version that is independent of the first patch and
> > contains all the necessary modifications to make clear_page take a second
> > parameter.
>
> I still think the clear_page order addition is completely pointless,
> because for > order 0 you probably want a cache bypassing store
> in a separate function.

I would think that having clear_page avoid loading cache
lines from memory should be general improvement.

Bypassing the cache may be beneficial for clear_page in general but I
would like to test that first.

If this is not a win then it may be better to implement the bypassing the
cache through a zero driver.

> Removing it would also make the patch much less intrusive.

Right. I also thought about that. I will likely offer the clear_page patch
as an optional component in V4. Being able to specify an order with
clear_page also helps in other situations like clearing huge pages.

