Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129948AbRCAUxR>; Thu, 1 Mar 2001 15:53:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129981AbRCAUxI>; Thu, 1 Mar 2001 15:53:08 -0500
Received: from roc-24-95-203-215.rochester.rr.com ([24.95.203.215]:43792 "EHLO
	d185fcbd7.rochester.rr.com") by vger.kernel.org with ESMTP
	id <S129948AbRCAUwy>; Thu, 1 Mar 2001 15:52:54 -0500
Date: Thu, 01 Mar 2001 15:52:08 -0500
From: Chris Mason <mason@suse.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [CFT][PATCH] Re: fat problem in 2.4.2
Message-ID: <2593390000.983479928@tiny>
In-Reply-To: <97ma2u$840$1@penguin.transmeta.com>
X-Mailer: Mulberry/2.0.6b4 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thursday, March 01, 2001 12:05:50 PM -0800 Linus Torvalds
<torvalds@transmeta.com> wrote:

> In article <Pine.GSO.4.21.0103011345110.11577-100000@weyl.math.psu.edu>,
> Alexander Viro  <viro@math.psu.edu> wrote:
>> 
>> Alan, fix is really quite simple. Especially if you have vmtruncate()
>> returning int (ac1 used to do it, I didn't check later ones). Actually
>> just a generic_cont_expand() done on expanding path in vmtruncate()
>> will be enough - it should be OK for all cases, including normal
>> filesystems. <grabbing -ac7>
>> 
>> OK, any brave soul to test that? All I can promise that it builds.
> 
> This looks like it would create a dummy block even for non-broken
> filesystems (ie truncating a file to be larger on ext2 would create a
> block, no?). While that would work, it would also waste disk-space.

Another idea is to create the hole for new_file_size + [one block], and
then truncate that block off the end of the file, leaving nothing but the
hole.  I'll never admit to suggesting it though.

-chris

