Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291545AbSBSRsI>; Tue, 19 Feb 2002 12:48:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291541AbSBSRrt>; Tue, 19 Feb 2002 12:47:49 -0500
Received: from mail.parknet.co.jp ([210.134.213.6]:21516 "EHLO
	mail.parknet.co.jp") by vger.kernel.org with ESMTP
	id <S291533AbSBSRrl>; Tue, 19 Feb 2002 12:47:41 -0500
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Cc: linux-kernel@vger.kernel.org, "David S. Miller" <davem@redhat.com>
Subject: Re: gnome-terminal acts funny in recent 2.5 series
In-Reply-To: <12434E62524D@vcnet.vc.cvut.cz>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 20 Feb 2002 02:47:13 +0900
In-Reply-To: <12434E62524D@vcnet.vc.cvut.cz>
Message-ID: <878z9pz7mm.fsf@devron.myhome.or.jp>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Petr Vandrovec" <VANDROVE@vc.cvut.cz> writes:

> On 19 Feb 02 at 20:44, OGAWA Hirofumi wrote:
> > 
> > libzvt was using file descriptor passing via UNIX domain socket for
> > pseudo terminal. Then because ->passcred was not initialized in
> > sock_alloc(), unexpected credential data was passing to libzvt.
> > 
> > The following patch fixed this problem, but I'm not sure.
> > Could you review the patch? (attached file are test program)
> 
> I sent simillar patch to Linus and DaveM on Sunday. Unfortunately it
> did not found its way into either of these two trees (and IPX oops fix too). 
> In addition to yours I moved these 'sock->XXX = NULL' into sock_alloc_inode,
> as I see no reason why sock->wait should be initialized in sock_alloc_inode,
> but all other members in sock_alloc. It caused confusion to me, and
> from your comment it looks like that you missed it too. Besides that
> root of sockfs uses sock's inode with sock->ops, sk and file being
> 0x5a5a5a5a without moving initialization from sock_alloc to sock_alloc_inode.

I wish your patch apply to the tree. Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
