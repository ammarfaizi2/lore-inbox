Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279644AbRJ0ArL>; Fri, 26 Oct 2001 20:47:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279648AbRJ0Aqu>; Fri, 26 Oct 2001 20:46:50 -0400
Received: from lama.supermedia.pl ([212.75.96.18]:19725 "EHLO
	lama.supermedia.pl") by vger.kernel.org with ESMTP
	id <S279644AbRJ0Aqr>; Fri, 26 Oct 2001 20:46:47 -0400
Date: Sat, 27 Oct 2001 02:47:11 +0200 (CEST)
From: Wojciech Purczynski <wp@supermedia.pl>
To: Jan Kara <jack@suse.cz>
cc: <bugtraq@securityfocus.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Overriding qouta limits in Linux kernel
In-Reply-To: <20011024173533.C10075@atrey.karlin.mff.cuni.cz>
Message-ID: <Pine.LNX.4.33.0110270215590.11649-100000@lama.supermedia.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> has a CAP_SYS_RESOURCE capability then it can override the limits (that's
> how I understand this capability). Hence it's got right to exceed user quota.
> I think this is reasonable behaviour (root can do anything - suid binaries are
> just making the will of root ;)).
>   And BTW I know about no way how to know who opened the file...

It is ok if suid binaries do what they are privileged to. But it is not ok
if unprivileged users do what they want using privileges of those suid
binaries.

Controling qouta is not a user-space task. Kernel should perform some
additional checks before allowing suid binary to write to file descriptor
that is inherited from unprivileged user process.

Good solution is to check CAP_SYS_RESOURCE process's capability when the
file descriptor is opened (just like CAP_DAC_OVERRIDE and
others are checked).

_________________________________________________________________
 Wojciech Purczyñski | Security Officer | http://cliph.linux.pl/
-----------------------------------------------------------------
 Murphy's law says that there is always one more bug...
          ...but he forgot to mention whether it is exploitable.




