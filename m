Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263725AbUDGQVu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Apr 2004 12:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263726AbUDGQVt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Apr 2004 12:21:49 -0400
Received: from dirac.phys.uwm.edu ([129.89.57.19]:27043 "EHLO
	dirac.phys.uwm.edu") by vger.kernel.org with ESMTP id S263725AbUDGQVq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Apr 2004 12:21:46 -0400
Date: Wed, 7 Apr 2004 11:21:40 -0500 (CDT)
From: Bruce Allen <ballen@gravity.phys.uwm.edu>
To: Andrew Morton <akpm@osdl.org>
cc: Andy Isaacson <adi@hexapodia.org>, bug-coreutils@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: dd PATCH: add conv=direct
In-Reply-To: <20040406173326.0fbb9d7a.akpm@osdl.org>
Message-ID: <Pine.GSO.4.21.0404071119120.903-100000@dirac.phys.uwm.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > On modern Linux, apparently the correct way to bypass the buffer cache
> > when writing to a block device is to open the block device with
> > O_DIRECT.  This enables, for example, the user to more easily force a
> > reallocation of a single sector of an IDE disk with a media error
> > (without overwriting anything but the 1k "sector pair" containing the
> > error).  dd(1) is convenient for this purpose, but is lacking a method
> > to force O_DIRECT.  The enclosed patch adds a "conv=direct" flag to
> > enable this usage.
> 
> This would be rather nice to have.  You'll need to ensure that the data
> is page-aligned in memory.
> 
> While you're there, please add an fsync-before-closing option.

Andrew, am I right that this is NOT needed for the proposed O_DIRECT
option, since open(2) says: 
  "The I/O is synchronous, i.e., at the completion of the read(2) or
   write(2) system call, data is guaranteed to have been transferred."
so the write will block until data is physically on the disk.

Cheers,
	Bruce

