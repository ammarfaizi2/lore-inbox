Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130696AbQKABHh>; Tue, 31 Oct 2000 20:07:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131016AbQKABH0>; Tue, 31 Oct 2000 20:07:26 -0500
Received: from serval.noc.ucla.edu ([169.232.10.12]:49635 "EHLO
	serval.noc.ucla.edu") by vger.kernel.org with ESMTP
	id <S130696AbQKABHS>; Tue, 31 Oct 2000 20:07:18 -0500
Message-ID: <39FF6CE2.7D42CA58@math.ucla.edu>
Date: Tue, 31 Oct 2000 17:07:46 -0800
From: Mike Oliver <oliver@math.ucla.edu>
X-Mailer: Mozilla 4.73 [en] (WinNT; U)
X-Accept-Language: it,en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.2.17 -- can't power-down on halt?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have Linux RH 6.2 installed, Soyo motherboard, Athlon K7.
When using the kernel that came with the distro (2.2.14-5.0),
the "shutdown -h" commend worked correctly, causing the
computer to power down after exiting Linux.

But when I compiled myself a 2.2.17 kernel, it didn't
work anymore (it hung on halt).  So I turned on
CONFIG_APM_REAL_MODE_POWER_OFF, which is supposed to
fix some bugs.  But after that, while it no longer
hung, it *restarted* rather than powering down as
I wanted it to.

I find that the CONFIG_APM_REAL_MODE_POWER_OFF symbol
causes apm_power_off() to call
        machine_real_restart(po_bios_call, sizeof(po_bios_call));
which certainly *looks* like it's trying to restart
the machine rather than powering down (line 641 of
apm.c, version 1.13).  What's the reason for
this?

When the symbol is not defined, apm_power_off() calls
        (void) apm_set_power_state(APM_STATE_OFF);
which is the same call as in apm.c from the
2.2.14 kernel (version 1.9 of apm.c).  So
how come this causes a hang when I try
it in 2.2.17, but not in 2.2.14?
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
