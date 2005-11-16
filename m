Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030227AbVKPIUq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030227AbVKPIUq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Nov 2005 03:20:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030225AbVKPIUq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Nov 2005 03:20:46 -0500
Received: from 238-193.adsl.pool.ew.hu ([193.226.238.193]:28173 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S1030222AbVKPIUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Nov 2005 03:20:45 -0500
To: a1426z@gawab.com
CC: torvalds@osdl.org, linuxram@us.ibm.com, viro@ftp.linux.org.uk,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
       rob@landley.net
In-reply-to: <200511160835.28636.a1426z@gawab.com> (message from Al Boldi on
	Wed, 16 Nov 2005 08:35:28 +0300)
Subject: Re: [PATCH 12/18] shared mount handling: bind and rbind
References: <E1EZInj-0001Ez-AV@ZenIV.linux.org.uk> <200511152129.04079.rob@landley.net> <Pine.LNX.4.64.0511151948570.13959@g5.osdl.org> <200511160835.28636.a1426z@gawab.com>
Message-Id: <E1EcIVw-0005ZH-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 16 Nov 2005 09:19:32 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > This is why we have "pivot_root()" and "chroot()", which can both be used
> > to do what you want to do. You mount the new root somewhere else, and then
> > you chroot (or pivot-root) to it. And THEN you do 'chdir("/")' to move the
> > cwd into the new root too (and only at that point have you "lost" the old
> > root - although you can actually get it back if you have some file
> > descriptor open to it).
> 
> Wouldn't this constitute a security flaw?
> 
> Shouldn't chroot jail you?

No, chroot should just change the root.

If you don't want to be able to get back the old root, just close all
file descriptors _in addition_ to chroot() and chdir().

Miklos
