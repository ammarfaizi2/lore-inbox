Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314325AbSGQNgU>; Wed, 17 Jul 2002 09:36:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314584AbSGQNgU>; Wed, 17 Jul 2002 09:36:20 -0400
Received: from cdt1.tz-juelich.de ([195.37.52.66]:64726 "EHLO www.credativ.de")
	by vger.kernel.org with ESMTP id <S314325AbSGQNgT>;
	Wed, 17 Jul 2002 09:36:19 -0400
Date: Wed, 17 Jul 2002 15:40:18 +0200
To: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>
Cc: Debian Development <debian-devel@lists.debian.org>, miquels@cistron.nl
Subject: Minor bug (?) in mountpoint handling in 2.4.18
Message-ID: <20020717134018.GA18869@feivel.credativ.de>
Mail-Followup-To: Linux-Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Debian Development <debian-devel@lists.debian.org>,
	miquels@cistron.nl
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
From: Michael.Meskes@credativ.de (Michael Meskes)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

fs/namespace::do_add_mount() says:

...
/* Refuse the same filesystem on the same mount point */
...

However, it is still possible to mount the same NFS filesystem to the
same mountpoitn several times:

mme@feivel:/.autofs/nfs/home/mme$ sudo mount zwerg:/exports/usr.local
/mnt
Password:
mme@feivel:/.autofs/nfs/home/mme$ sudo mount zwerg:/exports/usr.local
/mnt
mme@feivel:/.autofs/nfs/home/mme$ df|grep mnt
                       8570480   5685768   2449352  70% /mnt
                       8570480   5685768   2449352  70% /mnt

I'm not sure if this really is a bug as technically it does not create a
problem, but I know a lot of users who are pretty confused.

Michael

P.S.: Please CC me on replies.
-- 
Michael Meskes
Michael@Fam-Meskes.De
Go SF 49ers! Go Rhein Fire!
Use Debian GNU/Linux! Use PostgreSQL!
