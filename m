Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311657AbSCNQVH>; Thu, 14 Mar 2002 11:21:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311655AbSCNQUZ>; Thu, 14 Mar 2002 11:20:25 -0500
Received: from 213-98-126-44.uc.nombres.ttd.es ([213.98.126.44]:12672 "HELO
	mitica.trasno.org") by vger.kernel.org with SMTP id <S311654AbSCNQTO>;
	Thu, 14 Mar 2002 11:19:14 -0500
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: pcmcia oops problem?
In-Reply-To: <3C90BA11.40106@mandrakesoft.com>
X-Url: http://www.lfcia.org/~quintela
From: Juan Quintela <quintela@mandrakesoft.com>
In-Reply-To: <3C90BA11.40106@mandrakesoft.com>
Date: 14 Mar 2002 17:16:35 +0100
Message-ID: <m2henjruos.fsf@trasno.mitica>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "jeff" == Jeff Garzik <jgarzik@mandrakesoft.com> writes:

jeff> Can you describe the pcmcia oops problem in detail?
jeff> What output do you get from a serial console?

Ok, trying to get better message now.

jeff> what do you mean, oops got infinite trace?  were there (a) many oops
jeff> or (b) one oops with long trace
jeff> what do you mean, double fix of /dev/XXXXX name?

I think so, but it is not possible to be sure :(

jeff> is pcmcia-cs creating and removing /dev entries too?

Ok, the problem:

plug a pcmcia card (network cards work perfect), ide_cs & modem fail).
unplug it

it just oops the kernel.

as ethX works perfect and modem & ide_cs fails, devfs is suspect
number one.

Then I boot with devfs=nomount

repeat the experiment, and everythnig works as expected (devfs is
decleared more suspect indeed). 

Really devfs & devfsd are suspect.
I know that ide_cs worked before because I used it to download pics
from my camera and I had never had a single problem.

Then I boot back with kernel-linus2.4.

Everything works perfect.

In the middle, I changed devfsd from version 2.3.24 to 2.3.23, same
problems.

kernel-linus2.4 works with both devfsd.

I relaunch kernel-mdk with devfs-2.3.23, this times also oops, but it
just hangs in devfs_unregister, that calls to kmem_cache_alloc(), and
them kmem_cache_grow (here is the Ooops), this is called from a bottom
handler.



With devfsd 2.3.24, it appears that there is a stack overflow inside
devfs, and kdb is of not help to detect it (we never end the do_BUG()
function because there is a borken stack.

I have do a diff of 2.4.18 against lastest mandrake kernel and there
are:
- no devfs differences
- no changes in register/unregister calls.

that means that the problem happens as a side effect of other thing.

Later, Juan.







-- 
In theory, practice and theory are the same, but in practice they 
are different -- Larry McVoy
