Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267911AbRG3JYS>; Mon, 30 Jul 2001 05:24:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268160AbRG3JYI>; Mon, 30 Jul 2001 05:24:08 -0400
Received: from fandango.cs.unitn.it ([193.205.199.228]:36613 "EHLO
	fandango.cs.unitn.it") by vger.kernel.org with ESMTP
	id <S267911AbRG3JXv>; Mon, 30 Jul 2001 05:23:51 -0400
From: Massimo Dal Zotto <dz@cs.unitn.it>
Message-Id: <200107300912.f6U9CGvE001212@dizzy.dz.net>
Subject: Re: strange problem with reiserfs and /proc fs
In-Reply-To: <20010729171209.D13366@eye-net.com.au> "from Craig Small at Jul
 29, 2001 05:12:09 pm"
To: Craig Small <csmall@eye-net.com.au>
Date: Mon, 30 Jul 2001 11:12:16 +0200 (MEST)
CC: linux-kernel@vger.kernel.org, reiserfs-dev@namesys.com
X-Mailer: ELM [version 2.4ME+ PL89 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> On Sat, Jul 28, 2001 at 10:04:05PM +0200, Massimo Dal Zotto wrote:
> > I've found a strange problem with reiserfs. In some situations it interferes
> > with the /proc filesystem and makes all processes unreadable to top. After
> > a few seconds the situation returns normal. To verify the problem try the
> > following procedure:
> Have to be one of the strangest bugs I've seen.  Makes be a bit lucky
> that reiser will oops on my machine so I cannot use it...
> I have also passed this bug onto the procps author, who may be able to
> shed a bit more light on the problem.
> 
> > 3)	type a few characters and save the file with C-x C-s. After the
> > 	file is saved top will show 0 processes. Sometimes it will show
> > 	only a few processes for an istant and then nothing. Sometimes
> > 	it will work fine. After a few seconds the missing processes
> > 	will show again. Modifying and saving the file again will show
> > 	the same behavior.


I have added some debugging code to ps. I get the following output:

$ /tmp/procps-2.0.7 > ./ps/ps		# ok
  PID TTY          TIME CMD
 5360 pts/1    00:00:00 bash
 5783 pts/1    00:00:33 xterm
10642 pts/1    00:00:00 ps
ps_readproc: !ent

$ /tmp/procps-2.0.7 > ./ps/ps		# error
ps_readproc: stat(/proc/1)=-1
ps_readproc: stat(/proc/2)=-1
ps_readproc: stat(/proc/3)=-1
...
ps_readproc: !ent
  PID TTY          TIME CMD

I have also mounted the procfs on an ext2 partition (with / on reiserfs)
and it gives the same error. It seems that the problem is having / on the
reiserfs.

-- 
Massimo Dal Zotto

+----------------------------------------------------------------------+
|  Massimo Dal Zotto               email: dz@cs.unitn.it               |
|  Via Marconi, 141                phone: ++39-0461534251              |
|  38057 Pergine Valsugana (TN)      www: http://www.cs.unitn.it/~dz/  |
|  Italy                             pgp: see my www home page         |
+----------------------------------------------------------------------+
