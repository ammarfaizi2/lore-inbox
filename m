Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275097AbRIYQro>; Tue, 25 Sep 2001 12:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275098AbRIYQrh>; Tue, 25 Sep 2001 12:47:37 -0400
Received: from leibniz.math.psu.edu ([146.186.130.2]:64476 "EHLO math.psu.edu")
	by vger.kernel.org with ESMTP id <S275097AbRIYQrY>;
	Tue, 25 Sep 2001 12:47:24 -0400
Date: Tue, 25 Sep 2001 12:47:46 -0400 (EDT)
From: Alexander Viro <viro@math.psu.edu>
To: Nerijus Baliunas <nerijus@users.sourceforge.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: all files are executable in vfat
In-Reply-To: <20010925161621.5DB188FBA0@mail.delfi.lt>
Message-ID: <Pine.GSO.4.21.0109251239250.24321-100000@weyl.math.psu.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 25 Sep 2001, Nerijus Baliunas wrote:

> On Tue, 25 Sep 2001 12:09:30 -0400 (EDT) Alexander Viro <viro@math.psu.edu> wrote:
> 
> AV> > All files are executable in vfat (kernel 2.4.10), although I have
> AV> > /dev/hda1  /mnt/c   vfat   defaults,user,noexec,umask=0,quiet 0 0
> AV> > in /etc/fstab. They were not in 2.4.7.
> AV> 
> AV> Really? Try to execute a binary from there.  cp /bin/ls /mnt/c && /mnt/c/ls
> 
> bash: /mnt/c/ls: Permission denied. But:
> $ ls -l ls
> -rwxrwxrwx    1 nerijus  nerijus     45724 Rgs 25 18:12 ls

So use the right option for that - umask=111 and there you go.

noexec doesn't (and shouldn't) do anything about mode.  Yes, VFAT (along
with explicit mechanism for doing what you want to do) used to have a
bug in noexec handling.  And that's a bug - plain and simple.  Try it
on any other UNIX _or_ other filesystem on Linux.

-o noexec means "execve() fails regardless of file permissions".  If you
want "give all regular files rw-rw-rw-" - VFAT has option for that:
umask.

