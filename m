Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317003AbSGCL6t>; Wed, 3 Jul 2002 07:58:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317005AbSGCL6t>; Wed, 3 Jul 2002 07:58:49 -0400
Received: from gw.uk.sistina.com ([62.172.100.98]:45577 "EHLO
	gw.uk.sistina.com") by vger.kernel.org with ESMTP
	id <S317003AbSGCL6s>; Wed, 3 Jul 2002 07:58:48 -0400
Date: Wed, 3 Jul 2002 13:01:24 +0100
To: Jens Axboe <axboe@suse.de>
Cc: linux-lvm@sistina.com, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@zip.com.au>
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
Message-ID: <20020703120124.GB615@fib011235813.fsnet.co.uk>
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020703100838.GH14097@suse.de>
User-Agent: Mutt/1.3.28i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 03, 2002 at 12:08:38PM +0200, Jens Axboe wrote:
> On Tue, Jul 02 2002, Joe Thornber wrote:
> > Tom,
> > 
> > On Tue, Jul 02, 2002 at 09:40:56AM -0400, Tom Walcott wrote:
> > > Hello,
> > > 
> > > Browsing the patch submitted for 2.4 inclusion, I noticed that LVM2 
> > > modifies the buffer_head struct. Why does LVM2 require the addition of it's 
> > > own private field in the buffer_head? It seems that it should be able to 
> > > use the existing b_private field.
> > 
> > This is a horrible hack to get around the fact that ext3 uses the
> > b_private field for its own purposes after the buffer_head has been
> > handed to the block layer (it doesn't just use b_private when in the
> > b_end_io function).  Is this acceptable behaviour ?  Other filesystems
> > do not have similar problems as far as I know.
> > 
> > device-mapper uses the b_private field to 'hook' the buffer_heads so
> > it can keep track of in flight ios (essential for implementing
> > suspend/resume correctly).  See dm.c:dec_pending()
> 
> Your driver is required to properly stack b_private uses, however if
> ext3 (well jbd really) over writes b_private after bh i/o submission I
> would say that it is broken.

AFAIK ext3 doesn't overwrite b_private after submission, but does
expect the value not to change (ie. no stacking to be taking place).

- Joe
