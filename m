Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269415AbUJLA2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269415AbUJLA2M (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Oct 2004 20:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269404AbUJLA0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Oct 2004 20:26:07 -0400
Received: from rproxy.gmail.com ([64.233.170.202]:19311 "EHLO mproxy.gmail.com")
	by vger.kernel.org with ESMTP id S269400AbUJLAYi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Oct 2004 20:24:38 -0400
Message-ID: <35fb2e59041011172478b0c09@mail.gmail.com>
Date: Tue, 12 Oct 2004 01:24:37 +0100
From: Jon Masters <jonmasters@gmail.com>
Reply-To: jonathan@jonmasters.org
To: =?UTF-8?Q?Olaf_Fr=C4=85czyk?= <olaf@cbk.poznan.pl>
Subject: Re: How to umount a busy filesystem?
Cc: Matthias Schniedermeyer <ms@citd.de>, linux-kernel@vger.kernel.org
In-Reply-To: <1097445655.2235.18.camel@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
References: <1097441558.2235.9.camel@venus> <20041010211208.GA6986@citd.de>
	 <1097445655.2235.18.camel@venus>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 11 Oct 2004 00:00:55 +0200, Olaf Frączyk <olaf@cbk.poznan.pl> wrote:
> On Sun, 2004-10-10 at 23:12, Matthias Schniedermeyer wrote:
> > On 10.10.2004 22:52, Olaf Fr?czyk wrote:
> > > Hi,
> > >
> > > Why I cannot umount filesystem if it is being accessed?
> > > I tried MNT_FORCE option but it doesn't work.
> > >
> > > Killing all processes that access a filesystem is not an option. They
> > > should just get an error when accessing filesystem that is umounted.
> > >
> > > Any idea how to do it?
> >
> > umount -l
> >
> > removes the mount in "lazy"-mode, this way the mount-point "vanishes"

> Thank you.
> But this:
> 1. Does not let the user to remove the media (eg. cdrom).
> 2. Does not flush buffers etc. so the media cannot be safely removed

What you want is the kind of proxy Luke Leighton was talking about in
a recent post to lkml concerning his effort to port FUSE example code
in to kernelspace. In his model you can replace the underlying
filesystem because the user processes are only seeing what you present
through the proxy - so although proxy inodes/superblock/etc. remain
constant, the underlying filesystem might get swapped around or moved
someplace else and the proxy has to work out whether to return errors
or simply block until the backing filesystem is available for use
again once more.

Jon.
