Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261977AbTDXJzl (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Apr 2003 05:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261885AbTDXJzk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Apr 2003 05:55:40 -0400
Received: from bamb-d9b970e9.pool.mediaWays.net ([217.185.112.233]:6404 "EHLO
	rz.zidlicky.org") by vger.kernel.org with ESMTP id S261977AbTDXJzi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Apr 2003 05:55:38 -0400
Date: Thu, 24 Apr 2003 11:47:33 +0200
From: Richard Zidlicky <rz@linux-m68k.org>
To: John Bradford <john@grabjohn.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Linus Torvalds <torvalds@transmeta.com>, paulus@samba.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] M68k IDE updates
Message-ID: <20030424094732.GA925@linux-m68k.org>
References: <1051095870.2065.84.camel@dhcp22.swansea.linux.org.uk> <200304232019.h3NKJ7lc000582@81-2-122-30.bradfords.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <200304232019.h3NKJ7lc000582@81-2-122-30.bradfords.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 23, 2003 at 09:19:07PM +0100, John Bradford wrote:
 
> Moving byte swapping out of the IDE layer also means that dumping the
> whole disk to a file will then give you non-byte swapped data, which
> could then be written back to a disk on another machine without a
> byte-swapped IDE interface.
> 
> It will also allow you to exchange tar archives on raw hard disk
> devices, and have them readable on non-byte swapped IDE interfaces
> :-).

Linux is much better and will do all of that work perfectly since 
ages, just use hdX=swapdata on one of the machines. Trivially it 
is also possible to mount the partitions on either architecture.

The issue is the distinction between drive control data (like SMART
and ident) and on disk data - currently the ide layer makes no clear
distinction between those varieties and thus in some cases the 
byteswapping must be done (or undone) in userspace.

There are some reasons why I am hesitant to move it out of IDE:

- IDE knows best what is control or on disk data and
  having separate ide-iops for them would be trivial
- partitioning loop devices smells like plenty of fun
- performance, for compatibility with current kernels
  we would byteswap in IDE and undo it in the loop layer
- don´t like to rely on utterly complicated boot ramdisks

Richard
