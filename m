Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264640AbUHCAI0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264640AbUHCAI0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Aug 2004 20:08:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264627AbUHCAIZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Aug 2004 20:08:25 -0400
Received: from cantor.suse.de ([195.135.220.2]:24268 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264562AbUHCAIK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Aug 2004 20:08:10 -0400
Date: Tue, 3 Aug 2004 02:08:05 +0200
From: Andi Kleen <ak@suse.de>
To: Paul Jackson <pj@sgi.com>
Cc: lse-tech@lists.sourceforge.net, linux-kernel@vger.kernel.org, pj@sgi.com
Subject: Re: [PATCH] subset zonelists and big numa friendly mempolicy
 MPOL_MBIND
Message-Id: <20040803020805.060620fa.ak@suse.de>
In-Reply-To: <20040802233516.11477.10063.34205@sam.engr.sgi.com>
References: <20040802233516.11477.10063.34205@sam.engr.sgi.com>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2 Aug 2004 16:35:06 -0700 (PDT)
Paul Jackson <pj@sgi.com> wrote:

> I hope that this patch will end up in *-mm soon.

[...]

That's a *lot* of complexity and overhead you add. I hope it is really 
worth it. I suppose you need this for your cpu memset stuff, right? 
On a large machine it will be quite cache blowing too.

What's the worst case memory usage of all this?
And do you have any benchmarks that show that it is worth it?

My first reaction that if you really want to do that, just pass
the policy node bitmap to alloc_pages and try_to_free_pages
and use the normal per node zone list with the bitmap as filter. 
This way you would get the same effect with a lot less complexity
and only slightly more overhead in the fallback case.

For the simple libnuma it was still good enough to construct the 
zones without core changes, but for such complex things it is better
to attack the core of things.

-Andi
