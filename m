Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263466AbTC2VZ1>; Sat, 29 Mar 2003 16:25:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263467AbTC2VZ1>; Sat, 29 Mar 2003 16:25:27 -0500
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:2052 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id <S263466AbTC2VZ0>; Sat, 29 Mar 2003 16:25:26 -0500
From: john@grabjohn.com
Message-Id: <200303292139.h2TLdHsJ000147@81-2-122-30.bradfords.org.uk>
Subject: Re: [TRIVIAL] Cleanup in fs/devpts/inode.c
To: linux-kernel@alex.org.uk
Date: Sat, 29 Mar 2003 21:39:17 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, trivial@rustcorp.com.au
In-Reply-To: <1995917808.1048968853@[192.168.100.5]> from "Alex Bligh - linux-kernel" at Mar 29, 2003 08:14:13 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >> this patch un-complicates a small piece of code of the dev/pts
> >> filesystem and decreases the size of the object code by 8 bytes
> >> for my build. Yay! :)
> >
> >> -		err = PTR_ERR(devpts_mnt);
> >> -		if (!IS_ERR(devpts_mnt))
> >> -			err = 0;
> >> +		if (IS_ERR(devpts_mnt))
> >> +			err = PTR_ERR(devpts_mnt);
> >
> > Why not use
> >
> > err = (IS_ERR(devpts_mnt) ? err = 0 : PTR_ERR(devpts_mnt));
> 
> Perhaps because it inverts the logic, and has a superfluous
> assignment causing a warning? :-)

Good point :-).

> I think you meant:
> 
>   err = IS_ERR(devpts_mnt) ? PTR_ERR(devpts_mnt) : 0;

Yep.

John.
