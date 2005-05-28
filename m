Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262702AbVE1LgT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262702AbVE1LgT (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 28 May 2005 07:36:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262708AbVE1LgT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 28 May 2005 07:36:19 -0400
Received: from smtp005.mail.ukl.yahoo.com ([217.12.11.36]:39598 "HELO
	smtp005.mail.ukl.yahoo.com") by vger.kernel.org with SMTP
	id S262702AbVE1LgO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 28 May 2005 07:36:14 -0400
From: Blaisorblade <blaisorblade@yahoo.it>
To: user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [uml-devel] Re: [patch 4/4] uml: make it link in tt mode against NPTL glibc
Date: Sat, 28 May 2005 13:38:22 +0200
User-Agent: KMail/1.7.2
Cc: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>, jdike@addtoit.com,
       linux-kernel@vger.kernel.org
References: <20050527004024.606961AEE9A@zion.home.lan> <20050527042041.GC29811@parcelfarce.linux.theplanet.co.uk>
In-Reply-To: <20050527042041.GC29811@parcelfarce.linux.theplanet.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200505281338.22412.blaisorblade@yahoo.it>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 27 May 2005 06:20, Al Viro wrote:
> On Fri, May 27, 2005 at 02:40:24AM +0200, blaisorblade@yahoo.it wrote:
> > To make sure switcheroo() can execute when we remap all the executable
> > image, we used a trick to make it use a local copy of errno... this trick
> > does not work with NPTL glibc, only with LinuxThreads, so use another
> > (simpler) one to make it work anyway.
> >
> > Might need compile testing on different host archs, since it changes
> > __syscall_return from <asm/unistd.h>.
>
> For one thing, it's broken since mmap2() doesn't exist on amd64.  This
> stuff *is* low-level - as low-level as it gets.
> It's clearly 
> per-architecture.
Yes, agreed.
> See ftp.linux.org.uk/pub/people/viro/UM14-unmap-RC12-rc4 
> for a fix...
Seems reasonable except that on i386 you keep the old linker script, indeed; I 
think that the linker script shouldn't be per architecture.

Also (not verified) one section is either read-write or read-only, so 
merging .bss and .text does not seem good to me (I separated them on 
purpose).

Good catch for using .bss instead of .data.
-- 
Paolo Giarrusso, aka Blaisorblade
Skype user "PaoloGiarrusso"
Linux registered user n. 292729
http://www.user-mode-linux.org/~blaisorblade

	

	
		
___________________________________ 
Yahoo! Mail: gratis 1GB per i messaggi e allegati da 10MB 
http://mail.yahoo.it
