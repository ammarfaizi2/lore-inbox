Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964837AbWGHN5a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964837AbWGHN5a (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 8 Jul 2006 09:57:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964841AbWGHN5a
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 8 Jul 2006 09:57:30 -0400
Received: from ns1.suse.de ([195.135.220.2]:64992 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S964837AbWGHN53 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 8 Jul 2006 09:57:29 -0400
To: joe.korty@ccur.com
Cc: linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
       linux-os@analogic.com, khc@pm.waw.pl, mingo@elte.hu, akpm@osdl.org,
       arjan@infradead.org
Subject: Re: [patch] spinlocks: remove 'volatile'
References: <787b0d920607072054i237eebf5g8109a100623a1070@mail.gmail.com>
	<20060708094556.GA13254@tsunami.ccur.com>
From: Andi Kleen <ak@suse.de>
Date: 08 Jul 2006 15:57:06 +0200
In-Reply-To: <20060708094556.GA13254@tsunami.ccur.com>
Message-ID: <p731wswp5cd.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe Korty <joe.korty@ccur.com> writes:

> On Fri, Jul 07, 2006 at 11:54:10PM -0400, Albert Cahalan wrote:
> > That's all theoretical though. Today, gcc's volatile does
> > not follow the C standard on modern hardware. Bummer.
> > It'd be low-performance anyway though.
> 
> But gcc would follow the standard if it emitted a 'lock'
> insn on every volatile reference.  It should at least
> have an option to do that.

How do you define reference? While you could do locked mem++ you can't
do locked mem *= 2 (or any other non trivial operation that doesn't
direct map to an memory operand x86 instruction which allows lock
prefixes)

IMHO the "barrier model" used by Linux and implemented by gcc is much
more useful for multithreaded programming, and MMIO needs other
mechanisms anyways.

I wish the C standard would adopt barriers.

-Andi
