Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132269AbRCVXqC>; Thu, 22 Mar 2001 18:46:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132252AbRCVXoE>; Thu, 22 Mar 2001 18:44:04 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:45578 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132257AbRCVXlz>; Thu, 22 Mar 2001 18:41:55 -0500
Subject: Re: [PATCH] Prevent OOM from killing init
To: mikpe@csd.uu.se (Mikael Pettersson)
Date: Thu, 22 Mar 2001 23:43:57 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk, linux-kernel@vger.kernel.org
In-Reply-To: <200103222335.AAA22466@harpo.it.uu.se> from "Mikael Pettersson" at Mar 23, 2001 12:35:29 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14gEkJ-0003aF-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> >How do you return an out of memory error to a C program that is out of memory
> >due to a stack growth fault. There is actually not a language construct for it
> SIGSEGV.
> Stack overflow for a language like C using standard implementation techniques
> is the same as a page fault while accessing a page for which there is no backing
> store. SIGSEGV is the logical choice, and the one I'd expect on other Unices.

Guess again. You are expanding the stack because you have no room left on it.
You take a fault. You want to report a SIGSEGV. Now where are you
going to put the stack frame ?

SIGSEGV in combination with a preallocated alternate stack maybe, but then you
still need to recover. C++ you can maybe do it with exception handling but
C doesnt really have the structure and longjmp just doesnt cut it.

Alan

