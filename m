Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284520AbRLERR2>; Wed, 5 Dec 2001 12:17:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283773AbRLERRR>; Wed, 5 Dec 2001 12:17:17 -0500
Received: from harpo.it.uu.se ([130.238.12.34]:55172 "EHLO harpo.it.uu.se")
	by vger.kernel.org with ESMTP id <S284519AbRLERRF>;
	Wed, 5 Dec 2001 12:17:05 -0500
From: Mikael Pettersson <mikpe@csd.uu.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15374.22142.86391.322681@harpo.it.uu.se>
Date: Wed, 5 Dec 2001 18:16:46 +0100
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: APIC Error when doing apic_pm_suspend
In-Reply-To: <Pine.LNX.4.33.0112051123500.18928-100000@netfinity.realnet.co.sz>
In-Reply-To: <Pine.LNX.4.33.0112051123500.18928-100000@netfinity.realnet.co.sz>
X-Mailer: VM 6.90 under Emacs 20.7.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo writes:
 > I get an APIC error 0x40 when resuming from an apm -s. If i'm correct
 > that would be an illegal register access wouldn't it? I tried putting
 > enter/exit printks in the apic_pm_resume/suspend functions and it showed
 > that both returned before the APIC error printk. Is there anyway of finding out
 > which register access it was? I "thought" it would be one of the
 > apic_writes in the pm functions but looks like i might be wrong.
 > 
 > The kernel is compiled with local APIC and gets detected and enabled on
 > boot (UP machine).

No, 0x40 is an illegal vector error. It's a (semi-) known quirk in the P6 family
of processors that you get this error when writing a null vector to any of the
LVT entries, even if you are also setting the mask bit at the same time.
Both the clear_local_APIC() call at PM suspend and the reinitialisation at PM
resume can trigger this.

The "error" is mostly harmless. Ignore it for now, I'll do a patch to silence it later.

/Mikael
