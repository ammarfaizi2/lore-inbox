Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272506AbTGaPIH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 11:08:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272507AbTGaPIH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 11:08:07 -0400
Received: from mail.jlokier.co.uk ([81.29.64.88]:31872 "EHLO
	mail.jlokier.co.uk") by vger.kernel.org with ESMTP id S272506AbTGaPID
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 11:08:03 -0400
Date: Thu, 31 Jul 2003 16:07:58 +0100
From: Jamie Lokier <jamie@shareable.org>
To: Willy Tarreau <willy@w.ods.org>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: TSCs are a no-no on i386
Message-ID: <20030731150758.GE6410@mail.jlokier.co.uk>
References: <20030730135623.GA1873@lug-owl.de> <20030730181006.GB21734@fs.tum.de> <20030730183033.GA970@matchmail.com> <20030730184529.GE21734@fs.tum.de> <1059595260.10447.6.camel@dhcp22.swansea.linux.org.uk> <20030730203318.GH1873@lug-owl.de> <20030731002230.GE22991@fs.tum.de> <20030731062252.GM1873@lug-owl.de> <20030731071719.GA26249@alpha.home.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030731071719.GA26249@alpha.home.local>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> The other problem lies with the lock :
> When a 486 executes "LOCK ; CMPXCHG", it locks the bus during the whole cmpxchg
> instruction. If a 386 executes the same code, it will get an exception which
> will be caught by the emulator. I don't see how we can do such an atomic
> operation while holding a lock. At best, we would think about a global memory
> based shared lock during the operation (eg: int bus_lock;), but it's not
> implemented at the moment, and will only be compatible with processors sharing
> the same code. Add-on processors, such as co-processors, transputer cards, or
> DSPs, will know nothing about such a lock emulation. And it would result in
> even poorer performance of course !

Of course this is not a problem when "lock;cmpxchg" is used only for thread
synchronisation on uniprocessor 386s...  The lock prefix is irrelevant then.

Perhaps the emulation should refuse to pretend to work on an SMP 386 :)

-- Jamie
