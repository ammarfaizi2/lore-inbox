Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264526AbTIDCIW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Sep 2003 22:08:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264529AbTIDCIW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Sep 2003 22:08:22 -0400
Received: from mail2-216.ewetel.de ([212.6.122.116]:61135 "EHLO
	mail2.ewetel.de") by vger.kernel.org with ESMTP id S264526AbTIDCIU
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Sep 2003 22:08:20 -0400
To: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NFS] attempt to use V1 mount protocol on V3 server
In-Reply-To: <rPop.1vp.13@gated-at.bofh.it>
References: <rO94.822.25@gated-at.bofh.it> <rPop.1vp.13@gated-at.bofh.it>
Date: Thu, 4 Sep 2003 04:08:17 +0200
Message-Id: <E19ujXl-0002Eb-00@neptune.local>
From: Pascal Schmidt <der.eremit@email.de>
X-CheckCompat: OK
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 04 Sep 2003 01:40:13 +0200, you wrote in linux.kernel:

>   a) Is a feature of the 'mount' program. An NFS server should in any
>      case not rely on the umount being sent: a client may have crashed
>      or been firewalled, or whatever...

Okay. I'm not relying on it, anyway. I had just expected to get a V3
umount call and not a V1 umount call. I could understand the V1 as a
fallback. Seems I have to live with user-space tools calling me for
protocol versions I didn't even register with the portmapper.

>   b) Is a kernel feature which will never trigger if you are passing a
>      correct filehandle from your mountd.

That's assuming all NFSv3 servers do NFSv2 also. I don't. In this case
the bug was in my nfsd who was not recognizing the filehandle coming in
via GETATTR as correct. ;)

So I'll have to live with registering for V1 also and handling umount
there and rejecting mount with an error. Oh well.

Thanks for the explanations!

Oh, BTW, that reminds me: the 2.6.0-test NFS client does not like
FSSTAT returning NFS3ERR_NOTSUPP. When I started coding, I got a hard
lockup of my system due to that, had to press the reset button, not
even Alt-SysRq wanted to work. I couldn't capture the output and
shutting down the system didn't work, plus I could not start any new
processes. Sure, that was a buggy server, but should that lock up
the kernel? Known problem?

I can probably reproduce that since changing my code to return NOTSUPP
again would be easy, if you are interested.

-- 
Ciao,
Pascal
