Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289138AbSA3Obe>; Wed, 30 Jan 2002 09:31:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289140AbSA3ObY>; Wed, 30 Jan 2002 09:31:24 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:52531 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S289138AbSA3ObL>; Wed, 30 Jan 2002 09:31:11 -0500
To: DervishD <raul@viadomus.com>
Cc: garzik@havoc.gtf.org, linux-kernel@vger.kernel.org
Subject: Re: Why 'linux/fs.h' cannot be included? I *can*...
In-Reply-To: <E16VtWb-0002kV-00@DervishD.viadomus.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 30 Jan 2002 07:27:41 -0700
In-Reply-To: <E16VtWb-0002kV-00@DervishD.viadomus.com>
Message-ID: <m1lmefdici.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD <raul@viadomus.com> writes:

>     Hi Jeff :)
> 
> >>     Given the number of user-space apps that needs ioctl definitions
> >> and things like those (that are supposed not to change easily), those
> >> definitions should go in user-includable headers... IMHO.
> >> 
> >>     Fortunately, we have some of them in libc headers now.
> >The policy is, never ever include kernel headers from userspace.
> 
>     I know, but sometimes it is just impossible (when they aren't
> appropriate glibc headers, for example). In fact, all this question
> arose because I'm coding an 'ioctl' command line interface, so you
> can send any 'documented' ioctl to any device. And, since I'm going
> to start with block devices, I need linux/fs.h.
> 
>     The problem is that I don't want to copy the definitions I need
> from linux/fs.h, because this will lead to problems if those
> definitions change. Anyway this is not an issue, because by changing
> the running kernel those definitions in fact may not be valid...
> 
>     Resuming: I don't know how properly address this problem.

In general you are running into the ioctls are messy problem, and probably
need to be cleaned up.  Beyond that though ioctls should be static
they are part of the kernel ABI.  Though they aren't managed tight
enough that you can count on them being 100% static.

> >Your libc should provide a "sanitized" version of the kernel headers,
> >which is completely separate from any kernel sources.
> 
>     I suppose that those headers will contain definitions not subject
> to change, won't they? But I don't know if I can consider the ioctl
> constants as not subject to change (they should be permanent,
> though).

In general ioctls are not be subject to change.
 
> >So, any problems should be reported to your libc maintainer :)
> 
>     Well, I try... I can even try to make the sanitized header myself
> and pray for it to be included in next glibc revision :)

Not that would be progress..

Eric
