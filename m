Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264125AbSIQM2c>; Tue, 17 Sep 2002 08:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264139AbSIQM2c>; Tue, 17 Sep 2002 08:28:32 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:62223 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S264125AbSIQM2b>;
	Tue, 17 Sep 2002 08:28:31 -0400
Date: Tue, 17 Sep 2002 13:33:30 +0100
From: Matthew Wilcox <willy@debian.org>
To: Vlad Harchev <hvv@hippo.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: support for offset > 2GB on x86 in losetup needed
Message-ID: <20020917133330.O10583@parcelfarce.linux.theplanet.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi, Vlad

You wrote:
> Currently linux-2.4 on x86 doesn't allow to use offsets greater than 2GB
> for losetup utility. Looking at the code, it turns out that the kernel is
> guilty - linux kernel doesn't allow offsets greater than 2Gb since it uses
> 32-bit wide signed (why signed?) integer for storing the offset on x86..
>
> That's a very severe limitation IMHO, it would be very nice to fix this in
> 2.5 at least (but it would be better to fix it in 2.4 of course :).

That's right, the current ioctl API passes an `int' between userspace
and the kernel.  I'm currently working on a major rewrite of this code,
based on suggestions by Al Viro.

The new API will be:

mount -t loop -o offset=1234567890,rw foo.iso /dev/loop0

However I only started on this code last week, so I'm not quite done yet ;-)

Currently unsolved problem: encryption.  I'm certain people are not
comfortable supplying their keys on the command line, available to
anyone using ps.  So one option would be a 'key=file' option, but that
doesn't allow people to protect that with a passphrase (people _do_
use that feature, right?).  Next option is a `keyfd=N', but then we
need a losetup program, which invokes mount(2) rather than an ioctl.
Perhaps that's acceptable.

Other bright ideas urgently sought ;-)

-- 
Revolutions do not require corporate support.
