Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbUDJVNG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 10 Apr 2004 17:13:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262129AbUDJVNG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 10 Apr 2004 17:13:06 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:42890 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262114AbUDJVND
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 10 Apr 2004 17:13:03 -0400
Date: Sat, 10 Apr 2004 22:13:01 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Szakacsits Szabolcs <szaka@sienet.hu>
Cc: Andries Brouwer <aebr@win.tue.nl>, fledely <fledely@bgumail.bgu.ac.il>,
       linux-ntfs-dev@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: Re: Accessing odd last partition sector (was: [Linux-NTFS-Dev] mkntfs dirty volume marking)
Message-ID: <20040410211301.GW31500@parcelfarce.linux.theplanet.co.uk>
References: <20040410205445.GV31500@parcelfarce.linux.theplanet.co.uk> <Pine.LNX.4.21.0404102301400.840-100000@mlf.linux.rulez.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0404102301400.840-100000@mlf.linux.rulez.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 10, 2004 at 11:04:45PM +0200, Szakacsits Szabolcs wrote:
> 
> On Sat, 10 Apr 2004 viro@parcelfarce.linux.theplanet.co.uk wrote:
> > On Sat, Apr 10, 2004 at 10:29:37PM +0200, Andries Brouwer wrote:
> > > On Fri, Apr 09, 2004 at 01:38:51PM +0200, Szakacsits Szabolcs wrote:
> > > 
> > > > > TODO.ntfsprogs conatins the following TODO item under mkntfs:
> > > > >  - We don't know what the real last sector is, thus we mark the volume
> > > > > dirty and the subsequent chkdsk (which will happen on reboot into
> > > > > Windows automatically) recreates the backup boot sector if the Linux
> > > > > kernel lied to us about the number of sectors.
> > > 
> > > The ioctl BLKGETSIZE64 will tell you the size (in bytes) of a block device.
> > 
> > So will lseek() to SEEK_END, actually (both 2.4 and 2.6).
> > And yes, last sector _is_ accessible for dd(1) et.al.
> 
> In 2.6? Not for 2.4 when I tried (it wasn't the latest 2.4 kernel).

2.4 logics around block size handling is broken; we probably could backport
that series of patches, though.  2.6 simply sets block size to GCD(page size,
device size), so we don't have to worry about all that crap.
