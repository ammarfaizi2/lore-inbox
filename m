Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315050AbSD2Kpb>; Mon, 29 Apr 2002 06:45:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315053AbSD2Kpa>; Mon, 29 Apr 2002 06:45:30 -0400
Received: from oker.escape.de ([194.120.234.254]:18552 "EHLO oker.escape.de")
	by vger.kernel.org with ESMTP id <S315050AbSD2Kp2>;
	Mon, 29 Apr 2002 06:45:28 -0400
Date: Mon, 29 Apr 2002 12:33:41 +0200
From: Matthias Kilian <kili@outback.escape.de>
To: linux-kernel@vger.kernel.org
Subject: Re: How far has initramfs got ?
Message-ID: <20020429103341.GA28127@outback.escape.de>
In-Reply-To: <171nLP-1WyTImC@fwd09.sul.t-online.com> <20020428174230.GE18102@ravel.coda.cs.cmu.edu> <aahl82$97v$1@cesium.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 28, 2002 at 01:14:58PM -0700, H. Peter Anvin wrote:

[Jan Harkes:]
> > I would like to add that perhaps using tmpfs instead of ramfs would be
> > a nice touch.

I've written some code that allows using an initial tmpfs which gets it's
contents from a tar file (optionally compressed). See

http://www.escape.de/users/outback/linux/patch-2.4.17-inittar.gz (should also
work for 2.4.18) and (for later kernels):
http://www.escape.de/users/outback/linux/patch-2.4.19-pre3-inittar.gz

[hpa, on tmpfs mounted over initramfs:]
> Baloney.  You can't swap out what is actively in use, and something
> that's overmounted is actively used.  You're supposed to clean up the
> contents before overmounting.  I discussed with viro a scheme (using
> two ramfs's) which made that close to automatic, but I think he
> thought it was needless complexity.

But you don't have to swap anything. As I understand, the current concept is:

- a very minimalistic initial fs that doesn't anything meaningful except
  allowing the creation of directories (mount points).
- one or more other fs's on top of this, either overmounted or mounted on a
  mount point.
  
For example, my patch for 2.4.19-preX just does a
  	sys_mount("tmpfs", "/root", "tmpfs", ...);
	sys_chdir("/root");
Later, the tar image is extracted into this tmpfs. There's no need to swap or
unmount any filesystems. If you want to mount another filesystem as root and
throw away the tmpfs, just use chroot(8) and pivot_root(8).

Correct me if I'm wrong.


Ciao,
	Kili

ps: please answer with cc: to my address, since I'm not subscribed to this
mailinglist and may take longer to search the archives for answers.
