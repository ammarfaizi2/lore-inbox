Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264780AbUEERQ7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264780AbUEERQ7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 May 2004 13:16:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264782AbUEERQ7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 May 2004 13:16:59 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:30427 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264780AbUEERQv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 May 2004 13:16:51 -0400
Date: Wed, 5 May 2004 18:16:50 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Nikita Danilov <Nikita@Namesys.COM>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH-RFC] code for raceless /sys/fs/foofs/*
Message-ID: <20040505171650.GP17014@parcelfarce.linux.theplanet.co.uk>
References: <16536.61900.721224.492325@laputa.namesys.com> <20040505162802.GN17014@parcelfarce.linux.theplanet.co.uk> <20040505163650.GO17014@parcelfarce.linux.theplanet.co.uk> <1083776930.3622.45.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1083776930.3622.45.camel@lade.trondhjem.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 05, 2004 at 01:08:50PM -0400, Trond Myklebust wrote:
> On Wed, 2004-05-05 at 12:36, viro@parcelfarce.linux.theplanet.co.uk
> wrote:
> 
> > We also allow anyone with sysfs mounted to see which filesystems are currently
> > mounted on the box - again, regardless of being able to see them in the
> > chroot jail/restricted namespace/etc.  It can easily become an issue in
> > setups where such information is sensitive.
> 
> ...but are you *really* likely to be mounting sysfs in a chrooted jail
> or restricted namespace?
> 
> ...and if you do, aren't you more likely to simply 'mount --bind' those
> minimal parts of sysfs that you actually need for the given process that
> is gaoled?

With the way things are going on, I suspect that it will be hard to maintain.
For one thing, more and more is put there.  For another, we certainly _do_
need a way to export per-superblock data and "all or nothing" approach will
be more and more painful as new applications of that show up.

Don't get me wrong - I absolutely agree that there is a need of safe way to
export per-fs data in some way; it is true for NFS, it is about the only
sane way to do online defragmentation, etc.

This is going to be used much wider than reiser4 and as soon as mechanism
goes in we'll see a bunch of applications.  The only real question is what
sort of API would be the right one, and that's why I don't like the solutions
along the lines of "you'll never want to use that in restricted setups".
