Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261888AbUKUHI6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261888AbUKUHI6 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 02:08:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261909AbUKUHI5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 02:08:57 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:32901 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261888AbUKUHIx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 02:08:53 -0500
Date: Thu, 18 Nov 2004 15:46:34 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041118144634.GA7922@openzaurus.ucw.cz>
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> > I know I've asked before... but how is the "fuse-userspace-part
> > swapped out and memory full of dirty data on fuse" deadlock solved?
> 
> By either
> 
>   1) not allowing share writable mappings 
> 
>   2) doing non-blocking asynchronous writepage
> 
> In the first case there will never be dirty data, since normal writes
> go synchronously through the page cache.

Ok, this one works, I agree... But it will be way slower than coda's
file-backed approach, right?

> In the second case there is no deadlock, because the memory subsystem
> doesn't wait for data to be written.  If the filesystem refuses to
> write back data in a timely manner, memory will get full and OOM
> killer will go to work.  Deadlock simply cannot happen.

Hmmm, so if userspace part is swapped out and data is dirtied
"too quickly", OOM is practically guaranteed? That is not nice.

What if userspave daemon is not fast enough to handle writes (going
through slow network or something), is there some mechanksm to
throttle back the writer, or will it just OOM?
				Pavel
-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

