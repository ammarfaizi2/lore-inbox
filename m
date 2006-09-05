Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750988AbWIEKUV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbWIEKUV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Sep 2006 06:20:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751281AbWIEKUV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Sep 2006 06:20:21 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:29312 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S1750988AbWIEKUS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Sep 2006 06:20:18 -0400
X-Sasl-enc: jn1fJnV9Y2YMn4gc/YSuYFm5mnc5HH1lGUQqDuK7tmGY 1157451617
Subject: Re: [PATCH 0/7] Permit filesystem local caching and NFS superblock
	sharing [try #13]
From: Ian Kent <raven@themaw.net>
To: David Howells <dhowells@redhat.com>
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>,
       Andrew Morton <akpm@osdl.org>, torvalds@osdl.org, steved@redhat.com,
       linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
       nfsv4@linux-nfs.org, linux-kernel@vger.kernel.org
In-Reply-To: <3698.1157449249@warthog.cambridge.redhat.com>
References: <1157436412.3915.26.camel@raven.themaw.net>
	 <20060901195009.187af603.akpm@osdl.org>
	 <20060831102127.8fb9a24b.akpm@osdl.org>
	 <20060830135503.98f57ff3.akpm@osdl.org>
	 <20060830125239.6504d71a.akpm@osdl.org>
	 <20060830193153.12446.24095.stgit@warthog.cambridge.redhat.com>
	 <27414.1156970238@warthog.cambridge.redhat.com>
	 <9849.1157018310@warthog.cambridge.redhat.com>
	 <9534.1157116114@warthog.cambridge.redhat.com>
	 <20060901093451.87aa486d.akpm@osdl.org>
	 <1157130044.5632.87.camel@localhost>
	 <28945.1157370732@warthog.cambridge.redhat.com>
	 <1157376295.3240.13.camel@raven.themaw.net>
	 <1157421445.5510.13.camel@localhost>
	 <1157424937.3002.4.camel@raven.themaw.net>
	 <1157428241.5510.72.camel@localhost>
	 <1157429030.3915.8.camel@raven.themaw.net>
	 <1157432039.32412.37.camel@localhost>
	 <3698.1157449249@warthog.cambridge.redhat.com>
Content-Type: text/plain
Date: Tue, 05 Sep 2006 18:20:11 +0800
Message-Id: <1157451611.4133.22.camel@raven.themaw.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-09-05 at 10:40 +0100, David Howells wrote:
> Ian Kent <raven@themaw.net> wrote:
> 
> > autofs v4 doesn't rely on mkdir never returning EACCESS just that it
> > return EEXIST if the directory exists. Never the less if the behavior of
> > stat will work in this case I'll change v4 to do it the way you suggest
> > (as v5 does already). 
> 
> As long as you don't rely on stat...mkdir working.  That can go wrong if the
> dentry gets booted from the dcache by memory pressure in the "...".

I'm not clear on your point here.

If I stat a path and it exists then all is good and I'm done.
If I stat a path and I get something other than ENOENT then all is bad
and I return fail.
Otherwise I can just attempt to create the directory and fail if all is
bad with that.

This approach works in the current situation and would work for the
other situations in which that same process is used, not just for NFS
filesystems.

> 
> David
> -
> To unsubscribe from this list: send the line "unsubscribe linux-fsdevel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

