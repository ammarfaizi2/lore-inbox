Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289844AbSBPDY7>; Fri, 15 Feb 2002 22:24:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290640AbSBPDYu>; Fri, 15 Feb 2002 22:24:50 -0500
Received: from [66.150.46.254] ([66.150.46.254]:8081 "EHLO mail.tvol.net")
	by vger.kernel.org with ESMTP id <S289844AbSBPDYh>;
	Fri, 15 Feb 2002 22:24:37 -0500
Message-ID: <3C6DD0ED.E2D31059@wgate.com>
Date: Fri, 15 Feb 2002 22:24:29 -0500
From: Michael Sinz <msinz@wgate.com>
Organization: WorldGate Communications Inc.
X-Mailer: Mozilla 4.76 [en] (X11; U; FreeBSD 4.5-STABLE i386)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Waltenberg <pwalten@au1.ibm.com>
CC: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: Core dump
In-Reply-To: <OF615DC251.A04042B9-ON4A256B61.007D0561-4A256B61.007D5D7B@au.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Waltenberg wrote:
> 
> Whats to stop someone creating a process (or a nodename) with an inspired
> (tm) name, and trashing or overwriting system files ?
> 
>      %P      The Process ID (current->pid)
>         %U      The UID of the process (current->uid)
>         %N      The command name of the process (current->comm)
>         %H      The nodename of the system (system_utsname.nodename)
>         %%      A "%"
> 
> The flexibility is nice, but can you PROVE it doesn't have holes like that
> ?

Actually - yes.

First, I can not prevent some system admin from making the core pattern
a bad pattern.  For example, a pattern of /usr/bin/%N would be a bad thing (tm)

However, as long as the system admin (who is the person who can set the pattern)
does not do that, the code prevents a rouge name (hostname or command name)
from causing problems.

(I prevent the use of "/" in either the hostname or command name, for example)

I have tried most everything I could think of.  And, since the host name is
usually not setable by non-root, it makes it even less likely.

In fact, with a pattern like /corefiles/%H-%N-%P.core, there is even less
likelyhood that a coredump can cause problems since I can make the /corefiles
partition its own location and thus coredumps will not write to the key
filesystem.

BTW - both FreeBSD and OpenBSD have a simular format (I took my insperation
from FreeBSD, which I always liked better since the default there is %N.core)

> Just about everything we've had with variable logfile names has had holes
> like that. Samba is one of the more recent examples.

The key is to filter certain characters.  Mostly the '/' in any of the
variables.

However, there is always the problem of someone with root access making
a bad setting in the sysctl.  But then, if they have root, they don't
need to set some sysctl in order to cause damage.

-- 
Michael Sinz ---- Worldgate Communications ---- msinz@wgate.com
A master's secrets are only as good as
	the master's ability to explain them to others.
