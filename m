Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317698AbSG1Xsm>; Sun, 28 Jul 2002 19:48:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317816AbSG1Xsl>; Sun, 28 Jul 2002 19:48:41 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:29199 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S317698AbSG1Xsl>; Sun, 28 Jul 2002 19:48:41 -0400
Date: Mon, 29 Jul 2002 00:51:56 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: andrea@suse.de, linux-kernel@vger.kernel.org
Subject: Re: Patch?: initial ramdisks did not work in 2.5.28-29
Message-ID: <20020729005156.A20294@flint.arm.linux.org.uk>
References: <200207282342.QAA03809@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200207282342.QAA03809@adam.yggdrasil.com>; from adam@yggdrasil.com on Sun, Jul 28, 2002 at 04:42:20PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 04:42:20PM -0700, Adam J. Richter wrote:
> 	Initial ramdisks do not work in linux-2.5.2{8,9}, because

Correct.

> 	Also, I would appreciate knowing if anyone is acting as
> maintainer for drivers/block/rd.c, or if I should just send
> patches for rd.c directly to Linus if nobody complains on
> the linux-kernel mailing list.

Al has been working on the problem.  To permanently fix it so it doesn't
break each time a change to do_open() happens.  Yes, this ramdisk driver
is that brittle.

> +		rd_bdev[unit]->bd_inode->i_size = rd_kbsize[unit] << 10;

My temporary hack around the problem was to use rd_length[unit] since
that's already in bytes.  But anything that adds code here just makes
the driver slightly more brittle.

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

