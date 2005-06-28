Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261452AbVF1Mpp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261452AbVF1Mpp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 08:45:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261455AbVF1Mpp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 08:45:45 -0400
Received: from hellhawk.shadowen.org ([80.68.90.175]:53254 "EHLO
	hellhawk.shadowen.org") by vger.kernel.org with ESMTP
	id S261452AbVF1Mpj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 08:45:39 -0400
Message-ID: <42C14662.40809@shadowen.org>
Date: Tue, 28 Jun 2005 13:45:22 +0100
From: Andy Whitcroft <apw@shadowen.org>
User-Agent: Debian Thunderbird 1.0.2 (X11/20050602)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nick Piggin <nickpiggin@yahoo.com.au>
CC: linux-kernel <linux-kernel@vger.kernel.org>,
       Linux Memory Management <linux-mm@kvack.org>
Subject: Re: [patch 2] mm: speculative get_page
References: <42BF9CD1.2030102@yahoo.com.au> <42BF9D67.10509@yahoo.com.au> <42BF9D86.90204@yahoo.com.au>
In-Reply-To: <42BF9D86.90204@yahoo.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nick Piggin wrote:

>  #define PG_free			20	/* Page is on the free lists */
> +#define PG_freeing		21	/* PG_refcount about to be freed */

Wow this needs two new page bits.  That might be a problem ongoing.
There are only 24 of these puppies and this takes us to just two
remaining.  Do we really need _two_ to track free?

One obvious area of overlap might be the PG_nosave_free which seems to
be set on free pages for software suspend.  Perhaps that and PG_free
will be equivalent in intent (though maintained differently) and allow
us to recover a bit?

There are a couple of bits which imply ownership such as PG_slab,
PG_swapcache and PG_reserved which to my mind are all exclusive.
Perhaps those plus the PG_free could be combined into a owner field.  I
am unsure if the PG_freeing can be 'backed out' if not it may also combine?

Mumble ...

-apw
