Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313867AbSFTLvS>; Thu, 20 Jun 2002 07:51:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314077AbSFTLvS>; Thu, 20 Jun 2002 07:51:18 -0400
Received: from pc-62-31-66-56-ed.blueyonder.co.uk ([62.31.66.56]:2178 "EHLO
	sisko.scot.redhat.com") by vger.kernel.org with ESMTP
	id <S313867AbSFTLvR>; Thu, 20 Jun 2002 07:51:17 -0400
Date: Thu, 20 Jun 2002 12:50:36 +0100
From: "Stephen C. Tweedie" <sct@redhat.com>
To: Andrew Morton <akpm@zip.com.au>
Cc: Zwane Mwaikambo <zwane@linux.realnet.co.sz>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Stephen Tweedie <sct@redhat.com>
Subject: Re: (2.5.23) buffer layer error at buffer.c:2326
Message-ID: <20020620125036.B3824@redhat.com>
References: <Pine.LNX.4.44.0206192007210.1263-100000@netfinity.realnet.co.sz> <3D10E358.D82DB604@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3D10E358.D82DB604@zip.com.au>; from akpm@zip.com.au on Wed, Jun 19, 2002 at 01:02:32PM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 19, 2002 at 01:02:32PM -0700, Andrew Morton wrote:

> What this says is: I still need to get down and set up a fault simulator
> and make sure that we're doing all the right things when I/O errors occur.

I've got one for 2.4:

	http://people.redhat.com/sct/patches/testdrive/

The testdrive-1.1-for-2.4.19pre10.patch can do random fault injection,
at pseudo-random intervals of selectable frequency, on reads or writes
or both.  It's a modified loop.o which requires a separate
testdrive.o, and you just losetup it over a block device (or, more
easily, "mount -o loop /dev/foo /mnt/bar".)  

It can trace IOs and will watch for suspicious activity such as
overlapping IOs being submitted.  The fault injection code trips in
before the bh request ever gets to the underlying block device.  

It shouldn't be too hard to adapt it to bio if you want.

Cheers,
 Stephen
