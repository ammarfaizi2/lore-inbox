Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932286AbWA3OVk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932286AbWA3OVk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 09:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932287AbWA3OVk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 09:21:40 -0500
Received: from cantor2.suse.de ([195.135.220.15]:24460 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932286AbWA3OVk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 09:21:40 -0500
Date: Mon, 30 Jan 2006 15:21:40 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060130142140.GE9181@hasse.suse.de>
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru> <20060119100443.GD10267@hasse.suse.de> <43CF693D.4020104@sw.ru> <20060120190653.GE24401@hasse.suse.de> <43D4907B.4060801@sw.ru> <20060130115435.GA9181@hasse.suse.de> <43DE1D28.1030100@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43DE1D28.1030100@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 30, Kirill Korotaev wrote:

> >
> > mntput(path->mnt);   // too early mntput()
> > dput(path->dentry);
> >
> >Assuming that in-between this sequence someone unmounts the file system, 
> >your
> >patch will wait for this dput() to finish before it proceeds with 
> >unmounting
> >the file system. I think this isn't what we want.
> No, it won't wait for anything, because if umount happened between 
> mntput/dput, dentry is not in s_dshrinkers list.
> if umount happens in parallell with dput() (where shrinker operations 
> are), then it will behave ok - will wait for dput() and then umount. It 
> was intended behaviour!

It should not wait.

> 
> Also, please, note that such early mntput()'s are bugs!!! because such 
> dentries can reference freed memory after last mntput(). And I remember 
> some patches in 2.4.x/2.6.x which fixed this sequence everywhere.

Thats why I'm complaining ...

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
