Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266830AbRGQRV1>; Tue, 17 Jul 2001 13:21:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266868AbRGQRVS>; Tue, 17 Jul 2001 13:21:18 -0400
Received: from [207.8.4.6] ([207.8.4.6]:22857 "HELO djvdesk.interactivesi.com")
	by vger.kernel.org with SMTP id <S266835AbRGQRVE>;
	Tue, 17 Jul 2001 13:21:04 -0400
Date: Mon, 16 Jul 2001 18:44:37 -0500
From: duane voth <duanev@interactivesi.com>
To: "Benjamin C.R. LaHaise" <blah@kvack.org>,
        lkml <linux-kernel@vger.kernel.org>
Subject: bug in asm/rwlock.h?
Message-ID: <20010716184437.A11947@interactivesi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was looking at the symetry in rwlock.h and noticed this:

	#define __build_read_lock_ptr(rw, helper)   \
		asm volatile(LOCK "subl $1,(%0)\n\t" \
		....

	#define __build_read_lock_const(rw, helper)   \
		asm volatile(LOCK "subl $1,%0\n\t" \
		....

	#define __build_write_lock_ptr(rw, helper) \
		asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
		....

	#define __build_write_lock_const(rw, helper) \
		asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",(%0)\n\t" \
		....


Why is %0 used indirectly in __build_write_lock_const?
Shouldn't it be

		asm volatile(LOCK "subl $" RW_LOCK_BIAS_STR ",%0\n\t" \

like in __build_read_lock_const?

It doesn't look like many people use __build_write_lock_const.

duane

