Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130497AbQKPRAm>; Thu, 16 Nov 2000 12:00:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130770AbQKPRAc>; Thu, 16 Nov 2000 12:00:32 -0500
Received: from slc1038.modem.xmission.com ([166.70.8.22]:16393 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S130497AbQKPRA3>; Thu, 16 Nov 2000 12:00:29 -0500
To: Rik van Riel <riel@conectiva.com.br>
Cc: Andreas Osterburg <alanos@first.gmd.de>, linux-kernel@vger.kernel.org
Subject: Re: Swapping over NFS in Linux 2.4?
In-Reply-To: <Pine.LNX.4.21.0011151421580.5584-100000@duckman.distro.conectiva>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 16 Nov 2000 08:55:37 -0700
In-Reply-To: Rik van Riel's message of "Wed, 15 Nov 2000 14:23:24 -0200 (BRDT)"
Message-ID: <m13dgr9aiu.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rik van Riel <riel@conectiva.com.br> writes:

> On Wed, 15 Nov 2000, Andreas Osterburg wrote:
> 
> > Because I set up a diskless Linux-workstation, I want to swap
> > over NFS. For this purpose I found only patches for "older"
> > Linux-versions (2.0, 2.1, 2.2?).
> 
> > Does anyone know wheter there are patches for 2.4 or does anyone
> > know another solution for this problem?
> 
> 1. you can swap over NBD
> 2. if you point me to the swap-over-nfs patches you
>    have found, I can try to make them work on 2.4 ;)

Rik all we need to do now is convert the swapout code to address space
methods just like the block device was.

This has a number of interesting effects.  One of which is that
brw_page should no longer have any users.  Simplifying fs/buffer.c

Further this is equivalent to mounting a nfs file loop back which
the address space methods now allow, but it is more direct.  

Which means that if this reveals any bugs in nfs/lock ups in nfs they
were already there.

This has been on my want to do list for a while but I'm busy
reinventing booting so I haven't gotten to it.

Eric
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
