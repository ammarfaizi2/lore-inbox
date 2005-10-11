Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751163AbVJKMpa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751163AbVJKMpa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Oct 2005 08:45:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751154AbVJKMpa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Oct 2005 08:45:30 -0400
Received: from clock-tower.bc.nu ([81.2.110.250]:53453 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751134AbVJKMpa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Oct 2005 08:45:30 -0400
Subject: Re: i386 spinlock fairness: bizarre test results
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux@horizon.com,
       Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>
In-Reply-To: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
References: <200510110007_MC3-1-AC4C-97EA@compuserve.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 11 Oct 2005 14:00:58 +0100
Message-Id: <1129035658.23677.46.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Maw, 2005-10-11 at 00:04 -0400, Chuck Ebbert wrote:
>   That test machine was a dual 350MHz Pentium II Xeon; on a dual 333MHz Pentium II
> Overdrive (with very slow Socket 8 bus) I could not reproduce those results.
> However, on that machine the 'xchg' instruction made the test run almost 20%
> _faster_ than using 'mov'.
> 
>   So I think the i386 spinlock code should be changed to always use 'xchg' to do
> spin_unlock.


Using xchg on the spin unlock path is expensive. Really expensive on P4
compared to movb. It also doesn't guarantee anything either way around
especially as you go to four cores or change CPU (or in some cases quite
likely even chipset).

Spin lock paths should not be heavily contested. If they are then fix
the underlying problem with finer locking, or if you can't do that then
perhaps by serializing it with a queue.

