Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbUKUL3w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbUKUL3w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 21 Nov 2004 06:29:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261944AbUKUL3w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 21 Nov 2004 06:29:52 -0500
Received: from mail.euroweb.hu ([193.226.220.4]:8643 "HELO mail.euroweb.hu")
	by vger.kernel.org with SMTP id S261587AbUKUL3q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 21 Nov 2004 06:29:46 -0500
To: bulb@ucw.cz
CC: pavel@ucw.cz, akpm@osdl.org, torvalds@osdl.org,
       linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
In-reply-to: <20041121103956.GW2870@vagabond> (message from Jan Hudec on Sun,
	21 Nov 2004 11:39:56 +0100)
Subject: Re: [PATCH] [Request for inclusion] Filesystem in Userspace
References: <E1CToBi-0008V7-00@dorka.pomaz.szeredi.hu> <20041117190055.GC6952@openzaurus.ucw.cz> <E1CUVkG-0005sV-00@dorka.pomaz.szeredi.hu> <20041117204424.GC11439@elf.ucw.cz> <E1CUhTd-0006c8-00@dorka.pomaz.szeredi.hu> <20041118144634.GA7922@openzaurus.ucw.cz> <E1CVmN5-0007qq-00@dorka.pomaz.szeredi.hu> <20041121095038.GV2870@vagabond> <E1CVp0g-0008Cw-00@dorka.pomaz.szeredi.hu> <20041121103956.GW2870@vagabond>
Message-Id: <E1CVpuQ-0008Fl-00@dorka.pomaz.szeredi.hu>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Sun, 21 Nov 2004 12:29:34 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> Measured under what conditions?

  dorka:/home/miko/fuse-bugfix# touch /tmp/fusenull
  dorka:/home/miko/fuse-bugfix# example/null  /tmp/fusenull
  dorka:/home/miko/fuse-bugfix# time dd if=/dev/zero of=/tmp/fusenull bs=4096 count=262144
  262144+0 records in
  262144+0 records out
  1073741824 bytes transferred in 12.591578 seconds (85274604 bytes/sec)
  
  real    0m12.662s
  user    0m0.189s
  sys     0m8.156s
  dorka:/home/miko/fuse-bugfix# fusermount -u /tmp/fusenull

fusenull is a /dev/null like filesystem implemented with the libfuse
API (see fuse sources).

> There may be only one dirty page in the whole system and it may be the
> one backed by FUSE. Now yes, if it was not backed by FUSE, I would be in
> trouble -- but the OOM killer would get me out. It will *NOT* get me out
> with fuse, because it thinks the page will be cleaned, which it won't.

OK, I see your point.  But can't the memory subsystem be tought, that
those pages are not guaranteed to be written back in a limited time?

Miklos
