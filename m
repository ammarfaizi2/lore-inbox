Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266217AbUHLE7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266217AbUHLE7X (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 00:59:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268381AbUHLE7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 00:59:23 -0400
Received: from pfepb.post.tele.dk ([195.41.46.236]:22604 "EHLO
	pfepb.post.tele.dk") by vger.kernel.org with ESMTP id S266217AbUHLE7V
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 00:59:21 -0400
Date: Thu, 12 Aug 2004 07:01:36 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: "David S. Miller" <davem@redhat.com>
Cc: torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH]: __crc_* symbols in System.map
Message-ID: <20040812050136.GA7246@mars.ravnborg.org>
Mail-Followup-To: "David S. Miller" <davem@redhat.com>,
	torvalds@osdl.org, akpm@osdl.org, linux-kernel@vger.kernel.org
References: <20040811205529.1ff86e9d.davem@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040811205529.1ff86e9d.davem@redhat.com>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 11, 2004 at 08:55:29PM -0700, David S. Miller wrote:
> 
> Shouldn't we be grepping these things out of the System.map file?
> 
> For one thing, these can confuse readprofile.  It's algorithm is
> to start at _stext, then stop when it sees a line in the System.map
> which is not text (mode is one of 'T' 't' 'W' or 'w')
> 
> It will exit early if there are some intermixed __crc_* things in
> there (since they are are mode 'A').
> 
> For example, in my current sparc64 kernel I have this:
> 
> 00000000004cef80 t do_split
> 00000000004cf2a0 t add_dirent_to_buf
> 00000000004cf5a7 A __crc_init_special_inode
> 00000000004cf640 t make_indexed_dir
> 00000000004cf900 t ext3_add_entry
> 
> So no symbols after add_dirent_to_buf will be shown in the profiling
> output of readprofile.
> 
> So we should grep them out, right?  If so, here is a patch which
> implements that.

I have a patch in this area pending, it moves System.map generation
out of the top-level makefile. And btw simplifies the expression a bit.

iMy patches are only at linux-sam.bkbits.net/kbuild for now,
will post patches later this week.

Would it be an option to skip all 'A' symbols?

	Sam
