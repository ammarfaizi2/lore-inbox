Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318287AbSIKC0V>; Tue, 10 Sep 2002 22:26:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318288AbSIKC0V>; Tue, 10 Sep 2002 22:26:21 -0400
Received: from holomorphy.com ([66.224.33.161]:5319 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S318287AbSIKC0V>;
	Tue, 10 Sep 2002 22:26:21 -0400
Date: Tue, 10 Sep 2002 19:29:33 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Thomas Molina <tmolina@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5 Problem Status Report
Message-ID: <20020911022933.GA3530@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Thomas Molina <tmolina@cox.net>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0209102057340.944-100000@dad.molina>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0209102057340.944-100000@dad.molina>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 10, 2002 at 09:00:30PM -0500, Thomas Molina wrote:
>               2.5 Kernel Problem Reports as of 10 Sep
>    Problem Title                Status                Discussion
>    qlogicisp oops               no further discussion 2.5.33
>    PCI and/or starfire.c broken no further discussion 2.5.33
>    __write_lock_failed() oops   no further discussion 2.5.33

Since 3 of these are things I reported...

qlogicisp.c oops is some longstanding error recovery issue and/or ISR
bug. axboe@suse.de has been taking my bugreports. There is a lack of
general interest in and information about this device.

PCI/starfire.c breakage has to do with PCI-PCI bridges appearing on
machines with multiple PCI buses. The bus numbering scheme used by
the bridges creates clashes with various other bus' numbers or something
like that. It's likely more visible on NUMA-Q since the bus numbers are
used for port I/O remapping. I'm unaware of the amount of reliance on
bus numbers in other circumstances. colpatch@us.ibm.com is handling it.

__write_lock_failed() oops is tasklist_lock starvation. The starving
writer had spun with interrupts off for so long the NMI oopser went
off. dhowells@redhat.com is looking into it and I have backup plans.


Cheers,
Bill
