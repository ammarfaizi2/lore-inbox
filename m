Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316681AbSGCKUc>; Wed, 3 Jul 2002 06:20:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316887AbSGCKUb>; Wed, 3 Jul 2002 06:20:31 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:49934 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316681AbSGCKUb>;
	Wed, 3 Jul 2002 06:20:31 -0400
Message-ID: <3D22D1CE.1C0A4906@zip.com.au>
Date: Wed, 03 Jul 2002 03:28:30 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Jens Axboe <axboe@suse.de>
CC: Joe Thornber <joe@fib011235813.fsnet.co.uk>, linux-lvm@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [linux-lvm] LVM2 modifies the buffer_head struct?
References: <F19741gcljD2E2044cY00004523@hotmail.com> <20020702141702.GA9769@fib011235813.fsnet.co.uk> <20020703100838.GH14097@suse.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:
> 
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
> would say that it is broken. That breaks more than just device mapper,
> that will break any stacked driver (such as loop, for instance).

It requires that b_private be stable across the lifetime of the buffer.

hmm.

-
