Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbTKTRWC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 12:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262878AbTKTRWC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 12:22:02 -0500
Received: from mail.enyo.de ([212.9.189.167]:56582 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S262859AbTKTRV7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 12:21:59 -0500
Date: Thu, 20 Nov 2003 18:21:43 +0100
To: Jesse Pollard <jesse@cats-chateau.net>
Cc: Valdis.Kletnieks@vt.edu, Daniel Gryniewicz <dang@fprintf.net>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: OT: why no file copy() libc/syscall ??
Message-ID: <20031120172143.GA7390@deneb.enyo.de>
References: <1068512710.722.161.camel@cube> <20031110230055.S10197@schatzie.adilger.int> <20031111085806.GC11435@deneb.enyo.de> <03111209360001.11900@tabby>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <03111209360001.11900@tabby>
User-Agent: Mutt/1.5.4i
From: Florian Weimer <fw@deneb.enyo.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

> > > 	int sys_copy(int fd_src, int fd_dst)
> >
> > Doesn't work.  You have to set the security attributes while you open
> > fd_dst.
> 
> Why? the open for fd_src should have the security attributes (both locally
> and in the file server if networked). Opening fd_dst should SET the security
> attributes desired (again, locally and in the target fileserver).

The default attributes in the new location might be less strict than the
attributes of the source file.

If sys_copy() is just an API to introduce a new copy-on-write hard link,
these problems disappear.  They are only relevant if sys_copy() is
intended to be a generic "copy that file" interface.
