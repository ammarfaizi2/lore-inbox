Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263496AbRFMOCA>; Wed, 13 Jun 2001 10:02:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263740AbRFMOBu>; Wed, 13 Jun 2001 10:01:50 -0400
Received: from pizda.ninka.net ([216.101.162.242]:59813 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S263496AbRFMOBl>;
	Wed, 13 Jun 2001 10:01:41 -0400
From: "David S. Miller" <davem@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15143.29246.712747.936864@pizda.ninka.net>
Date: Wed, 13 Jun 2001 07:01:34 -0700 (PDT)
To: Keith Owens <kaos@ocs.com.au>
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [patch] 2.4.6-pre3 unresolved symbol do_softirq 
In-Reply-To: <9878.992440685@ocs4.ocs-net>
In-Reply-To: <15143.22734.747077.588558@pizda.ninka.net>
	<9878.992440685@ocs4.ocs-net>
X-Mailer: VM 6.75 under 21.1 (patch 13) "Crater Lake" XEmacs Lucid
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Keith Owens writes:
 > It works for integers but call do_softirq is more of a problem.  I
 > could not find an asm constraint that generated correct code in a
 > single instruction.  The closest I could get was
 >   __asm__("call *%%eax" : : "a" (do_softirq));
 > The 'obvious'
 >   __asm__("call %0" : : "m" (do_softirq));
 > calls to a location that contains the address of do_softirq, oops.
 > 
 > Any other architectures that call do_softirq inside asm would need
 > similar hard coding of indirect branches.  It is simpler to export
 > do_softirq with no version, and have cleaner asm.

Why doesn't this work on x86?

#define my_symbol	my_symbol_versioned
extern void my_symbol(void);

__asm__("call %0" : : "i" (my_symbol));

Later,
David S. Miller
davem@redhat.com
