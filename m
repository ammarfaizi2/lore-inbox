Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261617AbSJDMzy>; Fri, 4 Oct 2002 08:55:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261623AbSJDMzy>; Fri, 4 Oct 2002 08:55:54 -0400
Received: from ns.suse.de ([213.95.15.193]:11023 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S261617AbSJDMzx>;
	Fri, 4 Oct 2002 08:55:53 -0400
To: "Brian F. G. Bidulock" <bidulock@openss7.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: export of sys_call_table
References: <20021003153943.E22418@openss7.org.suse.lists.linux.kernel> <1033682560.28850.32.camel@irongate.swansea.linux.org.uk.suse.lists.linux.kernel> <20021003170608.A30759@openss7.org.suse.lists.linux.kernel> <1033722612.1853.1.camel@localhost.localdomain.suse.lists.linux.kernel> <20021004051932.A13743@openss7.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 04 Oct 2002 15:01:25 +0200
In-Reply-To: "Brian F. G. Bidulock"'s message of "4 Oct 2002 13:23:00 +0200"
Message-ID: <p73k7kyqrx6.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Brian F. G. Bidulock" <bidulock@openss7.org> writes:


> 					   void *dataptr, int band, int flags)
> 	{
> 		int ret =3D -ENOSYS;
> 		read_lock(&streams_call_lock);

I don't think you really want to use any spinlocks this way. They would
make sleeping impossible and you could never legally do a copy_from/to_user
in your system call. And how else would you access dataptr ? 

More likely you want an atomic_inc(&modulecounter) or perhaps a rw
semaphore.

-Andi
