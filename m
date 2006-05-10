Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751042AbWEJJWh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751042AbWEJJWh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 05:22:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbWEJJWh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 05:22:37 -0400
Received: from ecfrec.frec.bull.fr ([129.183.4.8]:39107 "EHLO
	ecfrec.frec.bull.fr") by vger.kernel.org with ESMTP
	id S1751041AbWEJJWg convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 05:22:36 -0400
Date: Wed, 10 May 2006 11:26:51 +0200
From: =?ISO-8859-1?Q?S=E9bastien_Dugu=E9?= <sebastien.dugue@bull.net>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>
Subject: [RFC][PATCH RT 0/2] futex priority based wakeup
Message-ID: <20060510112651.24a36e7b@frecb000686>
X-Mailer: Sylpheed-Claws 1.0.5 (GTK+ 1.2.10; i486-pc-linux-gnu)
Mime-Version: 1.0
X-MIMETrack: Itemize by SMTP Server on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 11:25:32,
	Serialize by Router on ECN002/FR/BULL(Release 5.0.12  |February 13, 2003) at
 10/05/2006 11:25:35,
	Serialize complete at 10/05/2006 11:25:35
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



  Hi,

  in the current futex implementation, tasks are woken up in FIFO order,
(i.e. in the order they were put to sleep). For realtime systems needing
system wide strict realtime priority scheduling, tasks should be woken up
in priority order.

  This patchset achieves this by changing the futex hash bucket list into
a plist. Tasks waiting on a futex are enqueued in this plist based on
their priority so that they can be woken up in priority order.

  The 1st patch is a small optimization to futex_requeue() which could
go into mainline and does not depend on the RT patch.

  The 2nd patch does the real job of converting the futex hash bucket list
into a plist.
  There is however a drawback with this patch in that it is not possible to use
CONFIG_DEBUG_PI_LIST as the plist debugging code expects the spinlock protecting
the plist to be a raw_spinlock while the futex hash bucket lock is a regular
spinlock (rt-mutex). Maybe the plist debugging checks could be made generic to
accept both types.

  Any thoughts?

  Comments welcomed.

  Sébastien.



-----------------------------------------------------

  Sébastien Dugué                BULL/FREC:B1-247
  phone: (+33) 476 29 77 70      Bullcom: 229-7770

  mailto:sebastien.dugue@bull.net

  Linux POSIX AIO: http://www.bullopensource.org/posix
                   http://sourceforge.net/projects/paiol
  
-----------------------------------------------------
