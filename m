Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284794AbSBGGUl>; Thu, 7 Feb 2002 01:20:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284305AbSBGGUW>; Thu, 7 Feb 2002 01:20:22 -0500
Received: from angband.namesys.com ([212.16.7.85]:23939 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S284794AbSBGGUO>; Thu, 7 Feb 2002 01:20:14 -0500
Date: Thu, 7 Feb 2002 09:20:12 +0300
From: Oleg Drokin <green@namesys.com>
To: Luigi Genoni <kernel@Expansa.sns.it>
Cc: reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] oops with reiserfs and kernel 2.5.4-pre1 on sparc64
Message-ID: <20020207092012.C6351@namesys.com>
In-Reply-To: <Pine.LNX.4.44.0202061850060.17669-100000@Expansa.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0202061850060.17669-100000@Expansa.sns.it>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Wed, Feb 06, 2002 at 06:53:47PM +0100, Luigi Genoni wrote:

> I was trying 2.5.4-pre1 on sparc64 sun4u ultra2,
> with 1GB memory and scsi controller ess.
> This system has just one CPU.
> >>TPC; 0046cf7c <grow_buffers+5c/e0>   <=====
> >>O7;  0046cf38 <grow_buffers+18/e0>
> >>I7;  0046b260 <__getblk+20/60>
> Trace; 0046b260 <__getblk+20/60>
> Trace; 0046b56c <__bread+c/a0>
> Trace; 004d1374 <journal_init+214/8e0>
This looks like VFS have exploded for whatever reson, I think
because one ot these checks failed:
linux/fs/buffer.c:
        if (size & (get_hardsect_size(to_kdev_t(bdev->bd_dev))-1))
                BUG();
        /* Size must be within 512 bytes and PAGE_SIZE */
        if (size < 512 || size > PAGE_SIZE)
                BUG();

Can any of sparc64 people comment on what kind of exception will one
get for __builtin_trap?
Second BUG() seems to be out of the question, though.
Do you have CONFIG_DEBUG_BUGVERBOSE enabled?

Bye,
    Oleg
