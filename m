Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752800AbWKBX0a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbWKBX0a (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:26:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752789AbWKBX0a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:26:30 -0500
Received: from o-hand.com ([70.86.75.186]:60099 "EHLO o-hand.com")
	by vger.kernel.org with ESMTP id S1752800AbWKBX03 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:26:29 -0500
Subject: Re: [PATCH, RFC/T] Fix handling of write failures to swap devices
From: Richard Purdie <richard@openedhand.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Cc: kernel list <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       Hugh Dickins <hugh@veritas.com>
In-Reply-To: <45483020.9010607@yahoo.com.au>
References: <1161935995.5019.46.camel@localhost.localdomain>
	 <4541C1B2.7070003@yahoo.com.au>
	 <1161938694.5019.83.camel@localhost.localdomain>
	 <4542E2A4.2080400@yahoo.com.au>
	 <1162032227.5555.65.camel@localhost.localdomain>
	 <454348B4.60007@yahoo.com.au>
	 <1162209347.6962.2.camel@localhost.localdomain>
	 <45483020.9010607@yahoo.com.au>
Content-Type: text/plain
Date: Thu, 02 Nov 2006 23:26:10 +0000
Message-Id: <1162509970.12781.62.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2006-11-01 at 16:26 +1100, Nick Piggin wrote:
> The attached (very untested, in need of splitting up) patch attempts to
> solve these problems. Note that it is probably not going to prevent your
> SIGBUS, so that will have to be found and fixed individually.
> 
> In the meantime, I'll run this through some testing when I get half a
> chance.
> 
> plain text document attachment (mm-swap-fail.patch)
> Notice swap write errors during page reclaim, and deallocate the swap entry
> which is backing the swapcache. This allows the page error to be cleared and
> the page be allocated to a new entry, rather than the page to becoming pinned
> forever.
> 
> Based on code from Richard Purdie <richard@openedhand.com>

For reference, I've done some testing with this patch applied and as
soon as I see write errors, processes get jammed in the D state
ultimately resulting in a system lock :-(. I'll see if I can track the
problem down.

I can't seem to reproduce the page error causing bus faults under
current kernels which is strange as it definitely used to happen. I'm
suspecting some kind of broken testing environment was causing it...

Cheers,

Richard

