Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315559AbSEQKiR>; Fri, 17 May 2002 06:38:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315563AbSEQKiQ>; Fri, 17 May 2002 06:38:16 -0400
Received: from penguin-ext.wise.edt.ericsson.se ([193.180.251.47]:42914 "EHLO
	penguin.wise.edt.ericsson.se") by vger.kernel.org with ESMTP
	id <S315559AbSEQKiP>; Fri, 17 May 2002 06:38:15 -0400
Message-ID: <3CE4DD8C.69C34A1B@uab.ericsson.se>
Date: Fri, 17 May 2002 12:38:04 +0200
From: Sverker Wiberg <Sverker.Wiberg@uab.ericsson.se>
X-Mailer: Mozilla 4.76 [en] (X11; U; SunOS 5.8 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: G Sandine <lkml@laclinux.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: knfsd misses occasional writes
In-Reply-To: <3CE250A5.47F71DF@uab.ericsson.se> <15586.20989.992591.474108@notabene.cse.unsw.edu.au> <3CE38E9D.986ACF7F@uab.ericsson.se> <20020516143441.A4322@laclinux.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

G Sandine wrote:

> [...]and one day the time clock file remained a text file
> but was truncated to zero. All further punch ins/punch outs did not
> record in the truncated file (user names, dates, and times should have
> appended).

Sounds as you've got the file's ownership and perms clobbered. I'll
check if that happens over here as well.

> Deleting and recreating the text file on a client returned
> behavior to normal.  No error messages whatsoever, and it has worked
> fine for two weeks as we watch for the behavior to repeat.

Then we're (cough!) luckier over here, we can recreate the problem in
about an hour. But at least it's nice to know you're no alone.

[To the lkml:]

Over here, we started to log the conversations, and saw the client
opening a file, writing 272 bytes into it (one write), and then closing
it, with the server replying full success all the time. printk()'s in
knfsd and the vfs's generic_write() also reported that 272 bytes had
been successfully written. Yet the file was truncated.

We switched from soft to hard mount: It didn't help. We are now
experimenting with disabling SCSI's disconnect/reconnect feature. Are
there any more straws to grasp at?

/Sverker
