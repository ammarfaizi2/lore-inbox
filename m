Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264221AbRFHQyA>; Fri, 8 Jun 2001 12:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264244AbRFHQxt>; Fri, 8 Jun 2001 12:53:49 -0400
Received: from zeus.kernel.org ([209.10.41.242]:46989 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S264240AbRFHQxh>;
	Fri, 8 Jun 2001 12:53:37 -0400
Date: Fri, 8 Jun 2001 18:08:46 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
Reply-To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ivan Kokshaysky <ink@jurassic.park.msu.ru>
cc: Tom Vier <tmv5@home.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        linux-kernel@vger.kernel.org
Subject: Re: [patch] Re: Linux 2.4.5-ac6
In-Reply-To: <20010608181612.A561@jurassic.park.msu.ru>
Message-ID: <Pine.GSO.3.96.1010608172843.18837A-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jun 2001, Ivan Kokshaysky wrote:

> No. I've changed in load_aout_binary() set_personality(PER_LINUX) to
> set_personality(PER_LINUX_32BIT), and now I have another error.
> You will laugh, but...
> 
> $ netscape
> 665:/usr/lib/netscape/netscape-communicator: : Fatal Error: mmap available address is not larger than requested
> 
> This happens after
> mmap(0x7fdc8000, 40960, PROT_READ|PROT_WRITE|PROT_EXEC, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40018000
> 
> And note, this is the message from loader, not from netscape itself.

 Oh well, so they cheat -- they claim in their docs the kernel may choose
whatever address it considers appropriate and then rely on particular
behaviour.  What for, I wonder...  I guess they weren't able to resolve
signedness issues...

> So I think my second patch is an easiest solution for now.
> Look, compared with the code in Linus' tree:
> - it doesn't add any overhead in general case (addr == 0);
> - if the specified address is too high and we can't find a free
>   area above it, we just continue search from TASK_UNMAPPED_BASE
>   as usual; 
> - if address is too low, extra cost is only compare and taken branch.

 That's all fine, but...

> I think it's clean enough.

 Still it has two loops...  I'm not sure how to eliminate one of them at
the moment, though.  I think we might also consider moving the
compatibility crap into arch/alpha/kernel. 

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

