Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290503AbSAQWbo>; Thu, 17 Jan 2002 17:31:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290504AbSAQWbg>; Thu, 17 Jan 2002 17:31:36 -0500
Received: from pizda.ninka.net ([216.101.162.242]:44172 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S290503AbSAQWb0>;
	Thu, 17 Jan 2002 17:31:26 -0500
Date: Thu, 17 Jan 2002 14:30:15 -0800 (PST)
Message-Id: <20020117.143015.51703736.davem@redhat.com>
To: balbir_soni@hotmail.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: [BUG] Suspected bug in getpeername and getsockname
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <F255p0VatC6ZUbPHiNK0001e34f@hotmail.com>
In-Reply-To: <F255p0VatC6ZUbPHiNK0001e34f@hotmail.com>
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: "Balbir Singh" <balbir_soni@hotmail.com>
   Date: Thu, 17 Jan 2002 14:11:06 -0800

   The reasons why I wanted to pass the address is length
   is
   
   1. It gives more flexibility for any body implementing
      the protocol specific code.

And you could do what with this flexibility that can't be taken care
of at the top level?

   2. We anyway copy the length in move_addr_to_user, we
      might as well do it in the system call and pass the
      length to the protocol.

Why?  What are you going to DO, read this: _DO_, with the
value?

   3. We can finally copy only the length specified back
      to the  user as we do currently.
   
We already do this in move_addr_to_user.  If we do it in
one place, we don't have to duplicate (and thus risk bugs
in) this logic in the various protocols.

   But, consider a case where a user passes a negative value
   in len.

Now you are totally talking non-sense.  A negative len is
an error (-EINVAL) and move_addr_to_user handles this case
just fine.

   I feel the error should be caught first hand, we should not have
   spent the time and space calling the protocol specific code at all,
   we should catch the error and return immediately.
 ...
   Don't u feel they should be fixed.
   
If you want to move the "if (len < 0) return -EINVAL;" right before
the ->getname() invocation, feel free.  However, this is code
duplication and is error prone.

But either way, this is not an argument at all to move the user len
into the protocols.  YOU DONT NEED TO, and you never will, to
accomplish any legitimate task.

Again the question remains, why would you ever need the user len in
the protocol handlers?  All I am hearing is a bunch of hot air so far
with no real substance.

Franks a lot,
David S. Miller
davem@redhat.com
