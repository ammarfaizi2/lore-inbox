Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S137022AbREKCCI>; Thu, 10 May 2001 22:02:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S137023AbREKCB6>; Thu, 10 May 2001 22:01:58 -0400
Received: from intranet.resilience.com ([209.245.157.33]:5076 "EHLO
	intranet.resilience.com") by vger.kernel.org with ESMTP
	id <S137022AbREKCBl>; Thu, 10 May 2001 22:01:41 -0400
Mime-Version: 1.0
Message-Id: <p0510030eb720f425344e@[10.128.7.49]>
In-Reply-To: <Pine.GSO.4.21.0105102001000.3943-100000@weyl.math.psu.edu>
In-Reply-To: <Pine.GSO.4.21.0105102001000.3943-100000@weyl.math.psu.edu>
Date: Thu, 10 May 2001 19:01:16 -0700
To: Alexander Viro <viro@math.psu.edu>
From: Jonathan Lundell <jlundell@pobox.com>
Subject: Re: Not a typewriter
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 8:07 PM -0400 2001-05-10, Alexander Viro wrote:
>On Thu, 10 May 2001, Jonathan Lundell wrote:
>
>>  ENOTTY is used by several non-serial devices (or file systems) to
>>  object to an unrecognized ioctl command. There's also ENOIOCTLCMD
>>  (apparently supposed to be a non-user errno, but i don't see where it
>>  gets changed to something else) and EINVAL. I'm not sure what the
>>  rationale is for choosing among them; perhaps someone would elucidate?
>
>ENOIOCTLCMD is something I've never met in the kernel. Normal reaction
>to unrecognized ioctl() is ENOTTY, for a lot of reasons, starting with
>the fact that ioctls are last-ditch API to be used when you just can't
>think of better one and historically TTY had the earliest (and largest)
>infestation. IOW, "not a tty" used to mean "WTF are you using ioctls here?"
>OTOH, EINVAL is a catch-all thing for "something is wrong with arguments".

That's pretty much what I would have said a couple of hours ago 
before grepping the kernel. Try it, though. ENOTTY is rarely used. 
ENOIOCTLCMD is all over the damned place, though its comment in 
errno.h warns that a user shouldn't see it. And if you browse a bunch 
of random ioctl handlers, you'll see EINVAL used for a bad command 
much more often than ENOTTY.

FWIW, the comment in errno.h under Solaris 2.6 is "Inappropriate 
ioctl for device". I believe that's the POSIX interpretation.
-- 
/Jonathan Lundell.
