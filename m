Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318722AbSH1Fz3>; Wed, 28 Aug 2002 01:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318726AbSH1Fz3>; Wed, 28 Aug 2002 01:55:29 -0400
Received: from mx7.sac.fedex.com ([199.81.194.38]:19219 "EHLO
	mx7.sac.fedex.com") by vger.kernel.org with ESMTP
	id <S318722AbSH1Fz2>; Wed, 28 Aug 2002 01:55:28 -0400
Date: Wed, 28 Aug 2002 13:59:03 +0800 (SGT)
From: Jeff Chua <jchua@fedex.com>
X-X-Sender: root@boston.corp.fedex.com
To: Russell King <rmk@arm.linux.org.uk>
cc: Jeff Chua <jchua@fedex.com>, Erik Andersen <andersen@codepoet.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] initrd >24MB corruption (fwd)
In-Reply-To: <20020827103047.A13528@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44.0208281345120.9089-100000@boston.corp.fedex.com>
MIME-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/28/2002
 01:59:37 PM,
	Serialize by Router on ENTPM11/FEDEX(Release 5.0.8 |June 18, 2001) at 08/28/2002
 01:59:39 PM,
	Serialize complete at 08/28/2002 01:59:39 PM
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Aug 2002, Russell King wrote:

> I was suspecting that the write() to the ramdisk device was hanging
> (which you could confirm by printk'ing an 'i' before and an 'o' after
> the write call in flush_window() in init/do_mounts.c or
> drivers/block/rd.c.  If you end up with 'i' as the last character, its
> the write that hangs, if its an 'o' then its gunzip itself.)

last character is an "o". After that, "inflate_stored" was called ...
meaning the kernel doesn't think the data is compressed anymore. Looks
like somewhere the code can't handle this big chunk of data (8MB), whereas
the 6MB was ok.

Jeff



