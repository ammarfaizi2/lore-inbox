Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261972AbSJVCrw>; Mon, 21 Oct 2002 22:47:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262019AbSJVCrw>; Mon, 21 Oct 2002 22:47:52 -0400
Received: from probity.mcc.ac.uk ([130.88.200.94]:38925 "EHLO
	probity.mcc.ac.uk") by vger.kernel.org with ESMTP
	id <S261972AbSJVCru>; Mon, 21 Oct 2002 22:47:50 -0400
Date: Tue, 22 Oct 2002 03:53:46 +0100
From: John Levon <levon@movementarian.org>
To: Corey Minyard <cminyard@mvista.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] NMI request/release
Message-ID: <20021022025346.GC41678@compsoc.man.ac.uk>
References: <3DB4AABF.9020400@mvista.com> <20021022021005.GA39792@compsoc.man.ac.uk> <3DB4B8A7.5060807@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DB4B8A7.5060807@mvista.com>
User-Agent: Mutt/1.3.25i
X-Url: http://www.movementarian.org/
X-Record: Mr. Scruff - Trouser Jazz
X-Scanner: exiscan *183pAw-000NbV-00*MRdvCVGQjL6* (Manchester Computing, University of Manchester)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 21, 2002 at 09:32:07PM -0500, Corey Minyard wrote:

> This is an NMI, does it really matter?

Yes. Both for oprofile and the NMI watchdog (which was firing awfully
often last time I checked). The handler needs to be as streamlined as
possible.

> dev_name could be removed, although it would be nice for reporting 
> later.

Reporting what ? from where ?

> >Couldn't you modify the notifier code to do the xchg()s (though that's
> >not available on all CPU types ...)
> >
> I don't understand.  The xchg()s are for atomicity between the 
> request/release code and the NMI handler.  How could the notifier code 
> do it?

You are using the xchg()s in an attempt to thread onto/off the list
safely no ?

> >>+#define HAVE_NMI_HANDLER	1

> This is so the user code can know if it's available or not.

If we had that for every API or API change, the kernel would be mostly
HAVE_*. It's either available or it's not. If you're maintaining an
external module, then autoconf or similar is the proper way to check for
its existence.

> >Is it not possible to use linux/rcupdate.h for this stuff ?
>
> I'm not sure.  It looks possible, but remember, this is an NMI, normal 
> rules may not apply.  Particularly, you cannot block or spin waiting for 
> something else, the NMI code has to run.  An NMI can happen at ANY time. 

Believe me, I know :)

> If the rcu code can handle this, I could use it, but I have not looked 
> to see if it can.

If it's possible (and I have no idea, not having looked at RCU at all)
it seems the right way.

regards
john

-- 
"Lots of companies would love to be in our hole."
	- Scott McNealy
