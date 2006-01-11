Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751533AbWAKRUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751533AbWAKRUo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:20:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751682AbWAKRUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:20:44 -0500
Received: from mx.pathscale.com ([64.160.42.68]:10925 "EHLO mx.pathscale.com")
	by vger.kernel.org with ESMTP id S1751533AbWAKRUn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:20:43 -0500
Subject: Re: [PATCH 1 of 3] Introduce __raw_memcpy_toio32
From: "Bryan O'Sullivan" <bos@pathscale.com>
To: Andrew Morton <akpm@osdl.org>
Cc: hch@infradead.org, rdreier@cisco.com, sam@ravnborg.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060110153257.1aac5370.akpm@osdl.org>
References: <patchbomb.1136579193@eng-12.pathscale.com>
	 <d286502c3b3cd6bcec7b.1136579194@eng-12.pathscale.com>
	 <20060110011844.7a4a1f90.akpm@osdl.org> <adaslrw3zfu.fsf@cisco.com>
	 <1136909276.32183.28.camel@serpentine.pathscale.com>
	 <20060110170722.GA3187@infradead.org>
	 <1136915386.6294.8.camel@serpentine.pathscale.com>
	 <20060110175131.GA5235@infradead.org>
	 <1136915714.6294.10.camel@serpentine.pathscale.com>
	 <20060110140557.41e85f7d.akpm@osdl.org>
	 <1136932162.6294.31.camel@serpentine.pathscale.com>
	 <20060110153257.1aac5370.akpm@osdl.org>
Content-Type: text/plain
Date: Wed, 11 Jan 2006 09:20:32 -0800
Message-Id: <1137000032.11245.11.camel@camp4.serpentine.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-01-10 at 15:32 -0800, Andrew Morton wrote:

> Unless someone can think of a problem with attribute(weak), I think you'll
> find that it's the simplest-by-far solution.

The only problem I can see with this is that on x86_64 and other
platforms that reimplement the routine as an inline function, I think
we'll be left with a small hunk of dead code in the form of the
out-of-line version in lib/ that never gets referenced.

Is this something people care about?  If so, I could turn the config
setting in my last patch on its head, and use it to indicate that the
routine should *not* be built for a particular arch.  This would make
lib/Makefile slightly uglier, but would avoid cluttering every other
arch's lib/Makefile and Kconfig file.

	<b

