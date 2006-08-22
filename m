Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932143AbWHVPdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932143AbWHVPdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Aug 2006 11:33:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932318AbWHVPdq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Aug 2006 11:33:46 -0400
Received: from 63-162-81-179.lisco.net ([63.162.81.179]:50708 "EHLO
	grunt.slaphack.com") by vger.kernel.org with ESMTP id S932143AbWHVPdq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Aug 2006 11:33:46 -0400
Message-ID: <44EB23D9.9000508@slaphack.com>
Date: Tue, 22 Aug 2006 10:33:45 -0500
From: David Masover <ninja@slaphack.com>
User-Agent: Thunderbird 1.5.0.5 (Macintosh/20060719)
MIME-Version: 1.0
To: Jeff Mahoney <jeffm@suse.com>
CC: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>,
       Mike Benoit <ipso@snappymail.ca>
Subject: Re: [PATCH] reiserfs: eliminate minimum window size for bitmap searching
References: <44EB1484.2040502@suse.com>
In-Reply-To: <44EB1484.2040502@suse.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Mahoney wrote:
>  When a file system becomes fragmented (using MythTV, for example), the
>  bigalloc window searching ends up causing huge performance problems. In
>  a file system presented by a user experiencing this bug, the file system
>  was 90% free, but no 32-block free windows existed on the entire file system.
>  This causes the allocator to scan the entire file system for each 128k write
>  before backing down to searching for individual blocks.

Question:  Would it be better to take that performance hit once, then 
cache the result for awhile?  If we can't find enough consecutive space, 
such space isn't likely to appear until a lot of space is freed or a 
repacker is run.

>  In the end, finding a contiguous window for all the blocks in a write is
>  an advantageous special case, but one that can be found naturally when
>  such a window exists anyway.

Hmm.  Ok, I don't understand how this works, so I'll shut up.
