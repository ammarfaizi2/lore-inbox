Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261693AbSK0IjG>; Wed, 27 Nov 2002 03:39:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSK0IjG>; Wed, 27 Nov 2002 03:39:06 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:19945 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S261693AbSK0IjF>;
	Wed, 27 Nov 2002 03:39:05 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15844.34389.396428.645047@napali.hpl.hp.com>
Date: Wed, 27 Nov 2002 00:46:13 -0800
To: Andi Kleen <ak@muc.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Linus <torvalds@transmeta.com>,
       LKML <linux-kernel@vger.kernel.org>, anton@samba.org,
       "David S. Miller" <davem@redhat.com>, ak@muc.de, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021127082918.GA5227@averell>
References: <20021127184228.2f2e87fd.sfr@canb.auug.org.au>
	<15844.31669.896101.983575@napali.hpl.hp.com>
	<20021127082918.GA5227@averell>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 27 Nov 2002 09:29:18 +0100, Andi Kleen <ak@muc.de> said:

  Andi> But the 32bit user space surely doesn't care about any garbage
  Andi> in the upper 32bits, no ?

The user-space won't, but the kernel exit path might.  Remember that
most compatibility syscalls go straight to the 64-bit syscall
handlers.  You're probably hosed anyhow if a 64-bit syscall returns,
say, 0x1ffffffff, but on ia64 I'd still rather play it safe and
consistently have all compatibility syscalls return a 64-bit
sign-extended value like all other syscall handlers ("least surprise"
principle).

	--david
