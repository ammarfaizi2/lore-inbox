Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313660AbSDEW2l>; Fri, 5 Apr 2002 17:28:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313664AbSDEW2b>; Fri, 5 Apr 2002 17:28:31 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:44305 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S313660AbSDEW2T>; Fri, 5 Apr 2002 17:28:19 -0500
Date: Fri, 5 Apr 2002 14:27:48 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Dave Hansen <haveblue@us.ibm.com>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] shift BKL out of notify_change
In-Reply-To: <3CAE2230.7050705@us.ibm.com>
Message-ID: <Pine.LNX.4.33.0204051420480.2263-100000@penguin.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 5 Apr 2002, Dave Hansen wrote:
> 
> My patch adds a semaphore to the inode structure,

Hmm... I'd really prefer to just use the existing i_sem - umsdos doesn't
work as-is right now anyway, but as far as I can see that's really what
umsdos actually wants anyway (ie then you can just remove the down/up from
the UMSDOS_notify_change() routine).

do_truncate() already does the i_sem thing for its notify_change, and
notify_change() really _is_ equivalent to a write, so this really seems to 
make more sense that way. 

Just move the current down/up pair from do_truncate() into notify_change()
(it also protects the "newattrs" assignment in do_truncate, but that is
purely local data at that point and needs no protection).

		Linus

