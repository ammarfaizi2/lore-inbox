Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314150AbSEBAsJ>; Wed, 1 May 2002 20:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314154AbSEBAsI>; Wed, 1 May 2002 20:48:08 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:44815 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S314150AbSEBAsH>; Wed, 1 May 2002 20:48:07 -0400
Message-Id: <200205011416.g41EFnX04718@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Keith Owens <kaos@ocs.com.au>, linux-kernel@vger.kernel.org
Subject: Re: [prepatch] address_space-based writeback
Date: Wed, 1 May 2002 17:18:32 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <9595.1020174038@ocs3.intra.ocs.com.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 30 April 2002 11:40, Keith Owens wrote:
> On Tue, 30 Apr 2002 23:15:23 +1000,
> john slee <indigoid@higherplane.net> wrote:
> >probably because there is software out there relying on them being
> >numbers and being able to do 'if(inum_a == inum_b) { same_file(); }'
> >as appropriate.  i can't think of a use for such a construct other than
> >preserving hardlinks in archives (does tar do this?) but i'm sure there
> >are others
>
> Any program that tries to preserve or detect hard links.  cp, mv (files
> a and b are the same file).  tar, cpio, rsync -H, du, etc.
>
> The assumption that inode numbers are unique within a mount point is
> one of the reasons that NFS export does not cross mount points by
> default.  man exports, look for 'nohide'.

And I recently moved my /usr/src to separate partition.
That is, /usr/src is now a mount point.
I have to export it in NFS exports *and* mount it *on every workstation*
(potentially thousands of wks!).

I'll repeat myself. What if some advanced fs has no sensible way of 
generating inode? Does it have to 'fake' it, just like [v]fat does it now?
(Yes, vfat is not 'advanced' fs, let's not discuss it...)

The fact that minix,ext[23],etc has inode #s is an *implementation detail*.
Historically entrenched in Unix.

Bad:
inum_a = inode_num(file1);
inum_b = inode_num(file2);
if(inum_a == inum_b) { same_file(); }

Better:
if(is_hardlinked(file1,file2) { same_file(); }

Yes, new syscal, blah, blah, blah... Not worth the effort, etc...
lets start a flamewar...
--
vda
