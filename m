Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315179AbSDWOp1>; Tue, 23 Apr 2002 10:45:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315223AbSDWOp0>; Tue, 23 Apr 2002 10:45:26 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:54947 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S315179AbSDWOp0>;
	Tue, 23 Apr 2002 10:45:26 -0400
Date: Tue, 23 Apr 2002 10:45:22 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Alvaro Figueroa <fede2@fuerzag.ulatina.ac.cr>
cc: LKML <linux-kernel@vger.kernel.org>
Subject: Re: Adding snapshot capability to Linux
In-Reply-To: <1019572222.800.6.camel@lucy>
Message-ID: <Pine.GSO.4.21.0204231041010.8087-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On 23 Apr 2002, Alvaro Figueroa wrote:

> > Instead of changing VFS you can probably make a generic stackable FS module 
> > .....that can stack on top of the physical filesystems  and happily take 
> > snapshots at "FS" level :) ! and you can use the FIST to create a basic 
> > stackable FS and then modify it to take care of snapshoting !
> 
> Since this solution doens't solve Lisbor's request of using it on smb
> filesystems, well, you could as well save up all of the programmer
> cycles and use EVMS.
> 
> It has a pluggin for treating normal partitions as EVMS objets, so you
> don't need to translate them or so; and with EVMS you can even use RW
> snapshots.

You _can't_ get consistent snapshots without cooperation from fs.  LVM,
EVMS, whatever.  Only filesystem knows what IO needs to be pushed to
make what we have on device consistent and what IO needs to be held
back.  Neither VFS nor device driver do not and can not have such
knowledge - it depends both on fs layout and on implementation details.

