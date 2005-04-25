Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262730AbVDYSsn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVDYSsn (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 14:48:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262727AbVDYSsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 14:48:43 -0400
Received: from fire.osdl.org ([65.172.181.4]:18916 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262726AbVDYSsk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 14:48:40 -0400
Date: Mon, 25 Apr 2005 11:50:29 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Matthias-Christian Ott <matthias.christian@tiscali.de>
cc: git@vger.kernel.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH GIT 0.6] make use of register variables & size_t
In-Reply-To: <426D33BA.8040604@tiscali.de>
Message-ID: <Pine.LNX.4.58.0504251147290.18901@ppc970.osdl.org>
References: <426CD1F1.2010101@tiscali.de> <Pine.LNX.4.58.0504250751330.18901@ppc970.osdl.org>
 <426D21FE.3040401@tiscali.de> <Pine.LNX.4.58.0504251021280.18901@ppc970.osdl.org>
 <426D33BA.8040604@tiscali.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 Apr 2005, Matthias-Christian Ott wrote:
>
> But this makes, like "register", direct use of processor registers (it
> stores int arguments in eax, ebx, etc.).

No. It make _unlike_ "register", direct use of processor registers.

The "register" keyword does _not_ use processor registers. It's just 
syntactic fluff, and tells the compiler exactly one thing:

 - that the compiler should warn if you take the address of such a thing.

In addition, the compiler may generate code that takes it into account, 
which most likely means _worse_ code than if it didn't take it into 
account.

In contrast regparm() actually says something very relevant: it says that 
the function uses a totally different calling convention.

		Linus
