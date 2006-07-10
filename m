Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422929AbWGJXA0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422929AbWGJXA0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 19:00:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422925AbWGJXA0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 19:00:26 -0400
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56793 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1422929AbWGJXAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 19:00:24 -0400
Subject: Re: tty's use of file_list_lock and file_move
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Jon Smirl <jonsmirl@gmail.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <9e4733910607101109w46915fbbl19bdd8664e1ca4d@mail.gmail.com>
References: <9e4733910607100810r6e02f69g9a3f6d3d1400b397@mail.gmail.com>
	 <1152552806.27368.187.camel@localhost.localdomain>
	 <9e4733910607101027g5f3386feq5fc54f7593214139@mail.gmail.com>
	 <1152554708.27368.202.camel@localhost.localdomain>
	 <9e4733910607101109w46915fbbl19bdd8664e1ca4d@mail.gmail.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Jul 2006 00:18:20 +0100
Message-Id: <1152573500.27368.215.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.2 (2.6.2-1.fc5.5) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ar Llu, 2006-07-10 am 14:09 -0400, ysgrifennodd Jon Smirl:
> > We hold the ->files->file_lock because we have to walk other processes
> > file tables in a safe fashion in SAK. That one is fairly clear.
> 
> What if do_SAK did something like this?
> 
> copy the tty struct to new_tty
> NULL out the file list in new_tty
> insert new_tty into the array tracking tty minors so that open will
> find the new one

SAK isn't locking against the tty layer ,its locking against the VFS
when it does htis


