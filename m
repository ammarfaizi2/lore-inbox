Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263220AbTDGD2c (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 23:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263224AbTDGD2c (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 23:28:32 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:35340 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263220AbTDGD2a (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 6 Apr 2003 23:28:30 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] new syscall: flink
Date: 6 Apr 2003 20:39:59 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b6qruf$elf$1@cesium.transmeta.com>
References: <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <Pine.BSO.4.44.0304062250250.9407-100000@kwalitee.nolab.conman.org>
By author:    Mark Grosberg <mark@nolab.conman.org>
In newsgroup: linux.dev.kernel
> 
> > > Suppose I give you an O_RDONLY handle to a file which you then
> > > flink and gain write access too ?
> >
> > This, I believe, is the real issue.  However, we already have that
> > problem:
> 
> As far as I understand it, isn't the protection information stored in the
> inode? The flink call is just linking an inode into a directory that the
> caller has write access to. The permissions and ownership of the file
> shouldn't change.
> 

The problem is when you get passed a file descriptor from another
process (via exec or file-descriptor passing) and you don't have
permissions to access the *directory*.

My example, though, shows that we have this problem already.

> > int main(int argc, char *argv[])
> > {
> >   int rfd, wfd;
> >   char filebuf[PATH_MAX];
> >
> >   rfd = open("testfile", O_RDONLY|O_CREAT, 0666);
> >   /* Now rfd is a read-only file descriptor */
> 
> There is nothing stopping the caller from re-opening the to-be flinked()
> file descriptor read-write using its name if the caller has permissions.
> So I don't see why that case is different.

Again, permissions on the directory.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
