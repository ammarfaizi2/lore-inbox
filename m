Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268900AbRG0RSL>; Fri, 27 Jul 2001 13:18:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268894AbRG0RSB>; Fri, 27 Jul 2001 13:18:01 -0400
Received: from congress199.linuxsymposium.org ([209.151.18.199]:37637 "EHLO
	lynx.adilger.int") by vger.kernel.org with ESMTP id <S268885AbRG0RRv>;
	Fri, 27 Jul 2001 13:17:51 -0400
From: Andreas Dilger <adilger@turbolinux.com>
Message-Id: <200107271715.f6RHFea24226@lynx.adilger.int>
Subject: Re: Strane remount behaviour with ext3-2.4-0.9.4
To: sean@uncarved.com (Sean Hunter)
Date: Fri, 27 Jul 2001 11:15:39 -0600 (MDT)
Cc: ext3-users@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010727104049.B6311@uncarved.com> from "Sean Hunter" at Jul 27, 2001 10:40:49 AM
X-Mailer: ELM [version 2.5 PL0pre8]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

Sean writes:
> servers.  Since the server in question is a farily security-sensitive box, my
> /usr partition is mounted read only except when I remount rw to install
> packages.

If it is a security-sensitive box, you need to at least use data=ordered or
data=journal.  Using data=writeback allows the possibility that after a crash
one user might be able to read data from deleted files of another user (note
that reiserfs currently only runs the equivalent of data=writeback).

> When I try to remount it r/w I get a log message saying:
> Jul 27 09:54:29 henry kernel: EXT3-fs: cannot change data mode on remount
> 
> ...even if I give the full mount option list (including data=writeback) with
> the remount instruction.

You _could_ leave out the data=writeback from /etc/fstab (default is ordered),
and you will be able to remount OK.  Also, Andrew made a patch which allowed
you to specify the data= mode on remount, as long it is the same. 

> I can, however, remount it as ext2 read-write, but when I try to remount as
> ext3 (even read only) I get the same problem.

You can't change filesystem types via remount (ext2 and ext3 are different
filesystem drivers).  In the future, you might be able to use the ext3
driver to mount a filesystem in totally unjournaled (ext2) mode.

Cheers, Andreas
-- 
Andreas Dilger
http://sourceforge.net/projects/ext2resize/
http://www-mddsp.enel.ucalgary.ca/People/adilger/
