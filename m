Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265199AbRGENmY>; Thu, 5 Jul 2001 09:42:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265189AbRGENmP>; Thu, 5 Jul 2001 09:42:15 -0400
Received: from t2.redhat.com ([199.183.24.243]:6644 "HELO
	executor.cambridge.redhat.com") by vger.kernel.org with SMTP
	id <S265174AbRGENmH>; Thu, 5 Jul 2001 09:42:07 -0400
Message-ID: <3B446EAE.E216448D@redhat.com>
Date: Thu, 05 Jul 2001 14:42:06 +0100
From: Arjan van de Ven <arjanv@redhat.com>
Reply-To: arjanv@redhat.com
Organization: Red Hat, Inc
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.3-11.3smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Peter Zaitsev <pz@spylog.ru>, linux-kernel@vger.kernel.org
Subject: Re: Is  Swapping on software RAID1 possible  in linux 2.4 ?
In-Reply-To: <1011478953412.20010705152412@spylog.ru>
	 <15172.22988.643481.421716@notabene.cse.unsw.edu.au> <11486070195.20010705172249@spylog.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zaitsev wrote:
> 
> That's why I thought this problem is related to raid1 swapping I'm
> using.

Well there is the potential problem that RAID1 has that it can't avoid
allocating
memory in some occasions, for the 2nd bufferhead. ATARAID raid0 has the
same problem for
now, and there is no real solution to this. You can pre-allocate a bunch
of bufferheads,
but under high load you will run out of those, no matter how many you
pre-allocate.

Of course you can then wait for the "in flight" ones to become available
again, and that is
the best thing I've come up with so far. It would be nice if the 3
subsystems that need such 
bufferheads now (MD RAID1, ATARAID RAID0 and the bouncebuffer(head)
code) could share their 
pool.

Greetings,
   Arjan van de Ven
