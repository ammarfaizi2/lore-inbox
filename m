Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289132AbSAMLxF>; Sun, 13 Jan 2002 06:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289165AbSAMLwz>; Sun, 13 Jan 2002 06:52:55 -0500
Received: from adsl-212-59-30-243.takas.lt ([212.59.30.243]:16885 "EHLO
	gintaras.vetrunge.lt.eu.org") by vger.kernel.org with ESMTP
	id <S289132AbSAMLwl>; Sun, 13 Jan 2002 06:52:41 -0500
Date: Sun, 13 Jan 2002 13:52:30 +0200
From: Marius Gedminas <mgedmin@centras.lt>
To: linux-kernel@vger.kernel.org
Subject: Re: Hard lock when mounting loopback file
Message-ID: <20020113115230.GB1955@gintaras>
Mail-Followup-To: linux-kernel@vger.kernel.org
In-Reply-To: <3C3F3267.7050103@actarg.com> <3C413BF0.24576AEC@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3C413BF0.24576AEC@zip.com.au>
User-Agent: Mutt/1.3.25i
X-URL: http://ice.dammit.lt/~mgedmin/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 12, 2002 at 11:49:04PM -0800, Andrew Morton wrote:
> I don't know a thing about fat layout, but it appears that it uses a
> linked list of blocks, and if that list ends up pointing back onto
> itself, the kernel goes into an infinite loop in several places chasing
> its way to the end of the list.
> 
> The below patch fixed it for me, and I was able to mount and read
> your filesystem image.
> 
> Unless someone has a smarter fix, I'll send this to the kernel
> maintainers in a week or two.

It seems to me that this patch will find only those infinite loops where
the last link of the chain points to itself.  But there could be loops
where the last link points to the middle of the chain.

Additional check on the number of followed links could be useful there.
No chain should be longer than the number of clusters on the fs.
Although on large FAT32 filesystems the number of clusters can be high,
a very long loop is still better than an infinite one.  (In cases where
we know the file size, this limit can be reduced to
file_size/cluster_size + 1 links).

Marius Gedminas
-- 
This company has performed an illegal operation and will be shut down. If
the problem persists, contact your vendor or appeal to a higher court.
