Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132042AbRCVOva>; Thu, 22 Mar 2001 09:51:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132040AbRCVOuV>; Thu, 22 Mar 2001 09:50:21 -0500
Received: from asterix.hrz.tu-chemnitz.de ([134.109.132.84]:62632 "EHLO
	asterix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S132037AbRCVOtt>; Thu, 22 Mar 2001 09:49:49 -0500
Date: Thu, 22 Mar 2001 15:45:44 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: Alexander Viro <viro@math.psu.edu>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: lock_kernel() usage and sync_*() functions
Message-ID: <20010322154544.B11126@nightmaster.csn.tu-chemnitz.de>
In-Reply-To: <99bsbk$a6n$1@penguin.transmeta.com> <Pine.GSO.4.21.0103212354420.2632-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
In-Reply-To: <Pine.GSO.4.21.0103212354420.2632-100000@weyl.math.psu.edu>; from viro@math.psu.edu on Thu, Mar 22, 2001 at 12:18:27AM -0500
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 22, 2001 at 12:18:27AM -0500, Alexander Viro wrote:
> 
> 	I started with adding 
> void invalidate_dev(kdev_t dev, int sync_flag)
> {
>         struct super_block *sb = get_super(dev);
>         if (sync_flag == 1)
>                 sync_dev(dev);
>         else if (sync_flag == 2)
>                 fsync_dev(dev);
>         if (sb) {
>                 invalidate_inodes(sb);
>                 /* drop_super(sb); here */
>         }
>         invalidate_buffers(dev);
> }

Could we remove the "magic" sync_flag from the exported interface?

Do sth. like renaming your invalidate_dev() to
_invalidate_dev() and adding 3 defines:

#define invalidate_dev(dev) _invalidate_dev(dev,0)
#define invalidate_dev_sync(dev) _invalidate_dev(dev,1)
#define invalidate_dev_fsync(dev) _invalidate_dev(dev,2)

This would make it quite clear, what will be done.

AFAIR Linus dosn't like these magic numers either, right?

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
