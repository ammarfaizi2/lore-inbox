Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272014AbTGYKzx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jul 2003 06:55:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272012AbTGYKzr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jul 2003 06:55:47 -0400
Received: from village.ehouse.ru ([193.111.92.18]:49933 "EHLO mail.ehouse.ru")
	by vger.kernel.org with ESMTP id S272011AbTGYKzk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jul 2003 06:55:40 -0400
From: "Sergey S. Kostyliov" <rathamahata@php4.ru>
Reply-To: "Sergey S. Kostyliov" <rathamahata@php4.ru>
To: Andrea Arcangeli <andrea@suse.de>
Subject: Re: 2.4.22pre6aa1
Date: Fri, 25 Jul 2003 15:10:59 +0400
User-Agent: KMail/1.5
References: <200307231521.15897.rathamahata@php4.ru> <20030725052818.GA6440@x30.random>
In-Reply-To: <20030725052818.GA6440@x30.random>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307251510.59062.rathamahata@php4.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andrea,

On Friday 25 July 2003 09:28, you wrote:
> On Wed, Jul 23, 2003 at 03:21:15PM +0400, Sergey S. Kostyliov wrote:
> > Hello Andrea,

<cut>

> hmm, 2.4.22pre6aa1 was the first 2.4 largepages port to the >=22pre
> shmfs backport from 2.5. It could be a bug in 2.5, or a bug present only
> in the backport of the 2.5 code to 22pre, or even a bug only present in
> -aa due the largepage patch ported on top of the backport included in
> 22pre. I'll have a closer look at it tomorrow. The place where it
> crashed is:
>
> 	BUG_ON(inode->i_blocks);
>
> it might be only a minor accounting issue. It needs some auditing.

Thanks for you recponce!
Yes, it seems possible. At least it continue to run just fine after
oops for 2.4.22pre6aa1.
Btw I've managed to get a hard lockup with 2.4.22pre7aa1 in the same
scenario. It just stops responding to even Alt+SysRq+* from keyboard.

>
> I'm afraid you're the first one testing the shmfs backport in 22pre +
> the largepage support patch in my tree with a big app doing swapoff at
> the same time.
>
> Are you using bigpages btw?

No, I'm not using bigpages.

>
> thank you very much for the feedback,
>
> Andrea
>
> PS. shall this give us relevant problems in the debugging/auditing, I'll
> just give you a patch to backout the backport and go back to the shmfs
> code in 2.4.21rc8aa1 that is running rock solid in production with
> largepages (I doubt you need the loop device on top of shmfs anyways). I
> prefer not to spend much time on new 2.4 features.

I doubt it depends on bigpages because they
are not used in my setup. But I can live with that. Rule: do not run
`swapoff -a` under load doesn't sound as impossible in my case (if this
is the only way to trigger this problem). 

-- 
                   Best regards,
                   Sergey S. Kostyliov <rathamahata@php4.ru>
                   Public PGP key: http://sysadminday.org.ru/rathamahata.asc
