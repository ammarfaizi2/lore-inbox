Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312938AbSGHPqa>; Mon, 8 Jul 2002 11:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315619AbSGHPq3>; Mon, 8 Jul 2002 11:46:29 -0400
Received: from addr-mx01.addr.com ([209.249.147.145]:21765 "EHLO
	addr-mx01.addr.com") by vger.kernel.org with ESMTP
	id <S312938AbSGHPq2>; Mon, 8 Jul 2002 11:46:28 -0400
Subject: Re: simple handling of module removals Re: [OKS] Module removal
From: Daniel Gryniewicz <dang@fprintf.net>
To: Thunder from the hill <thunder@ngforever.de>
Cc: "Richard B. Johnson" <root@chaos.analogic.com>,
       Daniel Phillips <phillips@arcor.de>, Pavel Machek <pavel@ucw.cz>,
       "Stephen C. Tweedie" <sct@redhat.com>, Bill Davidsen <davidsen@tmr.com>,
       Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.44.0207080750510.10105-100000@hawkeye.luckynet.adm>
References: <Pine.LNX.4.44.0207080750510.10105-100000@hawkeye.luckynet.adm>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.7 
Date: 08 Jul 2002 11:48:19 -0400
Message-Id: <1026143302.4840.4.camel@athena.fprintf.net>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Okay, maybe this is a bit naive, but isn't this problem already solved? 
Couldn't we just put a read/write lock on the module, where using is
reading, and removing is writing?  As I understand it, this should
impose little overhead on the use (read) case, and ensure that, when a
context has the remove (write) lock there are no no users (readers) and
cannot be any?

Daniel

On Mon, 2002-07-08 at 09:58, Thunder from the hill wrote:
> Hi,
> 
> Still, we shouldn't lock everything. I could do awful lots of interesting 
> things while the only thing that is being done is to remove a module. It 
> doesn't make sense IMO to lock things that are completely unrelated to 
> modules.
> 
> And BTW, what's so much of an overhead if we tell everyone who tries to 
> mess around with a certain module that he'd better wait until we unloaded 
> it? It could be done like your schedule hack, but cleaner in that respect 
> that those who got nothing to do with the module can keep on running.
> 
> > Good point. Member usecount could be anything. A 'long' isn't the
> > correct pad for all types, but it will probably handle everything that
> > was intended.
> 
> But as I mentioned - atomic_t is changed (e.g. to long long) -> 
> module->pad blows up, because the sizeof(struct module) is different, 
> depending on which part of the union we're using.
> 
> 							Regards,
> 							Thunder
> -- 
> (Use http://www.ebb.org/ungeek if you can't decode)
> ------BEGIN GEEK CODE BLOCK------
> Version: 3.12
> GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
> N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
> e++++ h* r--- y- 
> ------END GEEK CODE BLOCK------

-- 
Recursion n.:
        See Recursion.
                        -- Random Shack Data Processing Dictionary


