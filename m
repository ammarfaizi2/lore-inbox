Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269117AbUINC5v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269117AbUINC5v (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Sep 2004 22:57:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269150AbUINCza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Sep 2004 22:55:30 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50924 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269135AbUINCxG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Sep 2004 22:53:06 -0400
Date: Tue, 14 Sep 2004 03:53:00 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: Jochen Bern <bern@ti.uni-trier.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: procfs and chroot() ... ?
Message-ID: <20040914025300.GG23987@parcelfarce.linux.theplanet.co.uk>
References: <414649B5.4000701@ti.uni-trier.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <414649B5.4000701@ti.uni-trier.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 14, 2004 at 03:30:29AM +0200, Jochen Bern wrote:
> I'm trying to chroot() a server that needs to read one readonly pseudo 
> file from /proc . I tried to pinpoint my options to do so ...
> 
> -- The alternative to accessing this one pseudo file would be to grant
>    the server access to /dev/kmem ... NOT ... ANY ... BETTER!! 8-}
> -- Mounting two procfs instances (one normal, one inside the chroot())
>    and setting restrictive permissions on the latter makes identical
>    changes to the former. (I assume that'ld be the same for ACLs?)
> -- Deploying SELinux ... will have to do a good deal of reading to
>    even find out what'ld be involved in that ...
> -- Mounting a "second" procfs, chroot()ing into the exact subdir the
>    file is in, and mounting non-procfs stuff (like the etc dir with the
>    configs) *over* the sub-subdirs (ARGH!) would *happen* to rid me of
>    all *writable* pseudo files, but still provide read access to way
>    more info that I'ld want to provide to the server ...
> (- I'll try to Use The Source (tm) so that the server will not close the
>    pseudo file, and does the chroot() itself after opening it, but let's
>    assume for the sake of the argument that I won't succeed in that.)

Egads...

mount --bind /proc/whatever/the/fsck/you/want \
	/home/jail/wherever/the/fsck/you/want/to/see/it

(assuming that jail is in /home/jail and "mountpoint" exists).
