Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261827AbVD0Rem@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261827AbVD0Rem (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:34:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261835AbVD0ReY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:34:24 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:20645 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261827AbVD0ReO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:34:14 -0400
To: lmb@suse.de
CC: mj@ucw.cz, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20050427155022.GR4431@marowsky-bree.de> (message from Lars
	Marowsky-Bree on Wed, 27 Apr 2005 17:50:22 +0200)
Subject: Re: [PATCH] private mounts
References: <20050426094727.GA30379@infradead.org> <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de>
Message-Id: <E1DQqQ0-0002PB-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 19:33:48 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It is certainly an information leak not otherwise available. And with
> the ability to change the layout underneath, you might trigger bugs in
> root programs: Are they really capable of seeing the same filename
> twice, or can you throw them into a deep recursion by simulating
> infinitely deep directories/circular hardlinks...?

Circular or otherwise hardlinked directories are not allowed since it
would not only confuse applications but the VFS as well.

Hmm, looking at the code it seems that for some reason I removed this
check from the 2.6 version of FUSE.  Stupid me!

Thanks for the reminder :)

> Certainly a useful tool for hardening applications, but I can see the
> point of not wanting to let unwary applications run into a namespace
> controlled by a user. Of course, this is sort-of similar to "find
> -xdev", but I'm not sure whether it is not indeed new behaviour.

A trivial DoS against any process entering the userspace filesystem is
just not to answer the filesystem request.

So it's not just information leak, but also a fine way to _control_
certain behavior of applications.

Thanks,
Miklos
