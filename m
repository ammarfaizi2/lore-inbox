Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273789AbRI0SYf>; Thu, 27 Sep 2001 14:24:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273791AbRI0SYZ>; Thu, 27 Sep 2001 14:24:25 -0400
Received: from artax.karlin.mff.cuni.cz ([195.113.31.125]:10246 "EHLO
	artax.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S273789AbRI0SYH>; Thu, 27 Sep 2001 14:24:07 -0400
Date: Thu, 27 Sep 2001 20:24:35 +0200
From: Jan Hudec <bulb@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Suggest TASK_KILLABLE state to overcome most D state trouble
Message-ID: <20010927202435.A19466@artax.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I am develpoing a network filesystem and I come across the problem with
noninteruptible waiting (the same as with NFS). Unfortunately there are
some cases, where waiting interuptibly and returning ERESTARTSYS is
difficult to imposible to do (when upcall is done, it must be remembered,
for the restarted syscall, but the syscall may not get restarted).

I can see 2 ways out for most cases.

The simpler one: add a TASK_KILLABLE state, that would be between INTERUPTIBLE
and NONINTERUPTIBLE. It could be interupted only with SIGKILL (I first thought
SIGSTOP too but that one shouldn't matter). In that case the syscall knows
it's canceled. I think most waiting in D state can be changed to be killable.
Mainly when handling page-fault (which may wait on network, that is even
indefinitely in case of failure). It won't make the system behave very nicely
in case of network failure, but would at least allow killing locked processes.

The more complicated would be to change the signal handling to allow hook
to be called when the syscall won't be restarted so the driver could
get rid of now invalid state information.

Does a patch adding a TASK_KILLABLE state have a chance to get in (in 2.5)?
Or can anybody thik of more elegant solution?

--------------------------------------------------------------------------------
                  				- Jan Hudec `Bulb' <bulb@ucw.cz>
