Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265934AbTGHMK5 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 08:10:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266277AbTGHMK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 08:10:57 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:23777 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S265934AbTGHMKy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 08:10:54 -0400
Message-Id: <5.0.2.1.2.20030708142409.03e19c60@pop.kundenserver.de>
X-Mailer: QUALCOMM Windows Eudora Version 5.0.2
Date: Tue, 08 Jul 2003 14:29:49 +0200
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       "Randy.Dunlap" <rddunlap@osdl.org>
From: Sancho Dauskardt <sda@bdit.de>
Subject: Re: FAT statfs loop abort on read-error
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <87u19ypc1j.fsf@devron.myhome.or.jp>
References: <20030706102410.2becd137.rddunlap@osdl.org>
 <5.0.2.1.2.20030704123653.03140b70@pop.puretec.de>
 <20030706102410.2becd137.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 00:54 08.07.03 +0900, OGAWA Hirofumi wrote:
>"Randy.Dunlap" <rddunlap@osdl.org> writes:
>
> > On Fri, 04 Jul 2003 13:57:19 +0200 Sancho Dauskardt <sda@bdit.de> wrote:
> > |   when calling statfs on a volume that has been removed (without umount)
> > | fat_statfs() will attempt to read all sectors of the fat table quite 
> a few
> > | times (depending on the fat type, eg. FAT16 --> 256 times).
>
>Yes, fat driver of 2.4 ignore the many errors.
>
> > | Possible solution:
> > | 1. let default_fat_access return something like -2 on 'can't read' error.
> > | 2. Abort stafs loop on error.
> > | 3. return -EIO
> > |
> > | This would break mode fat_access calls. I could make a patch, but I 
> don't
> > | know what's going on with those cvf extensions (which seem to replace
> > | fat_access). Is dmsdos dead / can we ignore it ?
> > | Somewhere in the list archives, I found comments about the cvf stuff 
> being
> > | completely removed ?
>
>I don't know anybody ported dmsdos to 2.4. The cvf stuff was removed
>and many error handlings was fixed on 2.5.x. So, personally I think to
>remove the cvf stuff and backport the some parts of fat driver to 2.4
>is good.

OK, the 100k diff between 2.4.21/fs/fat and 2.5.74 didn't really help me 
understand what's really changed (other than the cvf removal).
Should I attempt to brute-force backport fs/fat/* in one large patch, or 
incrementally re-apply the 2.5 changes to 2.4 ?

Or, as you write 'some parts', which parts would that be ?

- sda

