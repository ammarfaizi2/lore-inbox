Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262192AbVEYLzp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262192AbVEYLzp (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 May 2005 07:55:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262279AbVEYLzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 May 2005 07:55:44 -0400
Received: from wproxy.gmail.com ([64.233.184.207]:29199 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262192AbVEYLzg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 May 2005 07:55:36 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=aYi5WQvJMThHB+vSCGwb+DmQnv55/RpBF93jiL9aqaYyat338H8cyKKTiFzDxeBy0IiD85H0LvBDtu8ptr4af53/gtZxpO3ePqEMnz9VhG6ItI0i1BWdjq3WhoDnfbhI+VDZd9sFPzQl6c9c+YeGy2bCSdxWrdyAbrJEQhNwf8Q=
Message-ID: <a4e6962a0505250455605faec9@mail.gmail.com>
Date: Wed, 25 May 2005 06:55:34 -0500
From: Eric Van Hensbergen <ericvh@gmail.com>
Reply-To: Eric Van Hensbergen <ericvh@gmail.com>
To: Pekka Enberg <penberg@cs.helsinki.fi>
Subject: Re: [RFC][patch 4/7] v9fs: VFS superblock operations (2.0-rc6)
Cc: Pekka Enberg <penberg@gmail.com>, linux-kernel@vger.kernel.org,
       v9fs-developer@lists.sourceforge.net,
       viro@parcelfarce.linux.theplanet.co.uk, linux-fsdevel@vger.kernel.org
In-Reply-To: <1116996843.9580.8.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200505232225.j4NMPte1029529@ms-smtp-02-eri0.texas.rr.com>
	 <84144f0205052400113c6f40fc@mail.gmail.com>
	 <a4e6962a0505241208214a200f@mail.gmail.com>
	 <1116996843.9580.8.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/24/05, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> 
> Most subsystems also implement this (a custom allocator for tracking
> memory leaks) so, yes, I think it's generally useful. However, adding
> yet another custom allocator is not the way to go. Perhaps some of the
> fs developers could cue in here to talk about how they track memory
> leaks? Pretty please?
> 
> In the meantime, please drop the custom allocator from your code.
> 

Well, I'm not using slabs as a custom allocator just to track leaks. 
I'm using them for two specific structures which end up getting
allocated and freed quite often (which is what I thought slab
allocators were for).  The two structures I'm slab allocating are the
directory structure (which has a fixed size), and the packet structure
(which has a fixed size per session, and may grow or shrink based on
protocol negotiation/command-line options).  I use the find_slab
routine to see if there is a slab (that I created) that already
matches the protocol negotiated size so I don't create a
slab-per-session unnecessarily.

Is this not the right way to use slabs?  Should I just be using
kmalloc/kcalloc? (Is that what you mean by drop the custom allocator?)

Sorry if I'm being dense, just want to make sure I understand what you
are saying.

         -eric
