Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129946AbRBJGCP>; Sat, 10 Feb 2001 01:02:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130624AbRBJGCG>; Sat, 10 Feb 2001 01:02:06 -0500
Received: from Mail.ubishops.ca ([192.197.190.5]:19725 "EHLO Mail.ubishops.ca")
	by vger.kernel.org with ESMTP id <S129946AbRBJGCA>;
	Sat, 10 Feb 2001 01:02:00 -0500
Message-ID: <3A84D950.899549B4@yahoo.co.uk>
Date: Sat, 10 Feb 2001 01:01:52 -0500
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: kuznet@ms2.inr.ac.ru
Subject: Re: [PATCH] to deal with bad dev->refcnt in unregister_netdevice()
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Here is a patch which may not solve the underlying 
> 
> This does not. refcnt cannot be <1 at this point. 

The refcnt shouldn't be less than 1, but it is in fact
less than 1.  (As I'm sure you understand.)

> > assuming that the latter messages aren't serious? 
> 
> They are fatal. Machine must be rebooted after them. 

True.  I found that with testing---lots of ifups and ifdowns,
etc.---the kernel becomes unstable.

> > I hope the networking gurus can find the real bugs here. 
> 
> Well, someone forgets to grab refcnt or makes redundant dev_put. 
> Try to catch this, f.e. adding BUG() to the places where fatal 
> messages are generated to get backtraces. 
> Alexey

I think that the ipx driver makes an inappropriate dev_put
in its notifier callback.  However that is for people better
acquainted with the come than I to judge.  Removing the ipx
driver does work around the problem though.

Thomas
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
