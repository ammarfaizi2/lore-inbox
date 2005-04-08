Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVDHQL0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVDHQL0 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Apr 2005 12:11:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262863AbVDHQLZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Apr 2005 12:11:25 -0400
Received: from web88004.mail.re2.yahoo.com ([206.190.37.191]:64094 "HELO
	web88004.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S262862AbVDHQLT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Apr 2005 12:11:19 -0400
Message-ID: <20050408161119.67370.qmail@web88004.mail.re2.yahoo.com>
Date: Fri, 8 Apr 2005 12:11:19 -0400 (EDT)
From: Shawn Starr <shawn.starr@rogers.com>
Subject: RE: [PATCH 2.6.11.6] Add power cycle to ipmi_poweroff module
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shouldn't IPMI be using /sys instead /proc? I thought
we're trying to cleanup /proc? 

---------------

List:       linux-kernel
Subject:    RE: [PATCH 2.6.11.6] Add power cycle to
ipmi_poweroff module
From:       <Chris_Poblete () Dell ! com>
Date:       2005-04-08 15:53:54
Message-ID: <D69989B48C25DB489BBB0207D0BF51F70262F423
() ausx2kmpc104 ! aus ! amer ! dell ! com>
[Download message RAW]


The message handler and si are already using
/proc/ipmi/<intf_num>. The
patch code simply reuse it. By the way, shouldn't we
be using sysfs?

As for separating from power_off, it just seem so
simple to integrate
the power cycle command into the power_off code. It
could definitely be
a separate module.

Thanks,
-Chris Poblete


-----Original Message-----
From: Corey Minyard [mailto:cminyard@mvista.com] 
Sent: Friday, April 08, 2005 10:35 AM
To: Poblete, Chris
Cc: linux-kernel@vger.kernel.org; sdake@mvista.com
Subject: Re: [PATCH 2.6.11.6] Add power cycle to
ipmi_poweroff module

Chris_Poblete@Dell.com wrote:

>Below is a patch to add "power cycle" functionality
to the IPMI power 
>off module ipmi_poweroff.
>
>A new module param is added to support this:
>parmtype:       do_power_cycle:int
>parm:           do_power_cycle: Set to 1 to enable
power cycle instead
>of power down. Power cycle is contingent on hardware
support, otherwise

>it defaults back to power down.
>
>This parameter can also be dynamically modified
through the proc
>filesystem:
>/proc/ipmi/<interface_num>/poweroff
>  
>
This should probably be
/proc/sys/dev/ipmi/power_cycle_on_halt.  Most
things to control a system go there.  The
/proc/sys/dev/ipmi directory
should probably be created by the base IPMI file, too.

Thinking about it a little more, this should really be
an option for
reset, not for power off (thus making the name
power_cycle_on_reset).  
I'm not sure how easy that will be to tie into.  It
doesn't look easy;
there's not something like pm_power_off for reset.

All the proc fs stuff should be ifdef-ed appropriately
so it will
compile with procfs turned off.

-Corey

>The power cycle action is considered an optional
chassis control in the

>IPMI specification.  However, it is definitely useful
when the hardware

>supports it.  A power cycle is usually required in
order to reset a 
>firmware in a bad state.  This action is critical to
allow remote 
>management of servers.
>
>The implementation adds power cycle as optional to
the ipmi_poweroff 
>module. It can be modified dynamically through the
proc entry mentioned

>above. During a power down and enabled, the power
cycle command is sent

>to the BMC firmware. If it fails either due to
non-support or some 
>error, it will retry to send the command as power
off.
>
>Signed-off-by: Christopher A. Poblete
<Chris_Poblete@dell.com>
>
>--
>Chris Poblete
>Software Engineer
>Dell OpenManage Instrumentation
