Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291358AbSBGWEH>; Thu, 7 Feb 2002 17:04:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291352AbSBGWD7>; Thu, 7 Feb 2002 17:03:59 -0500
Received: from dialin-145-254-132-167.arcor-ip.net ([145.254.132.167]:3332
	"EHLO dale.home") by vger.kernel.org with ESMTP id <S291353AbSBGWDs>;
	Thu, 7 Feb 2002 17:03:48 -0500
Date: Thu, 7 Feb 2002 23:02:35 +0100
From: Alex Riesen <riesen@synopsys.com>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [reiserfs-dev] 2.5.4-pre1: zero-filled files resiserfs
Message-ID: <20020207230235.A173@steel>
Reply-To: Alex Riesen <fork0@users.sourceforge.net>
In-Reply-To: <20020207082348.A26413@riesen-pc.gr05.synopsys.com> <20020207104420.A6824@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020207104420.A6824@namesys.com>
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
tried the patch. The problem looks gone, although i've placed
the system under even some more load than before (8.9, maybe not
impressive but first time for this one).

The reiserfsck showed up some nasty looking errors:

 shrink_id_map: objectid map shrinked: used 4096, 5 blocks
 grow_id_map: objectid map expanded: used 5120, 5 blocks
 grow_id_map: objectid map expanded: used 10240, 10 blocks
 bad_leaf: block 211482 has wrong order of items
 ...more of that...
 free block count 1326452 mismatches with a correct one 1326458.
 on-disk bitmap does not match to the correct one. 1 bytes differ

"reiserfsck --rebuild-tree" cured them without visible damages for now.
There were some messages about deleted blocks, expanded objectid map,
shrinked map and one "dir 1 2 has wrong sd_size 120, has to be 152".
I can send you logs, if needed.

Does the 2.5.4-pre2 contains this patch ?

-alex


On Thu, Feb 07, 2002 at 10:44:20AM +0300, Oleg Drokin wrote:
> Hello!
>
> On Thu, Feb 07, 2002 at 08:23:48AM +0100, Alex Riesen wrote:
>
>> There were no crashes or suspicious messages on the console.
>> Nothing special in logs, and sorry, reiserfs self-debugging
>> wasn't enabled.
> Can you try the patch attached? It may not fix the thing, but
> we want to be sure (and we'll try to reproduce locally atthe same time).
> Also try to run reiserfsck --check on your reiserfs partitions.
>
> Bye,
>     Oleg

> --- linux-2.5.4-pre1/fs/reiserfs/inode.c.orig	Wed Feb  6 11:18:35 2002
> +++ linux-2.5.4-pre1/fs/reiserfs/inode.c	Wed Feb  6 11:12:08 2002
...
