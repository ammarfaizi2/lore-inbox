Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130256AbQKIFKd>; Thu, 9 Nov 2000 00:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130270AbQKIFKX>; Thu, 9 Nov 2000 00:10:23 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:13581 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130256AbQKIFKE>; Thu, 9 Nov 2000 00:10:04 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Persistent module storage - modutils design
Date: 8 Nov 2000 21:09:49 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <8udbit$pne$1@cesium.transmeta.com>
In-Reply-To: <14032.973605093@ocs3.ocs-net> <20001109045247.BE39A8120@halfway.linuxcare.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2000 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20001109045247.BE39A8120@halfway.linuxcare.com.au>
By author:    Rusty Russell <rusty@linuxcare.com.au>
In newsgroup: linux.dev.kernel
> 
> > Modules are loaded before non-root file systems are mounted, damn!
> 
> modules.conf already breaks FHS lib/ badly enough.  Modules loaded
> before /var is mounted won't get persistant data.  Too bad; they
> have to do something sane when it doesn't exist anyway.
> 

Last I checked modules.conf was in /etc, not in /lib.

> 
> > Looks like persistent data has to be stored in /lib/modules/persist (no
> > <version>, see earlier mail).
> 
> You need versions: binary data is too prone to change (proven kernel
> history).  It's the kernel installer's duty to know which ones can be
> safely linked/copied to the new version.
> 
> Otherwise every data change requires a new symbol name: and this will
> happen all the time.
> 

Remember that we cannot rely on ANY form of persistent storage to be
available in the beginning; / may very well be readonly (on a ROM,
say.)  Since that means that we can't rely on writable storage being
available until at least one other filesystem has been mounted, it
might as well be the standard for variable data, i.e. /var.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
