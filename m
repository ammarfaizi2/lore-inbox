Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275059AbTHRWek (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 18:34:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275219AbTHRWek
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 18:34:40 -0400
Received: from meryl.it.uu.se ([130.238.12.42]:24315 "EHLO meryl.it.uu.se")
	by vger.kernel.org with ESMTP id S275059AbTHRWej (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 18:34:39 -0400
Date: Tue, 19 Aug 2003 00:34:08 +0200 (MEST)
Message-Id: <200308182234.h7IMY8op012304@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: m.c.p@wolk-project.de
Subject: Re: [PATCH][2.4.22-rc2] Disable APIC on reboot.
Cc: fxkuehl@gmx.de, linux-kernel@vger.kernel.org, marcelo@conectiva.com.br,
       willy@w.ods.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Aug 2003 21:22:10 +0200, Marc-Christian Petersen wrote:
>> disable_local_APIC() now checks if detect_init_APIC() enabled the
>> local APIC via the APIC_BASE MSR, and if so it now disables APIC_BASE.
>> Previously we would leave APIC_BASE enabled, and that made some
>> BIOSen unhappy.
>> The SMP reboot code calls disable_local_APIC(). On SMP HW there is
>> no change since detect_init_APIC() isn't called and APIC_BASE isn't
>> enabled by us. An SMP kernel on UP HW behaves just like an UP_APIC
>> kernel, so it disables APIC_BASE if we enabled it at boot.
>> The UP_APIC disable-before-suspend code is simplified since the existing
>> code to disable APIC_BASE is moved into disable_local_APIC().
>> (Felix Kühling originally reported the BIOS reboot problem. This is a
>> fixed-up version of his preliminary patch.)
>
>please correct me if I say something really stupid now but shouldn't the APIC 
>be disabled only during reboot time and enabled again at a new boot?
>
>my experience with this patch is, after a reboot he APIC isn't enabled again 
>until I power off my machine.

Seems impossible to me. We _know_ how to enable APIC_BASE,
otherwise this code wouldn't trigger at all.
Please give evidence as to what goes wrong, i.e., dmesg logs
from first (cold) and subsequent (warm) boots.
(Preferably from a standard 2.4.22-rc2 so I can verify the code.)

/Mikael
