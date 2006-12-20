Return-Path: <linux-kernel-owner+w=401wt.eu-S964970AbWLTLxt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964970AbWLTLxt (ORCPT <rfc822;w@1wt.eu>);
	Wed, 20 Dec 2006 06:53:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964965AbWLTLxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Dec 2006 06:53:49 -0500
Received: from mail-gw1.sa.eol.hu ([212.108.200.67]:42035 "EHLO
	mail-gw1.sa.eol.hu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964958AbWLTLxs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Dec 2006 06:53:48 -0500
X-Greylist: delayed 533 seconds by postgrey-1.27 at vger.kernel.org; Wed, 20 Dec 2006 06:53:47 EST
To: mikulas@artax.karlin.mff.cuni.cz
CC: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
	(message from Mikulas Patocka on Wed, 20 Dec 2006 10:03:33 +0100
	(CET))
Subject: Re: Finding hardlinks
References: <Pine.LNX.4.64.0612200942060.28362@artax.karlin.mff.cuni.cz>
Message-Id: <E1GwzsI-0004Y1-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 20 Dec 2006 12:44:42 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I've came across this problem: how can a userspace program (such as for 
> example "cp -a") tell that two files form a hardlink? Comparing inode 
> number will break on filesystems that can have more than 2^32 files (NFS3, 
> OCFS, SpadFS; kernel developers already implemented iget5_locked for the 
> case of colliding inode numbers). Other possibilities:
> 
> --- compare not only ino, but all stat entries and make sure that
>  	i_nlink > 1?
>  	--- is not 100% reliable either, only lowers failure probability
> --- create a hardlink and watch if i_nlink is increased on both files?
>  	--- doesn't work on read-only filesystems
> --- compare file content?
>  	--- "cp -a" won't then corrupt data at least, but will create
>  	hardlinks where they shouldn't be.
> 
> Is there some reliable way how should "cp -a" command determine that? 
> Finding in kernel whether two dentries point to the same inode is trivial 
> but I am not sure how to let userspace know ... am I missing something?

The stat64.st_ino field is 64bit, so AFAICS you'd only need to extend
the kstat.ino field to 64bit and fix those filesystems to fill in
kstat correctly.

SUSv3 requires st_ino/st_dev to be unique within a system so the
application shouldn't need to bend over backwards.

Miklos
