Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316747AbSGBMKx>; Tue, 2 Jul 2002 08:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316751AbSGBMKw>; Tue, 2 Jul 2002 08:10:52 -0400
Received: from pc-62-30-72-191-ed.blueyonder.co.uk ([62.30.72.191]:58752 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S316747AbSGBMKv>; Tue, 2 Jul 2002 08:10:51 -0400
Date: Tue, 2 Jul 2002 13:13:14 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>, LKML <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: Automatically mount or remount EXT3 partitions with EXT2 when alaptop is powered by a battery?
Message-ID: <20020702131314.B4711@redhat.com>
References: <1024948946.30229.19.camel@turbulence.megapathdsl.net> <3D18A273.284F8EDD@zip.com.au> <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20020628215942.GA3679@pelks01.extern.uni-tuebingen.de>; from kobras@tat.physik.uni-tuebingen.de on Fri, Jun 28, 2002 at 11:59:42PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Jun 28, 2002 at 11:59:42PM +0200, Daniel Kobras wrote:
> On Tue, Jun 25, 2002 at 10:03:47AM -0700, Andrew Morton wrote:
> > If it's because of the disk-spins-up-too-much problem then
> > that can be addressed by allowing the commit interval to be
> > set to larger values.
> 
> The updated commit interval will only affect new transactions, correct?
> In other words, when changing the commit interval from t_old to t_new,
> it will take t_old seconds until we can be certain there are only
> transactions with a t_new expiry interval in the queue?

Yes, unless:
> Or is there a
> way to flush the current queue of transactions, eg. by fsync()ing the
> underlying block device, or by sending a magic signal to kjournald? 

an fsync() on any file or directory on the filesystem will ensure that
all old transactions have completed, and a sync() will ensure that any
old transactions are at least on their way to disk.

Cheers,
 Stephen
