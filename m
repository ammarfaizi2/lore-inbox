Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261836AbSKCMYL>; Sun, 3 Nov 2002 07:24:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261837AbSKCMYL>; Sun, 3 Nov 2002 07:24:11 -0500
Received: from pc1-cwma1-5-cust42.swa.cable.ntl.com ([80.5.120.42]:27532 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S261836AbSKCMYK>; Sun, 3 Nov 2002 07:24:10 -0500
Subject: Re: Filesystem Capabilities in 2.6?
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Oliver Xymoron <oxymoron@waste.org>, Alexander Viro <viro@math.psu.edu>,
       Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>,
       "Theodore Ts'o" <tytso@mit.edu>, Dax Kelson <dax@gurulabs.com>,
       Rusty Russell <rusty@rustcorp.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, davej@suse.de
In-Reply-To: <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0211022004510.2503-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Nov 2002 12:51:40 +0000
Message-Id: <1036327900.29711.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-11-03 at 04:20, Linus Torvalds wrote:
>  - do a complete "find" over the whole system to show that there is not a 
>    single suid binary anywhere.

Thats a hard problem. Since your scan is non atomic and because you have
directory notifications a running processes can have the setuid apps can
move the setuid bits around the file system to hide from you. 

>  - trivially show each and every binary that is allowed elevated 
>    permissions (and _which_ elevated permissions) by just doing a "mount".
> 
>  - and since the mount trees are really per-process, you can allow certain 
>    process groups to have mounts that others don't have.
> 
> I think that as a anal-retentive security admin, I'd like such a system.

Being able to give process trees a file system view which has certain 
capability raising properties removed is basically the existing
capability mechanism but with a cleaner interface and more powerful
semantics.

Doing that with just mount properties and using them to revoke rights
works for me. There is a vfs corner case (clearly the setuid bit of a
file that isnt setuid from this namespace point of view) which is very
very important but not hard to get right.


