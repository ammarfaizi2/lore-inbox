Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbTL1SZv (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 13:25:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261889AbTL1SZu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 13:25:50 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:15115 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261877AbTL1SZs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 13:25:48 -0500
Date: Sun, 28 Dec 2003 18:25:45 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>,
       Ingo Molnar <mingo@redhat.com>
Subject: Re: 2.6.0-test6: APM unable to suspend (the 2.6.0-test2 saga continues)
Message-ID: <20031228182545.B20278@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>,
	Ingo Molnar <mingo@redhat.com>
References: <20031005171055.A21478@flint.arm.linux.org.uk> <20031228174622.A20278@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031228174622.A20278@flint.arm.linux.org.uk>; from rmk+lkml@arm.linux.org.uk on Sun, Dec 28, 2003 at 05:46:22PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 28, 2003 at 05:46:22PM +0000, Russell King wrote:
> Alan Cox has shed some light on this problem.  He mentions that the
> x86 GDT/LDT stuff changed around 2.5.30, which is the time when others
> have also reported that their APM has stopped working.  I've not
> confirmed whether that is the case for me as well, but it seems to
> be highly likely.
> 
> I also asked Alan if there's the possibility of backing this out or
> making it configurable, but the answer seems to be a most definite
> no.  However, maybe Ingo can say otherwise?
> 
> This effectively means that people with laptops which do not work
> with 2.6 APM nor ACPI can expect their machines to be stuck with 2.4
> for the future, unless someone with the necessary knowledge sees this
> problem as important enough to solve.

A quick follow-up from a discussion I've just had with Andi Kleen...
Note that I know nothing about the x86 internals of LDT/GDT/APM stuff,
so I'm clutching at straws here...

Would it be possible to switch LDT/GDT to whatever the APM BIOS expects
just before calling the APM BIOS to suspend/hibernate, and restore them
to whatever Linux requires after the APM BIOS returns from resume?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
