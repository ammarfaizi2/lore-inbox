Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262175AbUDTHq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262175AbUDTHq7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 03:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbUDTHq6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 03:46:58 -0400
Received: from mailhost.tue.nl ([131.155.2.7]:38924 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S262175AbUDTHq5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 03:46:57 -0400
Date: Tue, 20 Apr 2004 09:46:50 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: Remi Colinet <remi.colinet@free.fr>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Questions : disk partition re-reading
Message-ID: <20040420074650.GA3040@pclin040.win.tue.nl>
References: <4082819E.10106@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4082819E.10106@free.fr>
User-Agent: Mutt/1.4.1i
X-Spam-DCC: : 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 18, 2004 at 03:24:46PM +0200, Remi Colinet wrote:

> I have 2 questions about disk partitioning under linux 2.6.x :
> 
> 1/ Is it possible to alter a disk partition of a used disk and beeing 
> able to use the modified partition without having to reboot the box?

Yes. Look at partx.

> 2/ Is it possible to delete a disk partition without having the 
> partition numbers changed?

Yes. Look at partx.

> Do I need to upgrade fdisk or use an other utility? Or do I need to 
> apply a kernel patch?

You must distinguish the on-disk partition table and the kernel
partition table. You can change the on-disk partition table just by
writing to it, but that does not change the kernel's ideas.
You can change the kernel partition table using the right ioctls
but that does not change the bits on disk.

Usually one does
	blockdev --rereadpt /dev/something
after changing media, or after writing to the partition table,
but that will fail if the disk is busy.
