Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265977AbUHFRrL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265977AbUHFRrL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 13:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268220AbUHFRoa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 13:44:30 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.106]:34977 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S268206AbUHFRnw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 13:43:52 -0400
Date: Fri, 6 Aug 2004 11:02:33 -0700 (PDT)
From: Ram Pai <linuxram@us.ibm.com>
X-X-Sender: ram@dyn319181.beaverton.ibm.com
Reply-To: linuxram@us.ibm.com
To: Phillip Lougher <phillip@lougher.demon.co.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>, <linuxram@us.ibm.com>,
       <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       <viro@parcelfarce.linux.theplanet.co.uk>
Subject: Re: [PATCH] VFS readahead bug in 2.6.8-rc[1-3]
In-Reply-To: <4113BA65.8050901@lougher.demon.co.uk>
Message-ID: <Pine.LNX.4.44.0408061059010.12642-100000@dyn319181.beaverton.ibm.com>
Organization: IBM Linux Technology Center
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Aug 2004, Phillip Lougher wrote:

> Nick Piggin wrote:
> > Ram Pai wrote:
> > 
> >>
> >> there is a check in __do_page_cache_readahead()  that validates this.
> >> But it is still not guaranteed to work correctly against races.
> >> The filesystem has to handle such out-of-bound requests gracefully.
> >>
> >> However with Nick's fix in do_generic_mapping_read() the filesystem is 
> >> gauranteed to be called with out-of-bound index, if the file size is a 
> >> multiple of 4k. Without the fix, the filesystem might get
> >> called with out-of-bound index only in racy conditions.
> >>
> > 
> > How's this?
> > 
> 
> It doesn't work.  It correctly handles the case where *ppos is equal
> to i_size on entry to the function (and this does work for files 0, 4k
> and n * 4k in length), but it doesn't handle readahead inside the for
> loop.  The check needs to be in the for loop.


Thinking of it more.. Is it not right to leave the code as is now?

That way all filesystems that cannot handle out-of-bound index access
are forcefully made to fix it.  The filesystems anyway are not guaranteed
non-out-of-bound index access by the VFS.

RP
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

