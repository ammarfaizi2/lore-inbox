Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136394AbREDOU5>; Fri, 4 May 2001 10:20:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136395AbREDOUr>; Fri, 4 May 2001 10:20:47 -0400
Received: from colorfullife.com ([216.156.138.34]:8206 "EHLO colorfullife.com")
	by vger.kernel.org with ESMTP id <S136394AbREDOUb>;
	Fri, 4 May 2001 10:20:31 -0400
Message-ID: <3AF2BAA4.E3B6C6B2@colorfullife.com>
Date: Fri, 04 May 2001 16:20:20 +0200
From: Manfred Spraul <manfred@colorfullife.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: expand_stack: small race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

expand_stack is only protected with down_read(&mmap_sem), and thus 2
thread could grow a vma at the same time.

I think the spin_lock(&page_table_lock) should be moved up before the
calculation of grow.

And map_user_kiobuf() doesn't honor VM_LOCKED for VM_GROWSDOWN segments.
Probably it should be switched to find_extend_vma instead of the
do-it-yourself implementation.

--
	Manfred
