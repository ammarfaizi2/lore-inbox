Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751501AbWGaJ06@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751501AbWGaJ06 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 05:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751502AbWGaJ06
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 05:26:58 -0400
Received: from nz-out-0102.google.com ([64.233.162.200]:49578 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751501AbWGaJ05 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 05:26:57 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=googlemail.com;
        h=received:message-id:date:from:to:subject:cc:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=IAQS9Gls3o4RRsuEEidZh+470gvpwhlOGKHLTDxig9YoNYpu7s87DXm3dgoiTvC4g4hCLOYSe9CqRooRq/JRQyVj0Q3DQmjNY/Cd0l2GObNp3mIbdL/Ua6PKR5wH1rk+AXbwMQrxu2FKnJE1aGNzO1IV5DgL2JPmaTJBhmiyaVo=
Message-ID: <1158166a0607310226m5e134307o8c6bedd1f883479c@mail.gmail.com>
Date: Mon, 31 Jul 2006 10:26:55 +0100
From: "Denis Vlasenko" <vda.linux@googlemail.com>
To: reiser@namesys.com
Subject: reiser4: maybe just fix bugs?
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hans,

The reiser4 thread seem to be longer than usual.
Let me, a mere user, add some input.

It looks to me that delay with reiser4 acceptance
is caused by two different things.

First, reiser4 adds those plugins which many FS people
see as belonging to VFS layer rather than to particular FS.

And second, reiser team was a bit lax at fixing bugs.
Not too bad when compared to other FSes, but still.

When singled out, none of these things are bad enough to hold off
inclusion. However, combined impact of _both_ of them
did upset maintainers enough.

Frankly, on the first problem I think that you are right, Hans,
and putting plugins into VFS _now_ makes little sense because
we can't know whether anybody will ever want to have plugins
for some other FS, so requiring reiser people to do all the shuffling _now_
for questionable gain is simply not fair. It can be done later if needed.

It leaves you with the other option: remove the second problem.
Try to fix bugs. Including reiser3 ones.
I'm not saying that you are not doing this at all,
but I distinctly remember that some discussions (about locking
problems IIRC) were "brushed aside" by reiser people instead of plainly
admitting that problem exists and they will work on fixing it.

* What is that story about hash chain size limit?
  Is it present on reiser4 also? Will it be addressed?

For the problems I personally seen:

* I had 3 reiser3 partitions on a 32Mb RAM box, and massive inode
  updates (chown -R) ate all RAM and deadlocked the box.
  You adviced me to reduce journal size. It works,
  but shouldn't reiser do it dynamically on mount if needed?
  Are there any other known oom deadlocks?
* Does reiser still requires 100.00% defect-free media?
* Are there plans for making reiserfsck interface compatible with fsck?
  I mean, making it so that reiserfsck can be symlinked to fsck.reiser
  and it will work? Currently, there seems to be some incompatibility
  in command-line switches. (I will dig out details and send separately
  when I'll get back to my Linux box.)

P.S. I am a reiser3 user on all my boxes.
Thanks Hans for your work.
--
vda
