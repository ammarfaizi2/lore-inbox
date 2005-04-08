Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVDHVoD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVDHVoD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 17:44:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261156AbVDHVoD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 17:44:03 -0400
Received: from www.tuxrocks.com ([64.62.190.123]:47365 "EHLO tuxrocks.com")
	by vger.kernel.org with ESMTP id S261153AbVDHVn5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 17:43:57 -0400
Message-ID: <4256FAE3.30500@tuxrocks.com>
Date: Fri, 08 Apr 2005 15:42:59 -0600
From: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tony Lindgren <tony@atomide.com>
CC: linux-kernel@vger.kernel.org,
       Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Pavel Machek <pavel@suse.cz>, Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, Thomas Renninger <trenn@suse.de>
Subject: Re: [PATCH] Updated: Dynamic Tick version 050408-1
References: <20050406083000.GA8658@atomide.com> <425451A0.7020000@tuxrocks.com> <20050407082136.GF13475@atomide.com> <4255A7AF.8050802@tuxrocks.com> <4255B247.4080906@tuxrocks.com> <20050408062537.GB4477@atomide.com> <20050408075001.GC4477@atomide.com> <42564584.4080606@tuxrocks.com> <20050408091757.GD4477@atomide.com>
In-Reply-To: <20050408091757.GD4477@atomide.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Tony Lindgren wrote:
> * Frank Sorenson <frank@tuxrocks.com> [050408 01:49]:
>>This updated patch seems to work just fine on my machine with lapic on
>>the cmdline and CONFIG_DYN_TICK_USE_APIC disabled.
>>
>>Also, you were correct that removing lapic from the cmdline allowed the
>>previous version to run at full speed.
> 
> 
> Cool.
> 
> 
>>Now, how can I tell if the patch is doing its thing?  What should I be
>>seeing? :)
> 
> 
> Download pmstats from http://www.muru.com/linux/dyntick/, you may
> need to edit it a bit for correct ACPI battery values. But it should
> show you HZ during idle and load. I believe idle still does not go
> to ACPI C3 with dyn-tick though...
> 
> Then you might as well run timetest from same location too to make
> sure your clock keeps correct time.

Seems to be going up when under load, and down when idle, so I suppose
it's working :)  The clock is only a little jittery, but not more than
I'd expect across the network, so it looks like it's keeping time okay.

Would it be possible to determine whether the system will wake to the
APIC interrupt at system boot, rather than hardcoded in the config?
After you explained the problem, I noticed that creating my own
interrupts (holding down a key on the keyboard for example) kept the
system moving and not slow.  For example, something like this (sorry, I
don't know the code well enough yet to attempt to code it myself):

set the APIC timer to fire in X
set another timer/interrupt to fire in 2X
wait for the interrupt
if (time_elapsed >= 2X) disable the APIC timer
else APIC timer should work

Or, determine which timer woke us up, etc.

Thanks,
Frank
- --
Frank Sorenson - KD7TZK
Systems Manager, Computer Science Department
Brigham Young University
frank@tuxrocks.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCVvriaI0dwg4A47wRAhhyAJ928wgPEY/9X4KmyJcsaJ+WZk0XRQCfTfcj
x3yKiwYOhMac/SQ7El9N0q0=
=2QVB
-----END PGP SIGNATURE-----
