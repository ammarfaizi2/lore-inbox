Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263589AbSK0RDs>; Wed, 27 Nov 2002 12:03:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264001AbSK0RDs>; Wed, 27 Nov 2002 12:03:48 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:41691 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S263589AbSK0RDr>;
	Wed, 27 Nov 2002 12:03:47 -0500
From: David Mosberger <davidm@napali.hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15844.64663.864253.832815@napali.hpl.hp.com>
Date: Wed, 27 Nov 2002 09:10:47 -0800
To: "David S. Miller" <davem@redhat.com>
Cc: davidm@hpl.hp.com, davidm@napali.hpl.hp.com, ak@muc.de,
       sfr@canb.auug.org.au, torvalds@transmeta.com,
       linux-kernel@vger.kernel.org, anton@samba.org, schwidefsky@de.ibm.com,
       ralf@gnu.org, willy@debian.org
Subject: Re: [PATCH] Start of compat32.h (again)
In-Reply-To: <20021127.015717.91758081.davem@redhat.com>
References: <15844.31669.896101.983575@napali.hpl.hp.com>
	<20021127082918.GA5227@averell>
	<15844.34389.396428.645047@napali.hpl.hp.com>
	<20021127.015717.91758081.davem@redhat.com>
X-Mailer: VM 7.07 under Emacs 21.2.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Wed, 27 Nov 2002 01:57:17 -0800 (PST), "David S. Miller" <davem@redhat.com> said:

  DaveM> You need to have a different kernel exit path, you need a
  DaveM> different one to chop off the top 32-bits of all the incoming
  DaveM> arguments anyways David.

You conveniently cut of the important part of my message:

	Remember that most compatibility syscalls go straight to the
	64-bit syscall handlers.  You're probably hosed anyhow if a
	64-bit syscall returns, say, 0x1ffffffff, but on ia64 I'd
	still rather play it safe and consistently have all
	compatibility syscalls return a 64-bit sign-extended value
	like all other syscall handlers ("least surprise" principle).

I have zero interest debugging subtle bugs of this sort.  If "long"
isn't an option, we should add a platform-specific compat32_retval_t
or whatever.

	--david
