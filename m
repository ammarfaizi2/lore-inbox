Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271715AbTHDOHF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 10:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271750AbTHDOHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 10:07:05 -0400
Received: from holomorphy.com ([66.224.33.161]:55019 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S271715AbTHDOHD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 10:07:03 -0400
Date: Mon, 4 Aug 2003 07:08:14 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, mingo@elte.hu
Subject: Re: 2.6.0-test2-mm4
Message-ID: <20030804140814.GJ32488@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, mingo@elte.hu
References: <20030804013036.16d9fa3a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030804013036.16d9fa3a.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 04, 2003 at 01:30:36AM -0700, Andrew Morton wrote:
> +4g4g-pmd-fix.patch

If you're going to back out pgd preconstruction, at least back it out
all the way so list poison isn't tripped over randomly on PAE. This is
actually worse than before, since you're basically doing list_del()
on whatever value of page->lru was handed to mm/slab.c from page_alloc.c
in pgd_dtor() multiple times per-page and pounding the lock for no
reason whatsoever on PAE. It's also degrading performance on non-PAE
due to the fact no preconstruction is done there, though harmless due
to the fact the only trace of pgd preconstruction left is the AGP fix.

Someone please tell me they realize this is a backout because absolutely
zero data structure initialization is done in ->ctor() and the entire
thing is memcpy()'d and memset()'d over in the front end to the slab.

I have no idea what, if anything has been absorbed from my prior posts
on this subject. AFAICT I'm getting dead air (or worse) back from
everyone else and no one's even bothering to read the code. i.e. either
no one understands a word I'm saying or no one's listening.


-- wli
