Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932233AbWA3Lyi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbWA3Lyi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 06:54:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932234AbWA3Lyi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 06:54:38 -0500
Received: from cantor2.suse.de ([195.135.220.15]:64745 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932233AbWA3Lyh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 06:54:37 -0500
Date: Mon, 30 Jan 2006 12:54:36 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060130115435.GA9181@hasse.suse.de>
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru> <20060118224953.GA31364@hasse.suse.de> <43CF6170.3050608@sw.ru> <20060119100443.GD10267@hasse.suse.de> <43CF693D.4020104@sw.ru> <20060120190653.GE24401@hasse.suse.de> <43D4907B.4060801@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43D4907B.4060801@sw.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 23, Kirill Korotaev wrote:

> Jan, I still have not heard a single comment about what's wrong with 
> it... I would really appreciate if you provide me one.
> 

Sorry for the delay. I had to fix a totally bogus patch (mine ;).

The problem with your patch is that it hides too early mntput's. Think about
following situation:

 mntput(path->mnt);   // too early mntput()
 dput(path->dentry);

Assuming that in-between this sequence someone unmounts the file system, your
patch will wait for this dput() to finish before it proceeds with unmounting
the file system. I think this isn't what we want.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
