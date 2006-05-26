Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751497AbWEZUhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751497AbWEZUhS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 May 2006 16:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751498AbWEZUhS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 May 2006 16:37:18 -0400
Received: from perninha.conectiva.com.br ([200.140.247.100]:8163 "EHLO
	perninha.conectiva.com.br") by vger.kernel.org with ESMTP
	id S1751497AbWEZUhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 May 2006 16:37:16 -0400
Date: Fri, 26 May 2006 17:37:14 -0300
From: "Luiz Fernando N. Capitulino" <lcapitulino@mandriva.com.br>
To: Neil Brown <neilb@suse.de>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linux v2.6.17-rc5
Message-ID: <20060526173714.378ec5d3@doriath.conectiva>
In-Reply-To: <17526.20029.475148.370873@cse.unsw.edu.au>
References: <Pine.LNX.4.64.0605241902520.5623@g5.osdl.org>
	<20060525132336.7f6ca8af@doriath.conectiva>
	<Pine.LNX.4.64.0605250934220.5623@g5.osdl.org>
	<17526.20029.475148.370873@cse.unsw.edu.au>
Organization: Mandriva
X-Mailer: Sylpheed-Claws 2.2.0 (GTK+ 2.8.17; i586-mandriva-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 26 May 2006 10:39:25 +1000
Neil Brown <neilb@suse.de> wrote:

| On Thursday May 25, torvalds@osdl.org wrote:
| > 
| > 
| > On Thu, 25 May 2006, Luiz Fernando N. Capitulino wrote:
| > > 
| > >  I'm getting this after running 'halt':
| > > 
| > > Halting system...
| > > md: stopping all md devices.
| > > md: md0 switched to read-only mode.
| > > Shutdown: hda
| > > System halted.
| > > BUG: halt/3367, lock held at task exit time!
| > >  [dfe70494] {mddev_find}
| > > .. held by:              halt: 3367 [decf4a90, 118]
| > > ... acquired at:               md_notify_reboot+0x31/0x7f
| > 
| > Sounds like this is due to df5b89b323b922f56650b4b4d7c41899b937cf19, aka 
| > "md: Convert reconfig_sem to reconfig_mutex" by NeilBrown.
| > 
| > Neil? It may well be (and likely is) an old thing, just exposed by the 
| > lock debugging of the new mutexes.
| > 
| > Was it _meant_ to take the lock and hold it? Looks like it might be the
| > 
| > 	ITERATE_MDDEV(mddev,tmp)
| > 		if (mddev_trylock(mddev))
| > 			do_md_stop (mddev, 1);
| > 
| > (maybe it should release the lock after the md_stop?)
| > 
| > 		Linus
| 
| Yes.  Keith Owens hit this earlier and I have this patch in my
| queue.  It has been confirmed to fix the problem.

 It really does, thanks a lot.

-- 
Luiz Fernando N. Capitulino
