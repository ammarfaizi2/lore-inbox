Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280951AbRKORX4>; Thu, 15 Nov 2001 12:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280952AbRKORXs>; Thu, 15 Nov 2001 12:23:48 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:58130 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S280951AbRKORXg>; Thu, 15 Nov 2001 12:23:36 -0500
Message-ID: <3BF3F9ED.17D55B35@zip.com.au>
Date: Thu, 15 Nov 2001 09:22:53 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Ben Collins <bcollins@debian.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: Bug in ext3
In-Reply-To: <20011115092452.Z329@visi.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ben Collins wrote:
> 
> I recently compiled support for ext3 into the kernel (2.4.15-pre4) and
> booted that kernel onto a system that didn't have any ext3 partitions.
> On boot I got these messages:
> 
> JBD: no valid journal superblock found
> JBD: no valid journal superblock found
> EXT3-fs: error loading journal.
> 

It sounds like the superblock claims to be an ext3 fs, but something
has scrogged the journal file.

e2fsck should have removed the journal in this situation, with
the message "*** ext3 journal has been deleted - filesystem is
now ext2 only ***".

Please send the output of dumpe2fs, and of `fsck -fy'.

Probably you can repair it by booting with `init=/bin/sh' and
running `tune2fs -O ^has-journal' agains the fs, and then fscking
it.
