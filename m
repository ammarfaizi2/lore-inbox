Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314138AbSDVMms>; Mon, 22 Apr 2002 08:42:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314141AbSDVMmr>; Mon, 22 Apr 2002 08:42:47 -0400
Received: from adsl-xs4all.ds9a.nl ([213.84.159.51]:44039 "HELO
	dipsaus.ds9a.tudelft.nl") by vger.kernel.org with SMTP
	id <S314138AbSDVMmr>; Mon, 22 Apr 2002 08:42:47 -0400
Date: Mon, 22 Apr 2002 14:42:44 +0200
From: Jasper Spaans <jasper@spaans.ds9a.nl>
To: Libor Vanek <lists@conet.cz>
Cc: Peter =?iso-8859-15?Q?W=E4chtler?= <pwaechtler@loewe-komp.de>,
        linux-kernel@vger.kernel.org
Subject: Re: Adding snapshot capability to Linux
Message-ID: <20020422124244.GA18252@spaans.ds9a.nl>
In-Reply-To: <3CC3ECD2.9000205@conet.cz> <3CC3FCD2.2030008@loewe-komp.de> <3CC3FFC8.8020309@conet.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Keywords: SCUD missile NSA Qaddafi counter-intelligence Delta Force clones NORAD
Organization: http://www.insultant.nl/
X-Copyright: Copyright 2002 C. Jasper Spaans - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 22, 2002 at 02:19:20PM +0200, Libor Vanek wrote:

> > > I'm going to start my dissertation work which is "Adding snapshop 
> > > capability to Linux kernel with copy-on-write support". My idea is 
> > > add it as another VFS - I know that there is some snapshot support in 
> > > LVM but it's working on "device-level" and I'd like/have to do it on 
> > > fs level.
> 
> But AFAIK it doesn't work on fs level but (i.e. you cannot make snapshot 
> of some directory which contains NFS/Samba mapped dirs).

I'm sorry to have to say this, but making snapshots of remote filesystems is
kinda silly and impossible - if you implement it at the FS level.

To make a snapshot, you will have to be able to transfer the whole state of
the (remote) filesystem atomically (atomically on the remote server) which
will not happen when you don't have support for such functionality on that
server (think of other clients writing to that FS). Besides that, think of
the possible amounts of memory needed to store this snapshot locally, and
you should come to the conclusion that implementing snapshots at the FS
level is hairy, if not impossible.

You could however try to set up a snapshotting-system outside of LVM, though
that could become tricky too since LVM provides a nice way of reserving
space to store changes on the snapshotted fs. (To get back to your
original idea, you could implement a system like this and add some server
scripts to it, so a client can create and see a snapshotted version)

Regards,
-- 
Jasper Spaans
http://jsp.ds9a.nl/contact/
Tel/Fax: +31-84-8749842
