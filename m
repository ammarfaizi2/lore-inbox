Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279927AbRKIPdV>; Fri, 9 Nov 2001 10:33:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279930AbRKIPdL>; Fri, 9 Nov 2001 10:33:11 -0500
Received: from colorfullife.com ([216.156.138.34]:18189 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S279927AbRKIPdA>;
	Fri, 9 Nov 2001 10:33:00 -0500
Message-ID: <3BEBF730.86CAE1CC@colorfullife.com>
Date: Fri, 09 Nov 2001 16:33:04 +0100
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.14-pre8 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "David S. Miller" <davem@redhat.com>
CC: jakub@redhat.com, bcrl@redhat.com, torvalds@transmeta.com,
        alan@lxorguk.ukuu.org.uk, arjanv@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] take 2 of the tr-based current
In-Reply-To: <20011108211143.A4797@redhat.com>
		<20011109041327.T4087@devserv.devel.redhat.com>
		<3BEBEE0B.BA1FD7EE@colorfullife.com> <20011109.070312.88700201.davem@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" wrote:
> 
>    From: Manfred Spraul <manfred@colorfullife.com>
>    Date: Fri, 09 Nov 2001 15:54:03 +0100
> 
>    Jakub Jelinek wrote:
>    > If TR register only ever changes during cpu_init, I don't see why you
>    > cannot use const.
> 
>    The task register is only pure, not const.
> 
> As far as what the compiler can see or care about, it is
> const.
>
No. const == never changes.
get_TR changes if a task calls schedule, and return on another cpu.

<<<
+static unsigned get_TR(void) __attribute__ ((pure))
+{
+       unsigned tr;
+       __asm__("str %w0" : "=g" (tr));
+       return tr;
+}
+
+#define smp_processor_id()     ( ((get_TR() >> 3) - __FIRST_TSS_ENTRY)
>> 2 )
<<<
smp_processor_id() is definitively not const.

OTHO 'current' is const.
--
	Manfred
