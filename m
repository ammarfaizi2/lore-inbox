Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262112AbTCHR7i>; Sat, 8 Mar 2003 12:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262118AbTCHR7i>; Sat, 8 Mar 2003 12:59:38 -0500
Received: from carisma.slowglass.com ([195.224.96.167]:51467 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S262112AbTCHR7h>; Sat, 8 Mar 2003 12:59:37 -0500
Date: Sat, 8 Mar 2003 18:10:11 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@digeo.com>
Subject: Re: [PATCH] 6/6 cacheline align files_lock
Message-ID: <20030308181011.A30313@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Linus Torvalds <torvalds@transmeta.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Andrew Morton <akpm@digeo.com>
References: <20030308155456.B28797@infradead.org> <Pine.LNX.4.44.0303080801020.2954-100000@home.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0303080801020.2954-100000@home.transmeta.com>; from torvalds@transmeta.com on Sat, Mar 08, 2003 at 08:10:29AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 08, 2003 at 08:10:29AM -0800, Linus Torvalds wrote:
> So to actually fix file_lock, you need to do something else. I _think_
> that "something else" may be to make it be a per-super-block lock, since I
> think that's the only thing the f_list thing is actually used for. Then
> you should probably pass in the superblock pointer to "get_empty_filp()", 
> and _then_ you can get rid of the free list and the current global lock.

Agreed, that's what I actually though when looking into that stuff in more
detail a while ago - I just couldn't remember everything now that Martin
brought it up again.  Killing the freelist seems like a good idea anyway
(or rather keep a small list for the reserved filp that is used only
_after_ kmem_cache_alloc() failed)

