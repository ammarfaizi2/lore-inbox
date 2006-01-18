Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932579AbWARWtz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932579AbWARWtz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jan 2006 17:49:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932578AbWARWtz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jan 2006 17:49:55 -0500
Received: from ns1.suse.de ([195.135.220.2]:31109 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932579AbWARWty (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jan 2006 17:49:54 -0500
Date: Wed, 18 Jan 2006 23:49:53 +0100
From: Jan Blunck <jblunck@suse.de>
To: Kirill Korotaev <dev@sw.ru>
Cc: Olaf Hering <olh@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] Busy inodes after unmount, be more verbose in generic_shutdown_super
Message-ID: <20060118224953.GA31364@hasse.suse.de>
References: <20060116223431.GA24841@suse.de> <43CC2AF8.4050802@sw.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <43CC2AF8.4050802@sw.ru>
"From: jblunck@suse.de"
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 17, Kirill Korotaev wrote:

> Olaf, can you please check if my patch for busy inodes from -mm tree 
> helps you?
> Patch name is fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch
> http://www.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.15/2.6.15-mm4/broken-out/fix-of-dcache-race-leading-to-busy-inodes-on-umount.patch

This patch is just wrong. It is hiding bugs in file systems. The problem is
that somewhere the reference counting on the vfsmount objects is wrong. The
file system is unmounted before the last dentry is dereferenced. Either you
didn't hold a reference to the proper vfsmount objects at all or you
dereference it too early. See Al Viros patch series (search for "namei fixes")
on how to fix this issues.

Regards,
	Jan

-- 
Jan Blunck                                               jblunck@suse.de
SuSE LINUX AG - A Novell company
Maxfeldstr. 5                                          +49-911-74053-608
D-90409 Nürnberg                                      http://www.suse.de
