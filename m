Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316541AbSGCKG7>; Wed, 3 Jul 2002 06:06:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316681AbSGCKG6>; Wed, 3 Jul 2002 06:06:58 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1944 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S316541AbSGCKG6>;
	Wed, 3 Jul 2002 06:06:58 -0400
Date: Wed, 3 Jul 2002 12:08:38 +0200
From: Jens Axboe <axboe@suse.de>
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020703100838.GH14097@suse.de>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020702141702.GA9769@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 02 2002, Joe Thornber wrote:
> Tom,
> 
> On Tue, Jul 02, 2002 at 09:40:56AM -0400, Tom Walcott wrote:
> > Hello,
> > 
> > Browsing the patch submitted for 2.4 inclusion, I noticed that LVM2 
> > modifies the buffer_head struct. Why does LVM2 require the addition of it's 
> > own private field in the buffer_head? It seems that it should be able to 
> > use the existing b_private field.
> 
> This is a horrible hack to get around the fact that ext3 uses the
> b_private field for its own purposes after the buffer_head has been
> handed to the block layer (it doesn't just use b_private when in the
> b_end_io function).  Is this acceptable behaviour ?  Other filesystems
> do not have similar problems as far as I know.
> 
> device-mapper uses the b_private field to 'hook' the buffer_heads so
> it can keep track of in flight ios (essential for implementing
> suspend/resume correctly).  See dm.c:dec_pending()

Your driver is required to properly stack b_private uses, however if
ext3 (well jbd really) over writes b_private after bh i/o submission I
would say that it is broken. That breaks more than just device mapper,
that will break any stacked driver (such as loop, for instance).

-- 
Jens Axboe

