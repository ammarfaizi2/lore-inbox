Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261670AbTKXXcU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Nov 2003 18:32:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261683AbTKXXcU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Nov 2003 18:32:20 -0500
Received: from mtvcafw.sgi.com ([192.48.171.6]:1394 "EHLO zok.sgi.com")
	by vger.kernel.org with ESMTP id S261670AbTKXXcR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Nov 2003 18:32:17 -0500
Date: Mon, 24 Nov 2003 15:31:55 -0800
To: Andrew Morton <akpm@osdl.org>, colpatch@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com
Subject: Re: [RFC] Simplify node/zone portion of page->flags
Message-ID: <20031124233155.GA27541@sgi.com>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>, colpatch@us.ibm.com,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, mbligh@aracnet.com
References: <3FBEB867.9080506@us.ibm.com> <20031123144052.1f0d5071.akpm@osdl.org> <20031123224903.GB21617@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031123224903.GB21617@sgi.com>
User-Agent: Mutt/1.5.4i
From: jbarnes@sgi.com (Jesse Barnes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Nov 23, 2003 at 02:49:03PM -0800, Jesse Barnes wrote:
> On Sun, Nov 23, 2003 at 02:40:52PM -0800, Andrew Morton wrote:
> > >  zone_num.  This makes it trivial to recover either the node or zone 
> > >  number with a simple bitshift.  There are many places in the kernel 
> > >  where we do things like: page_zone(page)->zone_pgdat->node_id to 
> > >  determine the node a page belongs to.  With this patch we save several 
> > >  pointer dereferences, and it boils down to shifting some bits.
> > 
> > This rather conflicts with the patch from Jesse which I have.  Can you guys
> > work that out and let me know when you're done?
> 
> I like Matt's patch, but haven't tested it yet.  I'll try it out on
> Monday.

Matt, this looks ok (at least it boots on my test system).  I wasn't
able test it on a very large system though, but it looks functionally
identical to the patch in Andrew's tree.  Btw, you probably want to put
() around NODEZONE_SHIFT + ZONES_SHIFT in page_nodenum() otherwise gcc
will complain loudly.

Jesse
