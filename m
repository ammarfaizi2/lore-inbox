Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750807AbVJWXkV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750807AbVJWXkV (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 23 Oct 2005 19:40:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbVJWXkU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 23 Oct 2005 19:40:20 -0400
Received: from lucidpixels.com ([66.45.37.187]:30893 "EHLO lucidpixels.com")
	by vger.kernel.org with ESMTP id S1750807AbVJWXkU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 23 Oct 2005 19:40:20 -0400
Date: Sun, 23 Oct 2005 19:40:19 -0400 (EDT)
From: Justin Piszcz <jpiszcz@lucidpixels.com>
X-X-Sender: jpiszcz@p34
To: Nathan Scott <nathans@sgi.com>
cc: linux-xfs@oss.sgi.com, linux-kernel@vger.kernel.org,
       debian-user@lists.debian.org
Subject: Re: xfs_db -c frag -r /dev/hda1 - Segmentation fault
In-Reply-To: <20051024085451.C5863161@wobbly.melbourne.sgi.com>
Message-ID: <Pine.LNX.4.64.0510231940140.5116@p34>
References: <4080C826.F4C53CD@dmministries.org> <Pine.LNX.4.64.0510230736490.30489@p34>
 <20051024085451.C5863161@wobbly.melbourne.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, I will give this a try.


On Mon, 24 Oct 2005, Nathan Scott wrote:

> On Sun, Oct 23, 2005 at 07:39:34AM -0400, Justin Piszcz wrote:
>> p34:~# xfs_db -c frag -r /dev/hda1
>> Segmentation fault
>> p34:~# xfs_db -c frag -r /dev/hde1
>> Segmentation fault
>> p34:~# xfs_db -c frag -r /dev/hdk1
>> Segmentation fault
>> p34:~#
>>
>> Debian Etch, 2.6.13.4, stopped working a while ago, either before newer
>> debian packages or a newer kernel, does anyone who uses Debian+XFS have
>> this problem as well?
>
> I see it too - this looks like an endian issue in xfs_db, this patch
> should fix it (Works For Me).
>
> cheers.
>
> -- 
> Nathan
>
>
> Index: xfsprogs/db/frag.c
> ===================================================================
> --- xfsprogs.orig/db/frag.c
> +++ xfsprogs/db/frag.c
> @@ -294,7 +294,7 @@ process_exinode(
> 	xfs_bmbt_rec_32_t	*rp;
>
> 	rp = (xfs_bmbt_rec_32_t *)XFS_DFORK_PTR(dip, whichfork);
> -	process_bmbt_reclist(rp, XFS_DFORK_NEXTENTS(dip, whichfork), extmapp);
> +	process_bmbt_reclist(rp, XFS_DFORK_NEXTENTS_HOST(dip, whichfork), extmapp);
> }
>
> static void
> @@ -305,7 +305,7 @@ process_fork(
> 	extmap_t	*extmap;
> 	int		nex;
>
> -	nex = XFS_DFORK_NEXTENTS(dip, whichfork);
> +	nex = XFS_DFORK_NEXTENTS_HOST(dip, whichfork);
> 	if (!nex)
> 		return;
> 	extmap = extmap_alloc(nex);
>
>
