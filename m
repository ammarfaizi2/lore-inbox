Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311168AbSCHWG3>; Fri, 8 Mar 2002 17:06:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311172AbSCHWGW>; Fri, 8 Mar 2002 17:06:22 -0500
Received: from sproxy.gmx.de ([213.165.64.20]:25681 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S289191AbSCHWGF>;
	Fri, 8 Mar 2002 17:06:05 -0500
Message-ID: <3C893570.767929F9@gmx.de>
Date: Fri, 08 Mar 2002 23:04:32 +0100
From: Edgar Toernig <froese@gmx.de>
MIME-Version: 1.0
To: Doug Siebert <dsiebert@divms.uiowa.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Fast Userspace Mutexes (futex) vs. msem_*
In-Reply-To: <200203080615.g286Fqh24770@server.divms.uiowa.edu>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Siebert wrote:
> 
> I am curious
> though why the case of "what happens if the process holding the lock dies"
> is considered unimportant by some people.  It wouldn't be all that much
> more work to "do it right" (IMHO) and handle this case.

And what is "right"?  You have two problems:

 - The kernel has no idea of how many locks a dying process holds.  The
   kernel only starts to know about a lock when another process has to
   wait for it.

 - Locked data may be in an inconsistent state.  The kernel has no idea
   how to "repair" it.

I once suggested to send a signal to all processes that share a PROT_SEM
page with the dying process[1].  But even then it's pretty difficult for
the other processes to decide which locks were held by the dead one.
You need additional data and handling in userspace for that.  But at
least it would help them to know about the dead and in the unhandled
case it would kill all possibly affected processes.  Doing that in
userspace would require a manager process with all its ugliness.

Ciao, ET.


[1] I've no idea how difficult it would be to find these processes.
