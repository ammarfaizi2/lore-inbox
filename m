Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUG0RZm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUG0RZm (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 13:25:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266469AbUG0RZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 13:25:42 -0400
Received: from main.gmane.org ([80.91.224.249]:16009 "EHLO main.gmane.org")
	by vger.kernel.org with ESMTP id S266477AbUG0RZX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 13:25:23 -0400
X-Injected-Via-Gmane: http://gmane.org/
Mail-Followup-To: linux-kernel@vger.kernel.org
To: linux-kernel@vger.kernel.org
From: Benjamin Rutt <rutt.4+news@osu.edu>
Subject: Re: clearing filesystem cache for I/O benchmarks
Date: Tue, 27 Jul 2004 13:25:17 -0400
Message-ID: <871xixpdky.fsf@osu.edu>
References: <87vfgeuyf5.fsf@osu.edu> <20040726002524.2ade65c3.akpm@osdl.org>
 <87pt6iq5u2.fsf@osu.edu> <20040726234005.597a94db.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Complaints-To: usenet@sea.gmane.org
Cc: Andrew Morton <akpm@osdl.org>
X-Gmane-NNTP-Posting-Host: dhcp065-025-157-254.columbus.rr.com
Mail-Copies-To: nobody
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3.50 (gnu/linux)
Cancel-Lock: sha1:FX5EbjNd01aeXuIsBEtMGG7BWmk=
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> (Please don't remove people from the email recipient list when doing kernel
> work.)

Sorry, I'm reading via gmane and my newsreader doesn't make it
straightforward to do so.  But I'll do it manually for you.

> However...  If you write any amount of data to a file with O_DIRECT, that
> will, as a side-effect, remove _all_ of that file's pagecache.  In 2.4 as
> well as 2.6.  So you could scrub the pagecache by reading the first 4k then
> writing it back with O_DIRECT.

Thanks, that does work for ext3, very well.  It's obvious that it
clears kernel page cache and not controller/disk cache.

>> A related question...if no posix_fadvise() advice has been given, does
>> reading sequentially every byte of an 8GB file on a machine with <=
>> 8GB of RAM guarantee that any page cache data that existed on the
>> machine prior to the start of the 8GB read is now gone?
>
> It's not guaranteed that this will work - if the pages which you're trying
> to evict were accessed multiple times then it may take more page
> replacement to reliably shoot them down.  But writing a 2xmemory file and
> then deleting it will be a reasonably effective way of evicting most of
> the other pagecache.

OK thanks, I'll take on good faith that this is the best scheme in
general.  I was actually doing a somewhat different approach, reading
through a 2x memory "dummy" file before accessing the real file, but
based on your advice, I'll instead just create a 2x "dummy" file,
fsync it, and then delete it.

Thanks for the tips,
-- 
Benjamin Rutt

