Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964870AbWDZUbg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964870AbWDZUbg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 16:31:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964872AbWDZUbg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 16:31:36 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:38871 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964870AbWDZUbf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 16:31:35 -0400
Date: Wed, 26 Apr 2006 13:31:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: dgc@sgi.com
cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org, npiggin@suse.de, linux-mm@kvack.org
Subject: Re: Lockless page cache test results
In-Reply-To: <20060426184945.GL5002@suse.de>
Message-ID: <Pine.LNX.4.64.0604261330310.20897@schroedinger.engr.sgi.com>
References: <20060426135310.GB5083@suse.de> <20060426095511.0cc7a3f9.akpm@osdl.org>
 <20060426174235.GC5002@suse.de> <20060426111054.2b4f1736.akpm@osdl.org>
 <Pine.LNX.4.64.0604261130450.19587@schroedinger.engr.sgi.com>
 <20060426114737.239806a2.akpm@osdl.org> <20060426184945.GL5002@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave: Can you tell us more about the tree_lock contentions on I/O that you 
have seen?

On Wed, 26 Apr 2006, Jens Axboe wrote:

> On Wed, Apr 26 2006, Andrew Morton wrote:
> > Christoph Lameter <clameter@sgi.com> wrote:
> > >
> > > On Wed, 26 Apr 2006, Andrew Morton wrote:
> > > 
> > > > OK.  That doesn't sound like something which a real application is likely
> > > > to do ;)
> > > 
> > > A real application scenario may be an application that has lots of threads 
> > > that are streaming data through multiple different disk channels (that 
> > > are able to transfer data simultanouesly. e.g. connected to different 
> > > nodes in a NUMA system) into the same address space.
> > > 
> > > Something like the above is fairly typical for multimedia filters 
> > > processing large amounts of data.
> > 
> > >From the same file?
> > 
> > To /dev/null?
> 
> /dev/null doesn't have much to do with it, other than the fact that it
> basically stresses only the input side of things. Same file is the
> interesting bit of course, as that's the the granularity of the
> tree_lock.
> 
> I haven't tested much else, I'll ask the tool to bench more files :)
> 
> -- 
> Jens Axboe
> 
> 
