Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293386AbSDCMqO>; Wed, 3 Apr 2002 07:46:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293457AbSDCMqE>; Wed, 3 Apr 2002 07:46:04 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:63504 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S293386AbSDCMpy>; Wed, 3 Apr 2002 07:45:54 -0500
To: Jos Hulzink <josh@stack.nl>
Cc: Mike Fedyk <mfedyk@matchmail.com>, Helge Hafting <helgehaf@aitel.hist.no>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [Q] FAT driver enhancement
In-Reply-To: <20020403140516.C38235-100000@toad.stack.nl>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 03 Apr 2002 21:45:21 +0900
Message-ID: <87ofh1lzmm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jos Hulzink <josh@stack.nl> writes:

> On Wed, 3 Apr 2002, OGAWA Hirofumi wrote:
> 
> > Mike Fedyk <mfedyk@matchmail.com> writes:
> >
> > > > I mean I/O error, not data damage.
> > >
> > > It is the block layer's responsibility to retry such soft errors and recover.
> >
> > Yes.
> 
> But what about the data damage errors ?
> 
> > > Probably the best you can do, is retry the read a few times if there
> > > is an error reported, and then fail if it persists.
> >
> > Umm, there is a `copy of FAT table' for this kind of error. If the I/O
> > error occurs, the FAT driver should use the other FAT table.
> 
> How should the FAT driver know that the first FAT is bad if it doesn't
> scan the FAT ? You don't want the second FAT to be used, you want the
> mount to fail, and fsck.xxx to fix the mess. Who tells you that the second
> copy of the FAT is the correct one, and not the first ?

FAT16/FAT32 use the second entry of FAT table for data damage.
The 1 bit of second entry is a clean/dirty unmount flag.

But, it's not perfect. Furthermore, currently not implemented.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
