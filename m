Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130422AbRAIOHq>; Tue, 9 Jan 2001 09:07:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129773AbRAIOHb>; Tue, 9 Jan 2001 09:07:31 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:10490 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S130349AbRAIOHG>; Tue, 9 Jan 2001 09:07:06 -0500
Message-ID: <3A5B1CA1.3B7402AE@uow.edu.au>
Date: Wed, 10 Jan 2001 01:13:53 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: John Fremlin <vii@penguinpowered.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unified power management userspace policy
In-Reply-To: <m2lmsld4rk.fsf@boreas.yi.org.> <3A5AED76.B2F60F8D@uow.edu.au>,
		Andrew Morton's message of "Tue, 09 Jan 2001 21:52:38 +1100" <m27l44x239.fsf@boreas.yi.org.>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John Fremlin wrote:
> 
> Hi!
> 
>  Andrew Morton <andrewm@uow.edu.au> writes:
> 
> > Could you please use call_usermodehelper() in this patch
> > rather than exec_usermodehelper()?  I want to kill
> > exec_usermodehelper() sometime.
> 
> The reason I used exec_usermodehelper is that I wanted to waitpid on
> the process to see how it exited. Am I still allowed to do that if it
> runs as a child of keventd?

Oh foo.  I missed that.

In the patch-which-didn't-make-it, yes, it can be called
synchronously.  Or you can be called back with the exit
code when the subprocess exits.  It does all the waitpid
stuff, the signal management, handles chrootedness, etc.
But that's vapourware now.  

In the current implementation of call_usermodehelper(),
it looks like the commentary is incorrect - it returns
a negative error code or the subprocess's pid, but you
can't wait on that because it's parented by keventd.

Sorry for the noise - stick with what you have now.

-
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
