Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267664AbUHJVli@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267664AbUHJVli (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Aug 2004 17:41:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267756AbUHJVin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Aug 2004 17:38:43 -0400
Received: from jade.spiritone.com ([216.99.193.136]:25814 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267753AbUHJVgt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Aug 2004 17:36:49 -0400
Date: Mon, 09 Aug 2004 07:49:47 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Paul Jackson <pj@sgi.com>
cc: akpm@osdl.org, hch@infradead.org, steiner@sgi.com, jbarnes@sgi.com,
       sylvain.jeaugey@bull.net, djh@sgi.com, linux-kernel@vger.kernel.org,
       colpatch@us.ibm.com, Simon.Derr@bull.net, ak@suse.de,
       lse-tech@lists.sourceforge.net, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] new bitmap list format (for cpusets)
Message-ID: <2558220000.1092062986@[10.10.2.4]>
In-Reply-To: <20040809010106.70e74f4b.pj@sgi.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com><250840000.1091738840@flay> <20040809010106.70e74f4b.pj@sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--Paul Jackson <pj@sgi.com> wrote (on Monday, August 09, 2004 01:01:06 -0700):

> I was looking at this bitmap list format patch over the weekend, and
> came to the conclusion that the basic list format, as in the example:
> 
> 	0,3,5,8-15
> 
> was a valuable improvement over a fixed length hex mask, but that on the
> other hand the support for:
> 
> 	the prefix characters '=', '-', '+', or '!'
> 
> was fluff, that few would learn to use, and fewer find essential.

OK, that looks a lot more palletable ;-)

Question:  it looks like you're only parsing on the read-side to me (which
is good, since it's highly unlikely to break anything existant), but the
function bitmap_scnlistprintf is still in there - is that needed? I can't
see any callers, but I might be missing one? I guess it might be for your
other patch, but it'd seem to make the parsing a whole lot more complicated
in userspace for the reader if we did use that ...

It looks like cpulist_scnprintf calls __cpulist_scnprintf, which just calls
bitmap_scnlistprintf, but nobody calls either of the former 2 ... ditto for
nodelist_scnprintf.

M.

PS. Similarly, do we really need both cpumask_parse and __cpumask_parse
in front of bitmap_parse? One seems to make sense for abstracting the generic
parse routine, but 2 seems like overkill ;-) (yeah, I know that was there
before this patch ... just seems odd).
