Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261505AbSJ1V3h>; Mon, 28 Oct 2002 16:29:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261507AbSJ1V3h>; Mon, 28 Oct 2002 16:29:37 -0500
Received: from smtpout.mac.com ([204.179.120.89]:45294 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id <S261505AbSJ1V3g>;
	Mon, 28 Oct 2002 16:29:36 -0500
Message-ID: <3DBDAE85.B4499B8F@mac.com>
Date: Mon, 28 Oct 2002 22:39:17 +0100
From: Peter Waechtler <pwaechtler@mac.com>
X-Mailer: Mozilla 4.8 [de] (X11; U; Linux 2.4.18-4GB-SMP i686)
X-Accept-Language: de, en
MIME-Version: 1.0
To: Manfred Spraul <manfred@colorfullife.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] unified SysV and Posix mqueues as FS
References: <3DBC1A6B.7020108@colorfullife.com> <3DBC6314.6B8AC5EA@mac.com> <3DBCDF4A.3080709@colorfullife.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Manfred Spraul schrieb:
> 
> Peter Waechtler wrote:
> 
> >I plan to separate the interfaces and just share the message stuff.
> >But time was getting short. :)
> >
> 
> Ok, you plan to rewrite the patch entirely, and what you have posted is
> a placeholder.
> 
> How would the result look like?
> I'm thinking about
> - real syscalls
> - pipefs like filesystem stub, kern-only mounted, not visible for normal
> fs operations.
> - not using the sysv array
> 
> Could you check the sus standard if that is permitted? A child would
> inherit the mqueue on fork().
> 

SuSv3:
[MSG]  The child process shall have its own copy of the message queue 
descriptors of the parent. Each of the message descriptors of the child 
shall refer to the same open message queue description as the 
corresponding message descriptor of the parent. 

> For the locking stuff, the patch should probably depend on the sysv rcu
> patch, it cleans up locking a bit.
> 

Well, I am a victim of "information hiding" ;-)

msq_lock(id) does not lock a queue, it locks/unlocks the whole array.
Forget my post about a deadlock in ipc_addid()
