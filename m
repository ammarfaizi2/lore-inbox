Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292921AbSB0UCY>; Wed, 27 Feb 2002 15:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292900AbSB0UCS>; Wed, 27 Feb 2002 15:02:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:12180 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S292921AbSB0UBr>; Wed, 27 Feb 2002 15:01:47 -0500
Date: Wed, 27 Feb 2002 12:01:58 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Andrew Morton <akpm@zip.com.au>
cc: Hanna Linder <hannal@us.ibm.com>, linux-kernel@vger.kernel.org,
        lse-tech@lists.sourceforge.net, viro@math.psu.edu
Subject: Re: [Lse-tech] lockmeter results comparing 2.4.17, 2.5.3, and 2.5.5
Message-ID: <86760000.1014840118@flay>
In-Reply-To: <3C7D374B.4621F9BA@zip.com.au>
In-Reply-To: <10460000.1014833979@w-hlinder.des>,	<10460000.1014833979@w-hlinder.des> <67850000.1014834875@flay> <3C7D374B.4621F9BA@zip.com.au>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> inode_lock hold times are a problem for other reasons.  Leaving this
> unfixed makes the preepmtible kernel rather pointless....  An ideal
> fix would be to release inodes based on VM pressure against their backing
> page.  But I don't think anyone's started looking at inode_lock yet.
>
> The big one is lru_list_lock, of course.  I'll be releasing code in
> the next couple of days which should take that off the map.  Testing
> would be appreciated.

Seeing as people seem to be interested ... there are some big holders 
of BKL around too - do_exit shows up badly (50ms in the data Hanna 
posted, and I've seen that a lot before). I've seen sync_old_buffers 
hold the BKL for 64ms on an 8way Specweb99 run (22Gb of RAM?)
(though this was on an older 2.4 kernel, and might be fixed by now).

M.
