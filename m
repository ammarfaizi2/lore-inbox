Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129354AbRBNP5V>; Wed, 14 Feb 2001 10:57:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129578AbRBNP5C>; Wed, 14 Feb 2001 10:57:02 -0500
Received: from smtp6.us.dell.com ([143.166.83.101]:7955 "EHLO
	smtp6.us.dell.com") by vger.kernel.org with ESMTP
	id <S129354AbRBNP4p>; Wed, 14 Feb 2001 10:56:45 -0500
Date: Wed, 14 Feb 2001 09:56:43 -0600 (CST)
From: Michael E Brown <michael_e_brown@dell.com>
Reply-To: Michael E Brown <michael_e_brown@dell.com>
To: <Andries.Brouwer@cwi.nl>
cc: <Matt_Domsch@exchange.dell.com>, <linux-kernel@vger.kernel.org>
Subject: Re: block ioctl to read/write last sector
In-Reply-To: <UTC200102141543.QAA79054.aeb@vlet.cwi.nl>
Message-ID: <Pine.LNX.4.30.0102140947360.28753-100000@blap.linuxdev.us.dell.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Feb 2001 Andries.Brouwer@cwi.nl wrote:

>
> So if you add a 1-block partition that contains the last
> sector of the disk, all should be fine.
>

Oh! I didn't get your meaning before. I think I understand now. The
problem with this is that the tests for block writeability are not done on
a per-partition basis. They are done on a whole block device basis. see
fs/block_dev.c in block_read() and block_write(). The following test kills
us:

        if (blk_size[MAJOR(dev)])
                size = ((loff_t) blk_size[MAJOR(dev)][MINOR(dev)] <<
BLOCK_SIZE_BITS) >> blocksize_bits;
        else
                size = INT_MAX;
        while (count>0) {
                if (block >= size)
                        return written ? written : -ENOSPC;

--
Michael Brown
Linux Systems Group
Dell Computer Corp

