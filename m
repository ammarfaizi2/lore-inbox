Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280653AbRKBLJO>; Fri, 2 Nov 2001 06:09:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280654AbRKBLJE>; Fri, 2 Nov 2001 06:09:04 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:41742 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S280653AbRKBLI5>; Fri, 2 Nov 2001 06:08:57 -0500
Date: Fri, 2 Nov 2001 12:08:52 +0100
From: Jan Kara <jack@suse.cz>
To: Wojciech Purczynski <wp@supermedia.pl>
Cc: bugtraq@securityfocus.com, linux-kernel@vger.kernel.org
Subject: Re: Overriding qouta limits in Linux kernel
Message-ID: <20011102120852.A25986@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20011024173533.C10075@atrey.karlin.mff.cuni.cz> <Pine.LNX.4.33.0110270215590.11649-100000@lama.supermedia.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0110270215590.11649-100000@lama.supermedia.pl>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


  Sorry for delayed reply..

> > has a CAP_SYS_RESOURCE capability then it can override the limits (that's
> > how I understand this capability). Hence it's got right to exceed user quota.
> > I think this is reasonable behaviour (root can do anything - suid binaries are
> > just making the will of root ;)).
> >   And BTW I know about no way how to know who opened the file...
> 
> It is ok if suid binaries do what they are privileged to. But it is not ok
> if unprivileged users do what they want using privileges of those suid
> binaries.
  I was thinking about it and you're right that probably exceeding quota by
SUID programs usually isn't behavior which is useful. On the other hand I find
for example testing ability to override quota on open a bit against the design.
The design IMHO is: everytime process wants to allocate some space on disk check
whether he's got right to do so... So quotas aren't per file thing and with this
is connected another technical problem - quota know nothing about who's opened
the file. Everything it's got is an inode and an amount of space current process wants
to allocate to that inode. So it's a problem to make quota code do decissions
based on the opener of the file.

> Controling qouta is not a user-space task. Kernel should perform some
> additional checks before allowing suid binary to write to file descriptor
> that is inherited from unprivileged user process.
  I agree that this is a problem and it has to be solved in kernel.

> Good solution is to check CAP_SYS_RESOURCE process's capability when the
> file descriptor is opened (just like CAP_DAC_OVERRIDE and
> others are checked).
  See above.. It's not that easy...

							Honza
--
Jan Kara <jack@suse.cz>
SuSE CR Labs
