Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288859AbSBMUeI>; Wed, 13 Feb 2002 15:34:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288896AbSBMUd6>; Wed, 13 Feb 2002 15:33:58 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:37900 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S288859AbSBMUds>; Wed, 13 Feb 2002 15:33:48 -0500
Subject: Re: LDT_ENTRIES in ldt.h: why 8192?
To: setha@plaza.ds.adp.com (Seth D. Alford)
Date: Wed, 13 Feb 2002 20:47:41 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org, setha@plaza.ds.adp.com (Seth D. Alford)
In-Reply-To: <20020213121848.A31469@mallard.plaza.ds.adp.com> from "Seth D. Alford" at Feb 13, 2002 12:18:48 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16b6JZ-0006NL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> wondering about an alternate solution.  What would happen if LDT_ENTRIES was
> reduced, to, say, 4096, or 512, instead of 8192?

Some apps using LDT will stop working. Very little actually uses LDT's - the
main ones being wine and the sco 286 emulation software. Its also used by
glibc 2.2 by threads, and due to extremely stupid design considerations
by the glibc 2.3 current snapshots for everything.

Using LDT's has a measurable performance hit on task switching, so good
apps don't use them unless they really need them (eg for a threaded app
there is no other good way to do thread local storage and it is much
cheaper than having different memory maps)

