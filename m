Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262268AbVEYOll@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262268AbVEYOll (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 10:41:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261365AbVEYOll
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 10:41:41 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:30605 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262268AbVEYOlh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 10:41:37 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=PEQEFTqWWyEYAgTSzJ0Sy98ehsesy2tKU+rVnvZlT19HVDOnYxmAgiz2HG4oChfqZK3MJwJF/I719Ft2FF1gNpBOkOZpAg04AmZRL8LbKRTmgU6Xp9KjlmWeHSyLIZW/BS54mM/IvEDdh1m56RInMTQl9nI8Xj4BJpXG60etO5g=
Message-ID: <a4e6962a0505250741431b7633@mail.gmail.com>
Date: Wed, 25 May 2005 09:41:35 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Pekka J Enberg <penberg@cs.helsinki.fi>
Subject: Re: v9fs: VFS superblock operations (2.0-rc6)
Cc: Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
In-Reply-To: <courier.42946C49.00007170@courier.cs.helsinki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
	 <84144f0205052400113c6f40fc@mail.gmail.com>
	 <a4e6962a0505241208214a200f@mail.gmail.com>
	 <1116996843.9580.8.camel@localhost>
	 <a4e6962a0505250455605faec9@mail.gmail.com>
	 <courier.42946C49.00007170@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/25/05, Pekka J Enberg <penberg@cs.helsinki.fi> wrote:
> >
> > Is this not the right way to use slabs?  Should I just be using
> > kmalloc/kcalloc? (Is that what you mean by drop the custom allocator?)
> 
> You can create your own slab for known fixed-size objects (your
> directory structure). Look at other filesystems for an example. They
> usually create a cache for their inode_info structs.
> 
> The problem with your approach on packet structure slab is that we
> potentially get slabs with little or no activity. You would have to
> write custom code to tear down unused slabs but now you've got something
> that clearly does not belong in filesystem code. So yes, I think you'd
> be better of using kmalloc()/kcalloc() for your packet structures.
> 

Okay, I figured that since packet buffer sizes were "mostly" fixed by
session configuration then slabs would be the way to go.  But I see
your point - I'll go ahead and convert all the packet buffers to
kmalloc during the upcoming three-day weekend and try to push out a
new release candidate early next week.

           -eric
