Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287202AbSACMZv>; Thu, 3 Jan 2002 07:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287199AbSACMZc>; Thu, 3 Jan 2002 07:25:32 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:2053 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S287202AbSACMZ1>; Thu, 3 Jan 2002 07:25:27 -0500
Date: Thu, 3 Jan 2002 15:25:20 +0300
From: Oleg Drokin <green@namesys.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: marcelo@conectiva.com.br, linux-kernel@vger.kernel.org,
        reiserfs-dev@namesys.com, viro@math.psu.edu
Subject: Re: [PATCH] expanding truncate
Message-ID: <20020103152520.A7030@namesys.com>
In-Reply-To: <20020103102128.A2625@namesys.com> <E16M6wB-00089t-00@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E16M6wB-00089t-00@the-village.bc.nu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 03, 2002 at 12:25:34PM +0000, Alan Cox wrote:
> >     This patch makes sure that indirect pointers for holes are correctly filled in by zeroes at
> >     hole-creation time. (Author is Chris Mason. fs/buffer.c part (generic_cont_expand) were written by
> >     Alexander Viro)
> Why is that even needed. If you truncate a file larger it doesn't need to
> fill in the datablocks until they are touched surely
Purpose of this patch is of course not to fill in the datablocks with zeroes.
The purpose (as applied to reiserfs) is to fill indirect data pointers (that is - pointers to real data blocks)
with zeroes (and to organize proper in-tree data structure for such pointers).
As of now such organization and zero-filling is done on a lazy manner at disk-flushing time.
Unfortunatelly this leads to races in the code.
I do not know why parts of this code can be needed by other filesystem and why Al Viro put it in generic VFS
code. (but he can comment on it, I think)

Bye,
    Oleg
