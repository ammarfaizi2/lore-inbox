Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314811AbSHMKnd>; Tue, 13 Aug 2002 06:43:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314938AbSHMKnd>; Tue, 13 Aug 2002 06:43:33 -0400
Received: from mail.zmailer.org ([62.240.94.4]:55944 "EHLO mail.zmailer.org")
	by vger.kernel.org with ESMTP id <S314811AbSHMKnc>;
	Tue, 13 Aug 2002 06:43:32 -0400
Date: Tue, 13 Aug 2002 13:47:22 +0300
From: Matti Aarnio <matti.aarnio@zmailer.org>
To: Nandakumar NarayanaSwamy <nanda_kn@rediffmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: RealTek RTL8139C
Message-ID: <20020813104722.GA32427@mea-ext.zmailer.org>
References: <20020813100956.2082.qmail@mailweb33.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020813100956.2082.qmail@mailweb33.rediffmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 13, 2002 at 10:09:56AM -0000, Nandakumar  NarayanaSwamy wrote:
> Hi All,
> 
> Sorry for disturbing the list again.
> 
> I am using RTL8139C in our target board which is based on MIPS 
> IDT32334 processor.
...
> My doubt is whether this 8139too.c is tested with MIPS processors? 
> Because in one of the article i found that the supported 
> processors are ARM, i386 etc.

  ( Are you sure you don't want to use  8139cp.c  driver ? )

  It might.  The issue is most likely the ENDIANITY of command
  registers, and how they are supported.

  The  i386 is little-endian machine, and most hardware is made for that.
  However in case of embedded systems, there are very system dependent
  details no how the host processor accesses PCI-bus, and what happens
  then...

  Talk with your harware maker.  At least the  8139*.c  drivers use
  cpu_to_le32() and friends for these byte-order mapping issues, but
  if there happens some gratuitious byte-order wrap-around when posting
  IO from the CPU to the PCI bus, then you have major problems, and
  will need experienced kernel hacker to get you thru...

  That is, if the CPU does post a big-endian (data byte order) operation
  into the bus, and the cpu<->bus host-bridge will not do any magic byte-
  order wrap-around, then the driver should just simply work.


  Of course with MIPS processors you can have two different byte-orders
  active in the system (one at the time, of course).  You need to know
  which you are using.


> Can any body throw some light on this?
> with best regards,
> Nanda
