Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262883AbTDRGfq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Apr 2003 02:35:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262885AbTDRGfq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Apr 2003 02:35:46 -0400
Received: from webhosting.rdsbv.ro ([213.157.185.164]:41949 "EHLO
	hosting.rdsbv.ro") by vger.kernel.org with ESMTP id S262883AbTDRGfo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Apr 2003 02:35:44 -0400
Date: Fri, 18 Apr 2003 09:47:21 +0300 (EEST)
From: Catalin BOIE <util@deuroconsult.ro>
To: jamal <hadi@cyberus.ca>
cc: Catalin BOIE <util@deuroconsult.ro>,
       Manfred Spraul <manfred@colorfullife.com>,
       Tomas Szepe <szepe@pinerecords.com>, linux-kernel@vger.kernel.org,
       netdev@oss.sgi.com, kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] qdisc oops fix
In-Reply-To: <20030417065352.S6710@shell.cyberus.ca>
Message-ID: <Pine.LNX.4.53.0304180947060.11335@hosting.rdsbv.ro>
References: <20030415084706.O1131@shell.cyberus.ca>
 <Pine.LNX.4.53.0304160838001.25861@hosting.rdsbv.ro> <20030416072952.E4013@shell.cyberus.ca>
 <3E9D755A.8060601@colorfullife.com> <20030416142802.E5912@shell.cyberus.ca>
 <Pine.LNX.4.53.0304170844410.23586@hosting.rdsbv.ro> <20030417065352.S6710@shell.cyberus.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Ok, I stand corrected. Tomas is right- same problem. You had htb loaded
> as a module, the other person had it compiled in ;->
> Get yourself upgraded ;->
I surely will!

>
> cheers,
> jamal
>
> On Thu, 17 Apr 2003, Catalin BOIE wrote:
>
> > > Catalin, Can you what kernel that is?
> >
> > 2.4.20pre10 works ok but 2.4.20 crash.
> > With traffic -> no crash with 2.4.20. Without traffic, on other machine,
> > no crash.
> >
> >
> > > > It's triggered, because someone does something like
> > > >     spin_lock_bh(&my_lock);
> > > >     p = kmalloc(,GFP_KERNEL);
> > > >
> > > > I don't like the proposed fix: usually code that calls
> > > > kmalloc(,GFP_KERNEL) assumes that it runs at process space, e.g. uses
> > > > semaphores, or non-bh spinlocks, etc.
> > > > slab just happens to contain a test that complains about illegal calls.
> > >
> > > ok. Nice.
> > >
> > > >
> > > > >>Trace; c0127e0f <kmalloc+eb/110>
> > > > >>Trace; c01d3cac <qdisc_create_dflt+20/bc>
> > > > >>Trace; d081ecc7 <END_OF_CODE+1054ff0f/????>
> > > > >>Trace; c01d5265 <tc_ctl_tclass+1cd/214>
> > > > >>Trace; d0820600 <END_OF_CODE+10551848/????>
> > > > >>Trace; c01d27e4 <rtnetlink_rcv+298/3bc>
> > > > >>Trace; c01d0605 <__neigh_event_send+89/1b4>
> > > > >>Trace; c01d7cd4 <netlink_data_ready+1c/60>
> > > > >>Trace; c01d7730 <netlink_unicast+230/278>
> > > > >>Trace; c01d7b73 <netlink_sendmsg+1fb/20c>
> > > > >>Trace; c01c79d5 <sock_sendmsg+69/88>
> > > > >>Trace; c01c8b48 <sys_sendmsg+18c/1e8>
> > > > >>Trace; c0120010 <map_user_kiobuf+8/f8>
> > > > >>
> > > > >>
> > > > >>
> > > > >>
> > > > I don't understand the backtrace. Were any modules loaded? Perhaps
> > > > 0xd081ecc7 is a module.
> > > >
> > >
> > > Probably a module. Again Catalin, run no modules.
> > It's a production machine. I cannot test this. We plan to replace the
> > machine, so I can test then.
> >
> > > > I'd add a
> > > >     if(in_interrupt()) show_stack(NULL);
> > > > into qdisc_create_dflt(), and try to reproduce the bug without modules.
> > > >
> > >
> > > Catalin - again instead of your fix can you please add this call?
> > See above. I cannot test now. I'm very sorry!
> >
> > > cheers,
> > > jamal
> > >
> >
> > ---
> > Catalin(ux) BOIE
> > catab@deuroconsult.ro
> >
> >
>

---
Catalin(ux) BOIE
catab@deuroconsult.ro
