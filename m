Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319465AbSIGLMD>; Sat, 7 Sep 2002 07:12:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319468AbSIGLMD>; Sat, 7 Sep 2002 07:12:03 -0400
Received: from dsl-213-023-038-028.arcor-ip.net ([213.23.38.28]:12984 "EHLO
	starship") by vger.kernel.org with ESMTP id <S319465AbSIGLMD>;
	Sat, 7 Sep 2002 07:12:03 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>, Linus Torvalds <torvalds@transmeta.com>
Subject: Re: One more bio for for floppy users in 2.5.33..
Date: Sat, 7 Sep 2002 13:18:35 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Suparna Bhattacharya <suparna@in.ibm.com>, Jens Axboe <axboe@suse.de>,
       linux-kernel@vger.kernel.org
References: <3D779BAA.BAA5A742@zip.com.au> <Pine.LNX.4.33.0209051120100.1307-100000@penguin.transmeta.com> <3D77A58F.B35779A1@zip.com.au>
In-Reply-To: <3D77A58F.B35779A1@zip.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17ndbo-0006SY-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 05 September 2002 20:42, Andrew Morton wrote:
> The `nr_of_sectors_completed' would be tricky to handle - we don't know how
> to bring the pagecache pages uptodate in response to a 512-byte completion.
> We'd have to teach the pagecache read functions to permit userspace to read
> from non-uptodate pages by looking at the buffer_head state.  And then
> look at buffer_req to distinguish "this part of the page hasn't been read yet"
> from "this part of the page had an IO error".  Ick.

It's yet another reason to have subpages, and see, keeping state
at the right granularity really does matter.

I'm just adding items to the list of reasons why we need it, so
when the time comes to do it, I won't have to waste a lot of energy
explaining why.

-- 
Daniel
