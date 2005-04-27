Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261839AbVD0RkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261839AbVD0RkF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Apr 2005 13:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261842AbVD0Rjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Apr 2005 13:39:46 -0400
Received: from rev.193.226.232.93.euroweb.hu ([193.226.232.93]:22437 "EHLO
	dorka.pomaz.szeredi.hu") by vger.kernel.org with ESMTP
	id S261841AbVD0Riv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Apr 2005 13:38:51 -0400
To: mj@ucw.cz
CC: lmb@suse.de, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-reply-to: <20050427164652.GA3129@ucw.cz> (message from Martin Mares on Wed,
	27 Apr 2005 18:46:52 +0200)
Subject: Re: [PATCH] private mounts
References: <20050426131943.GC2226@openzaurus.ucw.cz> <E1DQQ73-0000Zv-00@dorka.pomaz.szeredi.hu> <20050426201411.GA20109@elf.ucw.cz> <E1DQiEa-0001hi-00@dorka.pomaz.szeredi.hu> <20050427092450.GB1819@elf.ucw.cz> <E1DQjzY-0001no-00@dorka.pomaz.szeredi.hu> <20050427143126.GB1957@mail.shareable.org> <E1DQno0-00029a-00@dorka.pomaz.szeredi.hu> <20050427153320.GA19065@atrey.karlin.mff.cuni.cz> <20050427155022.GR4431@marowsky-bree.de> <20050427164652.GA3129@ucw.cz>
Message-Id: <E1DQqUi-0002Pt-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Wed, 27 Apr 2005 19:38:40 +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > It is certainly an information leak not otherwise available. And with
> > the ability to change the layout underneath, you might trigger bugs in
> > root programs: Are they really capable of seeing the same filename
> > twice, or can you throw them into a deep recursion by simulating
> > infinitely deep directories/circular hardlinks...?
> 
> Yes, it can help you trigger bugs, but all these bugs are triggerable
> without user filesystems as well, although it's harder to do so.

It's not just triggering bugs.  You have very fine control over what
you present in your filesystem.  Examples are huge files, huge
directories, operations that complete slowly or never at all.

Is it possible to limit all these from kernelspace?  Probably yes,
although a timeout for operations is something that cuts either way.
And the compexity of these checks would probably be orders of
magnitude higher then the check we are currently discussing.

So this check _is_ needed on systems where the users cannot be trusted.

Thanks,
Miklos
