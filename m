Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129380AbQKJJrS>; Fri, 10 Nov 2000 04:47:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129383AbQKJJrI>; Fri, 10 Nov 2000 04:47:08 -0500
Received: from ausmtp02.au.ibm.COM ([202.135.136.105]:52229 "EHLO
	ausmtp02.au.ibm.com") by vger.kernel.org with ESMTP
	id <S129380AbQKJJq4>; Fri, 10 Nov 2000 04:46:56 -0500
From: bsuparna@in.ibm.com
X-Lotus-FromDomain: IBMIN@IBMAU
To: "David S. Miller" <davem@redhat.com>
cc: aviro@redhat.com, linux-kernel@vger.kernel.org
Message-ID: <CA256993.0034D230.00@d73mta05.au.ibm.com>
Date: Fri, 10 Nov 2000 14:59:27 +0530
Subject: Re: Oddness in i_shared_lock and page_table_lock nesting
	 hierarchies ?
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>Let me save you some time, below is the fix I sent to
>Linus this evening:

Yes it does :-) Thanks.

I had started making changes along similar lines, and then as
I realized all the places it'd affect, I got a little diverted trying to
see if there was a way to do it without having to bring the locks
out of the common insert routines; whether it was possible to
avoid having to hold i_shared_lock and page_table_lock
simultaneously (other than in vmtruncate of course), through a
careful sequencing of steps, since we  really need to serialize
only with truncate and the page stealer (as the mm sem takes
care of most other cases). Unmap does that now as it crosses
multiple objects (unlike the other cases where luckily we just
have one object at a time, which makes it possible to bring
the i_shared_lock to the top).

But it gets kind of complicated and harder to verify correctness
or generalize such an approach.
So your fix looks like a natural and consistent way to do this.

Now I can get back to what I was originally working on when I
hit this :-)

- Suparna



  Suparna Bhattacharya
  Systems Software Group, IBM Global Services, India
  E-mail : bsuparna@in.ibm.com
  Phone : 91-80-5267117, Extn : 2525


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
