Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261257AbVCGTM0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261257AbVCGTM0 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Mar 2005 14:12:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261291AbVCGTMG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Mar 2005 14:12:06 -0500
Received: from one.firstfloor.org ([213.235.205.2]:677 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S261257AbVCGTIL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Mar 2005 14:08:11 -0500
To: Corey Minyard <minyard@acm.org>
Cc: lkml <linux-kernel@vger.kernel.org>, akpm@osdl.org
Subject: Re: [PATCH] NMI/CMOS RTC race fix for x86-64
References: <422CA1FA.1010903@acm.org>
From: Andi Kleen <ak@muc.de>
Date: Mon, 07 Mar 2005 20:08:07 +0100
In-Reply-To: <422CA1FA.1010903@acm.org> (Corey Minyard's message of "Mon, 07
 Mar 2005 12:48:26 -0600")
Message-ID: <m1ll8zmfzc.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Corey Minyard <minyard@acm.org> writes:

> This patch fixes a race between the CMOS clock setting and the NMI
> code.  The NMI code indiscriminatly sets index registers and values
> in the same place the CMOS clock is set.  If you are setting the
> CMOS clock and an NMI occurs, Bad values could be written to or
> read from the CMOS RAM, or the NMI operation might not occur
> correctly.
>

In general you should send all x86-64 patches to me. I would have
eventually merged it from i386 anyways if it was good.

But in this case it isnt. Instead of all this complexity 
just remove the NMI reassert code from the NMI handler.
It is oudated and mostly useless on modern systems anyways.

Since the NMI watchdog runs regularly even if an NMI is missed
it will be eventually handled. And even when it doesn't run
it doesn't matter much because NMI does nothing essential.

-Andi
