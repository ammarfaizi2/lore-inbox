Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261983AbVEPWbJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261983AbVEPWbJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 May 2005 18:31:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261966AbVEPW3a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 May 2005 18:29:30 -0400
Received: from mail.kroah.org ([69.55.234.183]:23731 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261964AbVEPW2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 May 2005 18:28:04 -0400
Date: Mon, 16 May 2005 15:27:36 -0700
From: Greg KH <greg@kroah.com>
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, linux-kernel@vger.kernel.org,
       Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 7/8] ppc64: SPU file system
Message-ID: <20050516222736.GA13350@kroah.com>
References: <200505132117.37461.arnd@arndb.de> <200505141505.08999.arnd@arndb.de> <20050516205825.GB11938@kroah.com> <200505170001.10405.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200505170001.10405.arnd@arndb.de>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 17, 2005 at 12:01:05AM +0200, Arnd Bergmann wrote:
> On Maandag 16 Mai 2005 22:58, Greg KH wrote:
> > On Sat, May 14, 2005 at 03:05:06PM +0200, Arnd Bergmann wrote:
> 
> > > 2. sys_spufs_run(int fd, __u32 pc, __u32 *new_pc, __u32 *status):
> > >  pro:
> > >      - strong types
> > >      - can have both input and output arguments
> > >  contra:
> > >      - does not fit file system semantics well
> > >      - bad for prototyping
> > 
> > I suggest you do this.  Based on what you say you want the code to do, I
> > agree, write() doesn't really work out well
> 
> The syscall approach has another small disadvantage in that I need to
> do a callback registration mechanism for it if I want to have spufs as
> a loadable module. I could of course require spufs to be builtin, but
> that complicates prototype testing (as mentioned) and enlarges combined
> pSeries/powermac/BPA distro kernels.

Huh?  We can handle syscalls in modules these days pretty simply.  Look
at how nfs and others do it.

> I think I'll leave the ioctl for now and add a note saying that I need
> to replace it with a syscall or the write/read or lseek/read based
> approach when I arrive at a more feature complete point.

Nah, make it a syscall :)

> > (but it might, and if you 
> > want an example of how to do it, look at the ibmasm driver, it
> > implements write() in a way much like what you are wanting to do.)
> 
> That would be the same write/read combination as Ben's second
> proposal and the nfsctl file system, right?

Yes.

> > > My solution was to force the dentries in each directory to be
> > > present. When the directory is created, the files are already
> > > there and unlinking a single file is impossible. To destroy the
> > > spu context, the user has to rmdir it, which will either remove
> > > all files in there as well or fail in the case that any file is
> > > still open.
> > 
> > Ick.
> > 
> > > Of course that is not really Posix behavior, but it avoids some
> > > other pitfalls.
> > 
> > Go with a syscall :)
> 
> Sorry, I'm not following that reasoning. How does a syscall help
> with the problem of atomic context destruction?

Sorry, I thought they were referring to the same issue.

greg k-h
