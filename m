Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262455AbUKQSRx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262455AbUKQSRx (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Nov 2004 13:17:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262480AbUKQSPl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Nov 2004 13:15:41 -0500
Received: from [32.97.182.141] ([32.97.182.141]:24764 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262491AbUKQSLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Nov 2004 13:11:18 -0500
Date: Wed, 17 Nov 2004 10:11:05 -0800
From: Greg KH <greg@kroah.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: nikita@clusterfs.com, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
Message-ID: <20041117181105.GA28821@kroah.com>
References: <Pine.LNX.4.58.0411151423390.2222@ppc970.osdl.org> <E1CTzKY-0000ZJ-00@dorka.pomaz.szeredi.hu> <84144f0204111602136a9bbded@mail.gmail.com> <E1CU0Ri-0000f9-00@dorka.pomaz.szeredi.hu> <20041116120226.A27354@pauline.vellum.cz> <E1CU3tO-0000rV-00@dorka.pomaz.szeredi.hu> <20041116163314.GA6264@kroah.com> <E1CURx6-0005Qf-00@dorka.pomaz.szeredi.hu> <16795.33515.187015.492860@thebsh.namesys.com> <E1CUU2P-0005g4-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CUU2P-0005g4-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 17, 2004 at 06:56:13PM +0100, Miklos Szeredi wrote:
> 
> > /sys/fs used to exist for for some. Moreover, /sys/fs/foofs/ was added
> > automagically when foofs file system type was registered. But it was
> > ultimately removed, because nobody took the time to fix all races
> > between accessing /sys/fs/foofs/gadget and
> > umount/filesystem-module-unloading. 
> 
> I don't see why this would be any harder for filesystem code than for
> other types of drivers.  Maybe someone can enlighten me.

Think about putting the /sys/sysfs entry into the tree before sysfs has
been fully initialized :)

There are other fun races that Al Viro pointed out dealing with
superblock lifetimes from what I remember.

> Anyway, I can try to clean it up: remove all the racy bits and keep
> what I need (which is mainly just the /sys/fs directory).  Where can I
> find the most recent version of this?

Look through the 2.5 kernel series, it was in there for a while.

But don't really worry about it, just create /sys/fs/ and use it to put
your own stuff in it if you want.  Don't try to recreate the old, buggy
stuff :)

Good luck,

greg k-h
