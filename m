Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267097AbTAPOKk>; Thu, 16 Jan 2003 09:10:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267114AbTAPOKk>; Thu, 16 Jan 2003 09:10:40 -0500
Received: from chaos.analogic.com ([204.178.40.224]:10633 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S267097AbTAPOKj>; Thu, 16 Jan 2003 09:10:39 -0500
Date: Thu, 16 Jan 2003 09:20:57 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
cc: Linux Geek <bourne@ToughGuy.net>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Tar'ing /proc ???
In-Reply-To: <Pine.LNX.4.51.0301161505570.20335@dns.toxicfilms.tv>
Message-ID: <Pine.LNX.3.95.1030116091326.4430A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 16 Jan 2003, Maciej Soltysiak wrote:

> > Normally, you do `tar -clf`
> >                         |________ stay on the same file-system.
> > Otherwise toy need to use --exclude /proc.  Proc is a virtual
> > file-system that contains things like kcore. You can get into
> Well i think that besides kcore (and maybe kmem) you should be able
> to archive it.
> 
> Regards,
> Maciej Soltysiak
>

kmem is in `/dev`. It's a device you would use if you wanted to read
all of kernel memory without locking problems.

If you really want to get a snapshot of kernel memory, then do
cat /proc/kcore >/tmp/foo.  /tmp/foo can then be manipulated.
The problem is that /proc/kcore is dynamic, the mere act of
'inspecting' it modifies is. 'tar' ends up doing 'morecore',
extending the break address when it encounters this large "file".
This attempts to modify the kernel which has a lock because of
the read. The result is a deadlock. Since `cat` or `cp` use
small blocks and never have to call the kernel for additional
resources, you can use them to get a snapshot. 

Cheers,
Dick Johnson
Penguin : Linux version 2.4.18 on an i686 machine (797.90 BogoMips).
Why is the government concerned about the lunatic fringe? Think about it.


