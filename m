Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261754AbTKHNDQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Nov 2003 08:03:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261757AbTKHNDQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Nov 2003 08:03:16 -0500
Received: from smtprelay02.ispgateway.de ([62.67.200.157]:56989 "EHLO
	smtprelay02.ispgateway.de") by vger.kernel.org with ESMTP
	id S261754AbTKHNDO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Nov 2003 08:03:14 -0500
From: Ingo Oeser <ioe-lkml@rameria.de>
To: Frank Cusack <fcusack@fcusack.com>
Subject: Re: preemption when running in the kernel
Date: Sat, 8 Nov 2003 14:01:59 +0100
User-Agent: KMail/1.5.4
References: <20031107040427.A32421@google.com>
In-Reply-To: <20031107040427.A32421@google.com>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Description: clearsigned data
Content-Disposition: inline
Message-Id: <200311081402.07345.ioe-lkml@rameria.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hi Frank,

[CC'ed lkml to avoid duplicate answers]

On Friday 07 November 2003 13:04, Frank Cusack wrote:
> (2.4 kernel)
>
> When a process is running in the kernel, can it be pre-empted at
> any time?  (Unless you explicity disable preemption.)  I think not,
> because wouldn't it be unsafe to grab a spinlock?  Or does grabbing a
> spinlock disable preemption.  I mean spin_lock(), not spin_lock_irqsave().

While having preemption disabled or while actually holding a spinlock,
preemption is disabled.

Disabling preemption is modifying a count, which must reach 0 again to
have preemption enabled and trigger an reschedule, if needed.

Think of it roughly as a "counter of reasons to not preempt". If there
are no reasons anymore, then we preempt.

> Secondly, can multiple processes be in the kernel at the same time?  I
> think so, that's the reason for the fine grained locks instead of the BKL.
> Or do fine grained locks only serve to allow preemption.

Multiple threads can be in the kernel at the same time and even on
different CPUs. But one thread can be only on one CPU at any time.

Threads are parts of processes, so the same applies for processes, too.


Regards

Ingo Oeser

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)

iD8DBQE/rOlHU56oYWuOrkARAqz9AJ9bi71xchjKUJs8kysa6ePKpk13nwCeL1NB
2ti5dqrV6sQjDNbc/RqOItM=
=rb5C
-----END PGP SIGNATURE-----

