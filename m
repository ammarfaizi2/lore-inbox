Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317439AbSGEFoU>; Fri, 5 Jul 2002 01:44:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317440AbSGEFoT>; Fri, 5 Jul 2002 01:44:19 -0400
Received: from angband.namesys.com ([212.16.7.85]:30336 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S317439AbSGEFoS>; Fri, 5 Jul 2002 01:44:18 -0400
Date: Fri, 5 Jul 2002 09:46:47 +0400
From: Oleg Drokin <green@namesys.com>
To: Peter Chubb <peter@chubb.wattle.id.au>
Cc: reiserfs-dev@namesys.com, gelato@gelato.unsw.edu.au,
       linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Results of testing Reiserfs on large block devices.
Message-ID: <20020705094647.A1464@namesys.com>
References: <15653.12329.565726.228100@wombat.chubb.wattle.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <15653.12329.565726.228100@wombat.chubb.wattle.id.au>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Fri, Jul 05, 2002 at 03:35:37PM +1000, Peter Chubb wrote:

>    I couldn't get Reiserfs to work on large devices.  I've tracked the
> problem down.
>   When Reiserfs is mounted, it tries to allocate a chunk of memory for
> bitmaps using kmalloc.  The largest chunk allocatable by kmalloc is
> 128k.  This limits the size of a reiserfs to just under 2TB on a
> 64-bit platform (16384 bitmaps times 8bytes per pointer) or just under
> 4TB on a 32 bit platform (32768 bitmaps times 4bytes per pointer).

This is true for 4k blocksize.

> Hacking mm/slab.c to increase the memory limit allowed larger
> filesystems to be mounted, but I haven't tested these thoroughly yet.

Since kernel is yet to support block devices bigger than 2Tb, this is not an
issue yet.
Also Hans have not found a sponsor to fund this stuff which is also a problem.

Besides stuff you've just pointed out, there are also 32bit limit on
blocknumbers present in reiserfs v3 (which gives us 16Tb or something like that
limit for 4k blocksize)

Bye,
    Oleg
