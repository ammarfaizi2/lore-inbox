Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSGDV1c>; Thu, 4 Jul 2002 17:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314284AbSGDV1b>; Thu, 4 Jul 2002 17:27:31 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:38484 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S314278AbSGDV1b>; Thu, 4 Jul 2002 17:27:31 -0400
Date: Thu, 4 Jul 2002 21:30:53 +0100
From: Stephen Tweedie <sct@redhat.com>
To: Pavel Machek <pavel@ucw.cz>
Cc: "Stephen C. Tweedie" <sct@redhat.com>, Andrew Morton <akpm@zip.com.au>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020704213053.A28200@redhat.com>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de> <20020702131314.B4711@redhat.com> <20020703030447.GC474@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020703030447.GC474@elf.ucw.cz>; from pavel@ucw.cz on Wed, Jul 03, 2002 at 05:04:48AM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jul 03, 2002 at 05:04:48AM +0200, Pavel Machek <pavel@ucw.cz> wrote:

> > an fsync() on any file or directory on the filesystem will ensure that
> > all old transactions have completed, and a sync() will ensure that any
> > old transactions are at least on their way to disk.
> 
> Ugh, does that mean that if I 
> 
> "sync ; poweroff"
> 
> my data are not safe?

Right --- sync only guarantees that the writes have started; you're
not safe until the disk light is off.

The VFS kernel core syncs each filesystem sequentially during sync and
bdflush.  If we do each one synchronously, we end up serialising IO
and performance with multiple disks goes _way_ down.  However, you can
choose synchronous completion of ext3_write_super() by giving modular
ext3 the module option "do_sync_supers=1".

--Stephen
