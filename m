Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293238AbSB1SMe>; Thu, 28 Feb 2002 13:12:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293181AbSB1SKY>; Thu, 28 Feb 2002 13:10:24 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:48396 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S293648AbSB1SHH>;
	Thu, 28 Feb 2002 13:07:07 -0500
Message-ID: <3C7E716E.9DC59B12@zip.com.au>
Date: Thu, 28 Feb 2002 10:05:34 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: Sync over loop devices takes ages? [2.4.17]
In-Reply-To: <20020228095955.GH774@elf.ucw.cz>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> 
> Hi!
> 
> I have a script (attached). At one point it tries to do sync... That
> sync take a long time, with disk mostly unused.

When doing (say) ext2-on-loop-on-ext2 you should always ensure
that the blocksize for the topmost filesystem is the same as
the one underneath.  So probably you wanted `mkfs.ext2 -b 4096'.

If you have a 1k blocksize filesystem loop-mounted on a 4k blocksize
filesystem, every write of a 1k block requires a read of the underlying
4k block. Which is excrutiatingly slow.

Some readahead in the loop driver would help heaps.

-
