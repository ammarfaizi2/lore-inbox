Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267206AbSLEECq>; Wed, 4 Dec 2002 23:02:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267207AbSLEECq>; Wed, 4 Dec 2002 23:02:46 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:58386 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S267206AbSLEECp>; Wed, 4 Dec 2002 23:02:45 -0500
Date: Wed, 4 Dec 2002 20:11:16 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: george anzinger <george@mvista.com>
cc: Jim Houston <jim.houston@ccur.com>,
       Stephen Rothwell <sfr@canb.auug.org.au>,
       LKML <linux-kernel@vger.kernel.org>, <anton@samba.org>,
       "David S. Miller" <davem@redhat.com>, <ak@muc.de>, <davidm@hpl.hp.com>,
       <schwidefsky@de.ibm.com>, <ralf@gnu.org>, <willy@debian.org>
Subject: Re: [PATCH] compatibility syscall layer (lets try again)
In-Reply-To: <3DEECC1E.7F39F553@mvista.com>
Message-ID: <Pine.LNX.4.44.0212042009340.11869-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, george anzinger wrote:
> 
> Once it changes the system call (eax, right), could the new
> call code then just get the parms from the restart_block. 

Agreed.

> I think it would be best to keep this as generic as
> possible, i.e. let the new call code fetch its own
> paramerers from the restart_block.

We could even have one _single_ a generic "restart" system call, and have 
the function pointer for that be in the restart block.

> My question is who sets up these values?  I think you are
> saying it should be the system call.  Is this right?

Whatever system call that return -ERESTART_RESTARTBLOCK, yes.

So it would never get set up at all in the fast path. Only in the error 
case path of a system call that wants to have restarting capabilities.

		Linus

