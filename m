Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265001AbRFZPuJ>; Tue, 26 Jun 2001 11:50:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265003AbRFZPtu>; Tue, 26 Jun 2001 11:49:50 -0400
Received: from mailhost.tue.nl ([131.155.2.5]:18810 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id <S265001AbRFZPtj>;
	Tue, 26 Jun 2001 11:49:39 -0400
Message-ID: <20010626174942.A24389@win.tue.nl>
Date: Tue, 26 Jun 2001 17:49:42 +0200
From: Guest section DW <dwguest@win.tue.nl>
To: Martin Wilck <Martin.Wilck@fujitsu-siemens.com>
Cc: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] wrong disk index in /proc/stat
In-Reply-To: <20010626045614.A24248@win.tue.nl> <Pine.LNX.4.30.0106261605200.13052-100000@biker.pdb.fsc.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93i
In-Reply-To: <Pine.LNX.4.30.0106261605200.13052-100000@biker.pdb.fsc.net>; from Martin Wilck on Tue, Jun 26, 2001 at 04:07:33PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 26, 2001 at 04:07:33PM +0200, Martin Wilck wrote:

> > static inline unsigned int disk_index (kdev_t dev)
> > {
> >         struct gendisk *g = get_gendisk(dev);
> >         return g ? (MINOR(dev) >> g->minor_shift) : 0;
> > }
> 
> Well,
> 
> a) this is not in the official kernel,
> b) the original genhd.h says that's too slow (is it really slower?)

Ad a): true.
Ad b): if you only make this change then it will be faster or slower
  depending on how many disks you have (because get_gendisk() used
  to be a linear search through a list that has as length the number
  of disk majors); however, my get_gendisk today is

	static inline struct gendisk *
	get_gendisk(kdev_t dev) {
	        return blk_gendisk[MAJOR(dev)];
	}

  hence is faster.

Andries

[go to ftp://ftp.XX.kernel.org/pub/linux/kernel/people/aeb/ or so
and get patches 01*, 02*, ... and apply them successively to 2.4.6pre5.
complain to aeb@cwi.nl if anything is wrong]
