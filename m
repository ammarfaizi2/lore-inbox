Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271089AbTHCJk5 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 05:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271104AbTHCJk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 05:40:57 -0400
Received: from mail3.ithnet.com ([217.64.64.7]:4832 "HELO
	heather-ng.ithnet.com") by vger.kernel.org with SMTP
	id S271089AbTHCJkz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 05:40:55 -0400
X-Sender-Authentification: SMTPafterPOP by <info@euro-tv.de> from 217.64.64.14
Date: Sun, 3 Aug 2003 11:40:52 +0200
From: Stephan von Krawczynski <skraw@ithnet.com>
To: Willy Tarreau <willy@w.ods.org>
Cc: marcelo@conectiva.com.br, andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: 2.4.22-pre lockups (decoded oops for pre8)
Message-Id: <20030803114052.731fae3e.skraw@ithnet.com>
In-Reply-To: <20030803072525.GB679@alpha.home.local>
References: <Pine.LNX.4.55L.0307251040240.12645@freak.distro.conectiva>
	<20030725174517.5b21116d.skraw@ithnet.com>
	<Pine.LNX.4.55L.0307251545090.14733@freak.distro.conectiva>
	<20030802142734.5df93471.skraw@ithnet.com>
	<20030803072525.GB679@alpha.home.local>
Organization: ith Kommunikationstechnik GmbH
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 3 Aug 2003 09:25:25 +0200
Willy Tarreau <willy@w.ods.org> wrote:

> Hi Stephan,
> 
> This is in remove_page_from_hash_queue() at filemap.c:114 :
>     *pprev = next;
> 
> pprev is taken from page->pprev_hash and is considered invalid here
> (4129b0fc). Assuming it has been corrupted earlier, it seems that the only
> files able to touch this either directly or indirectly are :
>   - mm/filemap.c (add_page_to_hash_queue, add_to_page_cache*)
>   - mm/shmem.c (add_to_page_cache_unique)
>   - mm/swap_state.c (idem)

>   - fs/ext3/inode.c and fs/buffer.c (find_or_create_page)

Ext3 is unlikely to be related, the box never saw ext3. Ext2 is only used on
/boot (so very unlikely, too), everything else is reiserfs.


> 
> So the problem may be narrowed down to a few files. Perhaps digging through
> the VM changes since before you had a problem will give you more clues...
> 
> Cheers,
> Willy

Thanks for commenting, the problem really is annoying because I _know_ the box
will freeze, only it takes time, this time 4 days...

Regards,
Stephan

