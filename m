Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269424AbUICJ1G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269424AbUICJ1G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Sep 2004 05:27:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269471AbUICJZR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Sep 2004 05:25:17 -0400
Received: from mp1-smtp-2.eutelia.it ([62.94.10.162]:39583 "EHLO
	smtp.eutelia.it") by vger.kernel.org with ESMTP id S269616AbUICJYB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Sep 2004 05:24:01 -0400
Date: Fri, 3 Sep 2004 11:24:35 +0200
From: Luca Ferroni <fferroni@cs.unibo.it>
To: Gianni Tedesco <gianni@scaramanga.co.uk>
Cc: linux-kernel@vger.kernel.org, miklos@szeredi.hu, renzo@cs.unibo.it,
       frederik@a5.repetae.net
Subject: Userspace framework (was: Re: silent semantic changes with reiser4)
Message-Id: <20040903112435.0d754fac.fferroni@cs.unibo.it>
In-Reply-To: <1094181768.9282.27.camel@sherbert>
References: <rlrevell@joe-job.com>
	<1094079071.1343.25.camel@krustophenia.net>
	<200409021425.i82EPn9i005192@laptop11.inf.utfsm.cl>
	<1535878866.20040902214144@tnonline.net>
	<20040902194909.GA8653@atrey.karlin.mff.cuni.cz>
	<1094155277.11364.92.camel@krustophenia.net>
	<20040902204351.GE8653@atrey.karlin.mff.cuni.cz>
	<1094158060.1347.16.camel@krustophenia.net>
	<20040902205857.GF8653@atrey.karlin.mff.cuni.cz>
	<1094164385.6163.4.camel@localhost.localdomain>
	<1094181768.9282.27.camel@sherbert>
Organization: Ferrlabs
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Il Fri, 03 Sep 2004 04:22:48 +0100,  Gianni Tedesco <gianni@scaramanga.co.uk> ha scritto:

> On Thu, 2004-09-02 at 23:33 +0100, Alan Cox wrote:
> > On Iau, 2004-09-02 at 21:58, Pavel Machek wrote:
> > > Uservfs.sf.net.
> > > 
> > > Unlike alan, I do not think that "do it all in library" is good
> > > idea. I put it in the userspace as "codafs" server, and let
> > > applications see it as a regular filesystem.
> > 
> > That works for me too, providing someone has fixed all the user mode fs
> > deadlocks with paging
> 
> Aren't the deadlock scenarios only applicable for read/write mounted
> filesystems ?
> 

AFAIK deadlock arises when kernel manages buffers:
it has to free a buffer ==> choose a dirty one ==> if cleaning requires to make a call to
network server and this last is waiting for a buffer (cleaning accomplished) ==>
==> deadlock.

I think buffers are involved even in reading file system access.
I think also that NFS is threatened by deadlock, not CodaFS.

The problem with CodaFS is that it doesn't support random file access: 
you have to download a whole file in coda cache directory even
to read its first byte.

I'm writing my laurea thesis about userspace file system,
and two Interesting papers i found about this, are:

http://a5.repetae.net/~frederik/avfs/frederik_surf_paper.pdf by Frederik Eaton
and the more generic UFO paper
http://www.usenix.org/publications/library/proceedings/ana97/alexandrov.html

I think that LUFS (Linux User File System)  and FUSE (Filesystem in USErspace) 
kernel modules are solutions to be considered for adding to Linux develop branch.
They are similar, but FUSE is still maintained and improved, and it permit to create
a custom daemon for each user filesystem (unlinke lufsd daemon which loads a 
shared library). Communication kernel-user space is done through a special file descriptor,
unlike LUFS socket.
The only doubt is that FUSE is tuned for local file system performance, but I don't know
if it is possible to develop network file system with this framework.
LUFS is slower but more generic in this sense.

http://sourceforge.net/projects/avf

There is more documentation in the tarball than in the home page.

Ciao
Luca
