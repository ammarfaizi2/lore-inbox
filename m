Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263561AbUBNX3i (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 14 Feb 2004 18:29:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263564AbUBNX3i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 14 Feb 2004 18:29:38 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:7872 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263561AbUBNX3g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 14 Feb 2004 18:29:36 -0500
Date: Sat, 14 Feb 2004 23:29:35 +0000
From: viro@parcelfarce.linux.theplanet.co.uk
To: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: JFS default behavior
Message-ID: <20040214232935.GK8858@parcelfarce.linux.theplanet.co.uk>
References: <04Feb13.163954est.41760@gpu.utcc.utoronto.ca> <402E3066.1020802@laPoste.net> <20040214154055.GH8858@parcelfarce.linux.theplanet.co.uk> <200402150006.23177.robin.rosenberg.lists@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200402150006.23177.robin.rosenberg.lists@dewire.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 15, 2004 at 12:06:23AM +0100, Robin Rosenberg wrote:
> On Saturday 14 February 2004 16.40, you wrote:
> > The same goes for file names.  Filename is a sequence of bytes, no more and
> > no less.  Anything beyond that belongs to applications.
> 
> Should be a sequence of characters since humans are supposed to use them and
> it should be the same characters wheneve possible regardless of user's locale.
 
> The  "sequence of bytes" idea is a legacy from prehistoric times when byte == character
> was true.

Bullshit.  It has _nothing_ to characters, wide or not.  For system filenames
are opaque.  The only things that have special meanings are:
	octet 0x2f ('/') splits the pathname into components
	"." as a component has a special meaning
	".." as a component has a special meaning.
That's it.  The rest is never interpreted by the kernel.

> Having an iocharset options for all file systems make it backward compatible
> and creates a migration path to UTF-8 as system default locale.

Try to realize that different users CAN HAVE DIFFERENT LOCALES.  On the same
system.  And have files on the same fs.  Moreover, homedirs that used to be
on different filesystems can end up one the same fs.  What iocharset would
you use, then?  Sigh...

Again, there is no such thing as iocharset of filesystem - it varies between
users and users can and do share filesystems.  Think of /home; think of /tmp.

It isn't feasible.  At all.  Just as timezone doesn't belong in kernel, locales
have no place there.
