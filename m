Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271819AbRH3JdV>; Thu, 30 Aug 2001 05:33:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272141AbRH3JdL>; Thu, 30 Aug 2001 05:33:11 -0400
Received: from pizda.ninka.net ([216.101.162.242]:24973 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S272140AbRH3JdH>;
	Thu, 30 Aug 2001 05:33:07 -0400
Date: Thu, 30 Aug 2001 02:33:12 -0700 (PDT)
Message-Id: <20010830.023312.58456523.davem@redhat.com>
To: alan@lxorguk.ukuu.org.uk
Cc: viro@math.psu.edu, kmacy@netapp.com, efeingold@mn.rr.com,
        linux-kernel@vger.kernel.org
Subject: Re: Multithreaded core dumps
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <E15cNsX-0000m7-00@the-village.bc.nu>
In-Reply-To: <Pine.GSO.4.21.0108300457270.9879-100000@weyl.math.psu.edu>
	<E15cNsX-0000m7-00@the-village.bc.nu>
X-Mailer: Mew version 2.0 on Emacs 21.0 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Alan Cox <alan@lxorguk.ukuu.org.uk>
   Date: Thu, 30 Aug 2001 10:12:49 +0100 (BST)

   > ... and these dumps are not reliable.  Living thread may modify the
   > contents of dump as it's being written out.  I.e. you are getting
   > false alarms - inconsistent data that was never there.
   
   That is mathematically insoluble. Think about an SMP system, you cannot stop
   the other thread in instantaneously small time

If you mean "at the time the user process trapped", pretty much this
is true.

But it _IS_ possible to capture the other threads with an SMP cross
call at the time the bad condition leading to the dump is detected.

	thread_dont_schedule(t);
	smp_reschedule();
	t->dump_core(t);
	thread_re_schedule(t);

Later,
David S. Miller
davem@redhat.com
