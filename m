Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290481AbSAQWLe>; Thu, 17 Jan 2002 17:11:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290486AbSAQWLY>; Thu, 17 Jan 2002 17:11:24 -0500
Received: from f255.law11.hotmail.com ([64.4.16.130]:39954 "EHLO hotmail.com")
	by vger.kernel.org with ESMTP id <S290481AbSAQWLM>;
	Thu, 17 Jan 2002 17:11:12 -0500
X-Originating-IP: [156.153.254.2]
From: "Balbir Singh" <balbir_soni@hotmail.com>
To: davem@redhat.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
Date: Thu, 17 Jan 2002 14:11:06 -0800
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Message-ID: <F255p0VatC6ZUbPHiNK0001e34f@hotmail.com>
X-OriginalArrivalTime: 17 Jan 2002 22:11:06.0738 (UTC) FILETIME=[DC499520:01C19FA3]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Actually, you are correct about that.

The reasons why I wanted to pass the address is length
is

1. It gives more flexibility for any body implementing
   the protocol specific code.
2. We anyway copy the length in move_addr_to_user, we
   might as well do it in the system call and pass the
   length to the protocol.
3. We can finally copy only the length specified back
   to the  user as we do currently.

I correct my self, it is not a BUG.

But, consider a case where a user passes a negative value
in len. The system call calls the protocol specific
code and then later at the end in move_addr_to_user()
catches the error. I feel the error should be
caught first hand, we should not have spent the
time and space calling the protocol specific code at all,
we should catch the error and return immediately.

I feel there are several instances of this in the
socket system calls.

Don't u feel they should be fixed.

Balbir



>If move_addr_to_user() takes care of all of the issues, there is no
>reason for the protocol specific code to know anything about the
>user's len at all.
>
>You have to show me a purpose for it to get passed down.  What would
>it get used for?  All the protocol specific could should (and does)
>do is provide the data back to the top level routine and
>move_addr_to_user() takes care of the remaining details.




_________________________________________________________________
Send and receive Hotmail on your mobile device: http://mobile.msn.com

