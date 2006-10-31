Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423647AbWJaVUJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423647AbWJaVUJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 16:20:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423651AbWJaVUJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 16:20:09 -0500
Received: from ogre.sisk.pl ([217.79.144.158]:52904 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S1423647AbWJaVUG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 16:20:06 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Luca Tettamanti <kronos.it@gmail.com>
Subject: Re: Suspend to disk:  do we HAVE to use swap?
Date: Tue, 31 Oct 2006 22:18:17 +0100
User-Agent: KMail/1.9.1
Cc: Alistair John Strachan <s0348365@sms.ed.ac.uk>,
       linux-kernel@vger.kernel.org,
       John Richard Moser <nigelenki@comcast.net>
References: <20061031174006.GA31555@dreamland.darkstar.lan> <200610312019.38368.rjw@sisk.pl> <20061031201502.GB5194@dreamland.darkstar.lan>
In-Reply-To: <20061031201502.GB5194@dreamland.darkstar.lan>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200610312218.18175.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 31 October 2006 21:15, Luca Tettamanti wrote:
> Il Tue, Oct 31, 2006 at 08:19:37PM +0100, Rafael J. Wysocki ha scritto: 
> > On Tuesday, 31 October 2006 20:05, Alistair John Strachan wrote:
> > > On Tuesday 31 October 2006 17:40, Luca Tettamanti wrote:
> > > > Alistair John Strachan <s0348365@sms.ed.ac.uk> ha scritto:
> > > > > On Tuesday 31 October 2006 06:16, Rafael J. Wysocki wrote:
> > > > > [snip]
> > > > >
> > > > >> However, we already have code that allows us to use swap files for the
> > > > >> suspend and turning a regular file into a swap file is as easy as
> > > > >> running 'mkswap' and 'swapon' on it.
> > > > >
> > > > > How is this feature enabled? I don't see it in 2.6.19-rc4.
> > > >
> > > > Swap files have been supported for ages. suspend-to-swapfile is very
> > > > new, you need a -mm kernel and userspace suspend from CVS:
> > > > http://suspend.sf.net
> > > 
> > > I know, I use swap files, and not a partition. This has prevented me from 
> > > using suspend to disk "for ages". ;-)
> > > 
> > > Is userspace suspend REQUIRED for this feature?
> > 
> > No, but unfortunately one piece is still missing: You'll need to figure out
> > where your swap file's header is located.
> > 
> > However, if you apply the attached patch the kernel will tell you where it is
> > (after you do 'swapon' grep dmesg for 'swap' and use the value in the
> > 'offset' field).
> 
> Of course it's also possibile to use FIBMAP ioctl:
> 
> #include <stdio.h>
> #include <fcntl.h>
> #include <unistd.h>
> #include <sys/ioctl.h>
> #include <linux/fs.h>
> 
> int main(int argc, char **argv) {
>         int block = 0;
>         int fd;
> 
>         if (argc < 2)
>                 return 1;
> 
>         fd = open(argv[1], O_RDONLY);
>         if (fd < 0) {
>                 perror("open()");
>                 return 1;
>         }
> 
>         if (ioctl(fd, FIBMAP, &block)) {
>                 perror("ioctl()");
>                 return 1;
>         }
> 
>         close(fd);
>         printf("%d\n", block);
> 
>         return 0;
> }
> 
> Probably it's more script friendly (grepping dmesg? hmmm) ;)

That's a bit more complicated, because you need to find a block which is
PAGE_SIZE big and express the number in PAGE_SIZE units.

Still it _is_ more script friendly and that's why the patch I sent hasn't been
applied.

Greetings,
Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller
