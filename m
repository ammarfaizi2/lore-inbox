Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288129AbSACCLH>; Wed, 2 Jan 2002 21:11:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288126AbSACCK6>; Wed, 2 Jan 2002 21:10:58 -0500
Received: from dsl-213-023-043-254.arcor-ip.net ([213.23.43.254]:57862 "EHLO
	starship.berlin") by vger.kernel.org with ESMTP id <S288129AbSACCKu>;
	Wed, 2 Jan 2002 21:10:50 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Tony Hoyle <tmh@nothing-on.tv>, timothy.covell@ashavan.org
Subject: Re: system.map
Date: Thu, 3 Jan 2002 03:14:29 +0100
X-Mailer: KMail [version 1.3.2]
Cc: adrian kok <adriankok2000@yahoo.com.hk>, linux-kernel@vger.kernel.org
In-Reply-To: <20020102191157.49760.qmail@web21204.mail.yahoo.com> <200201021930.g02JUCSr021556@svr3.applink.net> <3C336209.8000808@nothing-on.tv>
In-Reply-To: <3C336209.8000808@nothing-on.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16LxOr-000118-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 2, 2002 08:39 pm, Tony Hoyle wrote:
> Timothy Covell wrote:
> > 	Of course, you can copy over the new System.map
> > file to /boot,  but their is no (easy) way of having more than
> > one active version via "lilo" or "grub".   And that could be 
> > considered a deficiency of the Linux OS.
> 
> ????  Just call it System.map-2.2.17, System.map-2.5.1, etc.  Sounds
> pretty 'easy' to me.

It is if you know the magic incantation for System.map.

> 'make install' does all this for you, btw.

I've never been sure what 'make install' does, or what it might do in the 
future.  I've always just installed according to the README.  After doing 
this by hand way too many times, and having ferretted out the truth about 
System.map, I wrote the following bash script:

   here=`pwd`
   kernel=`basename $here`
   make modules_install >/dev/null
   cp arch/i386/boot/bzImage /boot/bzImage-$kernel
   cp System.map /boot/System.map-$kernel
   cp .config /boot/config-$kernel
   lilo

I put it in /usr/src and use it as follows:

  cd /usr/src/linux-xx.xx.xx
  sudo ../install

This does everything you need, with the exception of editing lilo.conf.  Note 
that the name of the top level directory is the name of the install, so you 
would probably not want to do 'cd /usr/src/linux' where linux is a symlink.

This is x86-specific, obviously.

--
Daniel
