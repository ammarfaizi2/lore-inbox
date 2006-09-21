Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932093AbWIUWng@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbWIUWng (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Sep 2006 18:43:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWIUWng
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Sep 2006 18:43:36 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:28338 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S932093AbWIUWnf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Sep 2006 18:43:35 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Dave Jones <davej@redhat.com>
Subject: Re: [PATCH -mm 5/6] mm: Print first block offset for swap areas
Date: Fri, 22 Sep 2006 00:46:31 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
References: <200609202120.58082.rjw@sisk.pl> <20060921213253.GF2245@elf.ucw.cz> <20060921221058.GM26683@redhat.com>
In-Reply-To: <20060921221058.GM26683@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609220046.32233.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, 22 September 2006 00:10, Dave Jones wrote:
> On Thu, Sep 21, 2006 at 11:32:53PM +0200, Pavel Machek wrote:
>  > On Wed 2006-09-20 21:54:38, Rafael J. Wysocki wrote:
>  > > In order to use a swap file with swsusp we need to know the offset at which
>  > > its swap header is located.  However, the swap header is always located in the
>  > > first block of the swap file and it's quite easy to make sys_swapon() print
>  > > the offset of the swap file's (or swap partition's) first block.
>  > > 
>  > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
>  > 
>  > ACK.
>  > 
>  > (main point of this is that it changes user-visible printk, but that's
>  > probably okay, and way better than changing /proc files...)
> 
> As a user-interface, "read the number from dmesg that swapon printk'd
> and add that to your boot command line" is pretty damned awful.

Yes, it is.  However, the only solution I've invented so far is to print
that number in /proc/swaps, but that would be changing the
kernel-user interface quite badly ...

> It means that it's next to impossible for a distro installer to support
> suspend-to-swapfile. 

Not necessarily.  After creating the swap file the installer can bmap it
and figure out the offset from there (it will require some rescaling, but the
code for that is in mm/swapfile.c).

> It's also incredibly fragile to rely on that file always remaining in that
> part of the disk. 

Well, if you don't delete it, it'll stay there. ;-)

The entire problem is we can't use file names during resume, because we can't
mount filesystems at that time, so we need to represent the swap header's
location in a filesystem-independent way.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
