Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267640AbTAXMFz>; Fri, 24 Jan 2003 07:05:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267641AbTAXMFz>; Fri, 24 Jan 2003 07:05:55 -0500
Received: from comtv.ru ([217.10.32.4]:60640 "EHLO comtv.ru")
	by vger.kernel.org with ESMTP id <S267640AbTAXMFy>;
	Fri, 24 Jan 2003 07:05:54 -0500
X-Comment-To: Andrew Morton
To: Andrew Morton <akpm@digeo.com>
Cc: Alex Tomas <bzzz@tmi.comex.ru>, linux-kernel@alex.org.uk,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: 2.5.59-mm5
References: <20030123195044.47c51d39.akpm@digeo.com>
	<946253340.1043406208@[192.168.100.5]>
	<20030124031632.7e28055f.akpm@digeo.com>
	<m3d6mmvlip.fsf@lexa.home.net>
	<20030124035017.6276002f.akpm@digeo.com>
From: Alex Tomas <bzzz@tmi.comex.ru>
Organization: HOME
Date: 24 Jan 2003 15:05:00 +0300
In-Reply-To: <20030124035017.6276002f.akpm@digeo.com>
Message-ID: <m3lm1au51v.fsf@lexa.home.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> Andrew Morton (AM) writes:

 AM> That's correct.  Reads are usually synchronous and writes are
 AM> rarely synchronous.

 AM> The most common place where the kernel forces a user process to
 AM> wait on completion of a write is actually in unlink (truncate,
 AM> really).  Because truncate must wait for in-progress I/O to
 AM> complete before allowing the filesystem to free (and potentially
 AM> reuse) the affected blocks.

looks like I miss something here.

why do wait for write completion in truncate? 

getblk (blockmap);
getblk (bitmap);
set 0 in blockmap->b_data[N];
mark_buffer_dirty (blockmap);
clear_bit (N, &bitmap);
mark_buffer_dirty (bitmap);

isn't that enough?

