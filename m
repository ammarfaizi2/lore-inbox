Return-Path: <owner-linux-kernel-outgoing@vger.rutgers.edu>
Received: by vger.rutgers.edu via listexpand id <S154901AbPIAUVr>; Wed, 1 Sep 1999 16:21:47 -0400
Received: by vger.rutgers.edu id <S154530AbPIAUU6>; Wed, 1 Sep 1999 16:20:58 -0400
Received: from TSX-PRIME.MIT.EDU ([18.86.0.76]:39056 "HELO tsx-prime.MIT.EDU") by vger.rutgers.edu with SMTP id <S154763AbPIAURK>; Wed, 1 Sep 1999 16:17:10 -0400
Date: Wed, 1 Sep 1999 16:17:07 -0400
Message-Id: <199909012017.QAA18692@tsx-prime.MIT.EDU>
From: "Theodore Y. Ts'o" <tytso@mit.edu>
To: torvalds@transmeta.com
cc: linux-kernel@vger.rutgers.edu
Subject: set_current_state
Address: 1 Amherst St., Cambridge, MA 02139
Phone: (617) 253-8091
Sender: owner-linux-kernel@vger.rutgers.edu


Hi Linus,

When I checked the serial driver integration into 2.3.16, I noticed that
one of the changes was to change 

	current->state = TASK_INTERRUPTIBLE;
to
	set_current_state(TASK_INTERRUPTIBLE);

Looking at the sched.h header file, it's pretty clear that this is there
to protect against race conditions on SMP kernels.  Which makes me
wonder why you only changed that one line, but not all of the other
lines in the driver which set current->state.  Doing a quick grep over
drivers/char/*.c, I see a lot of drivers which still use "current->state
= ... " and some that use "set_current_state(...)"

Are there any circumstances where we should keep the old usage?  Or
should we change them all to use set_current_state()?  And if it's the
latter, would you like a patch which does a global replace of
"current->state = ..." to "set_current_state(...)", either in the serial
driver or in all files in drivers/char/*.c (where most of the old usage
seems to be concentrated).

Thanks!

						- Ted

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.rutgers.edu
Please read the FAQ at http://www.tux.org/lkml/
