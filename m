Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265352AbUAAKDe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 05:03:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUAAKDe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 05:03:34 -0500
Received: from fw.osdl.org ([65.172.181.6]:48358 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265352AbUAAKDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 05:03:32 -0500
Date: Thu, 1 Jan 2004 02:04:06 -0800
From: Andrew Morton <akpm@osdl.org>
To: Calin Szonyi <caszonyi@rdslink.ro>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Memory management problem with 2.6.0
Message-Id: <20040101020406.4bbb2fdd.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.53.0401010559330.687@grinch.ro>
References: <Pine.LNX.4.53.0312271912350.511@grinch.ro>
	<20031227194144.54d052d1.akpm@osdl.org>
	<Pine.LNX.4.53.0401010559330.687@grinch.ro>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

caszonyi@rdslink.ro wrote:
>
> On Sat, 27 Dec 2003, Andrew Morton wrote:
> 
> > caszonyi@rdslink.ro wrote:
> > >
> > > I have a small script:
> > >  #!/bin/sh
> > >  umount /mnt/cdrom
> > >  eject /dev/hdb
> > >  echo "Invalid system disk"
> > >  echo "Insert and press any key when ready"
> > >  read junk
> > >  eject -t /dev/hdb
> > >  sleep 1
> > >  mount /mnt/cdrom
> > >  /usr/sbin/hdparm -E 10 /dev/hdb
> > >
> > >  It works all the time but today gave me this:
> > >
> > >  In the logs I had:
> > >  Dec 27 19:06:16 grinch kernel: eject: page allocation failure. order:4,
> > >  mode:0xd0
> >
> > Please, try
> >
> > 	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm1/broken-out/cdrom-allocation-try-harder.patch
> >
> > and let me know?
> >
> 
> for cdrom it *seems* to work.
> 
> The problem continues however for other applications
> It is not specific to the ide-cd driver. The same problem happens
> sometimes
> with mplayer also
> 
> Dec 30 22:07:12 grinch kernel: mplayer: page allocation failure. order:4,
> mode:0x21

OK, there's another one.  Please apply

	ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.0/2.6.0-mm2/broken-out/page-alloc-failure-dump_stack.patch

and send the backtrace.
