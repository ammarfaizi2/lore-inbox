Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267174AbTAPQZ1>; Thu, 16 Jan 2003 11:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267175AbTAPQZ1>; Thu, 16 Jan 2003 11:25:27 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:36582 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S267174AbTAPQZZ> convert rfc822-to-8bit; Thu, 16 Jan 2003 11:25:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>,
       "Richard B. Johnson" <root@chaos.analogic.com>
Subject: Re: Tar'ing /proc ???
Date: Thu, 16 Jan 2003 10:30:45 -0600
User-Agent: KMail/1.4.1
Cc: Linux Geek <bourne@ToughGuy.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <Pine.LNX.3.95.1030116090109.4226A-100000@chaos.analogic.com> <Pine.LNX.4.51.0301161505570.20335@dns.toxicfilms.tv>
In-Reply-To: <Pine.LNX.4.51.0301161505570.20335@dns.toxicfilms.tv>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200301161030.45349.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 16 January 2003 08:06 am, Maciej Soltysiak wrote:
> > Normally, you do `tar -clf`
> >
> >                         |________ stay on the same file-system.
> >
> > Otherwise toy need to use --exclude /proc.  Proc is a virtual
> > file-system that contains things like kcore. You can get into
>
> Well i think that besides kcore (and maybe kmem) you should be able
> to archive it.

Ummm not really - consider what some of the data files disappear while
tar is running (process directory tree). You may be in the process of
copying the process memory space when the process exits.

Kablooie

Your current directory just disappeared, along with the other files
you were going to backup.

You end up with a corrupted tar file.

I used to consider this as being possible to make a system
"snapshot" for later examination... but no.

Consider that a process will change contents out from under
tar as well. Since the process memory changed, you cannot
get a consistant process dump.

And think about what happens when the tar starts copying
itself... You can/will get another deadlock.

In fact - you may get a deadlock whenever you read process
memory - that stuff can extend/contract as the system pages
things in and out of memory.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
