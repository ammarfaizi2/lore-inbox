Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265024AbUF1Uus@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265024AbUF1Uus (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 16:50:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265084AbUF1Uur
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 16:50:47 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:15974 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S265024AbUF1Uu3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 16:50:29 -0400
Message-ID: <40E0847E.4040802@travellingkiwi.com>
Date: Mon, 28 Jun 2004 21:50:06 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Li, Shaohua" <shaohua.li@intel.com>
Cc: linux-kernel@vger.kernel.org, acpi-devel@lists.sourceforge.net
Subject: Re: [ACPI] No APIC interrupts after ACPI suspend
References: <B44D37711ED29844BEA67908EAF36F032D566A@pdsmsx401.ccr.corp.intel.com>
In-Reply-To: <B44D37711ED29844BEA67908EAF36F032D566A@pdsmsx401.ccr.corp.intel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Li, Shaohua wrote:

>Hi,
>I attached a new patch to handler all level triggered IRQs after resume
>for 8259 in http://bugme.osdl.org/show_bug.cgi?id=2643. Please try and
>attach your test result on it.
>
>  
>


[Sorry if some see this twice... It bounced when I sent it before]

Uh.... That might work.... Except that after applying the patch & 
restarting. Then suspend-resume I get another small problem... My 
thinkpad (r50p) uses the power button to wake up from suspend... The 
system wakes, but with this latest patch, acpid then kicks in & says 
'Ohh! I saw him press the power button' and promptly shuts down...

here's my acpid logfile

[Mon Jun 28 09:39:27 2004] received event "button/sleep SLPB 00000080 
00000001"
[Mon Jun 28 09:39:27 2004] executing action "/etc/acpi/sleep.sh"
[Mon Jun 28 09:39:27 2004] BEGIN HANDLER MESSAGES
ERROR: Module i810_audio does not exist in /proc/modules
Stopping hotplug subsystem:
  input
  net
  pci
  usb
done
ERROR: Module bluetooth is in use by rfcomm,l2cap
Starting hotplug subsystem:
  input
  net
  pci
  usb
** can't synthesize root hub events
done

/dev/hda:
setting standby to 240 (20 minutes)
[Mon Jun 28 09:39:43 2004] END HANDLER MESSAGES
[Mon Jun 28 09:39:43 2004] action exited with status 0
[Mon Jun 28 09:39:43 2004] completed event "button/sleep SLPB 00000080 
00000001"
[Mon Jun 28 09:39:43 2004] received event "button/power PWRF 00000080 
00000001"
[Mon Jun 28 09:39:43 2004] executing action "/etc/acpi/powerbtn.sh"
[Mon Jun 28 09:39:43 2004] BEGIN HANDLER MESSAGES
[Mon Jun 28 09:39:43 2004] END HANDLER MESSAGES
[Mon Jun 28 09:39:43 2004] action exited with status 0
[Mon Jun 28 09:39:43 2004] completed event "button/power PWRF 00000080 
00000001"
[Mon Jun 28 09:40:07 2004] exiting
[Mon Jun 28 09:41:08 2004] starting up
[Mon Jun 28 09:41:08 2004] 3 rules loaded
ballbreaker:/var/log#


Sleeps, wakes & a shutdown... Should acpid do that? (i.e. shouldn't it 
eat the power button event that woke it up as a wakeup? Should it even 
get that?) Or is it the previous patch for drivers/acpi/sleep/main.c 
resetting the IRQ9 to edge triggered that's killing me? (I'll try 
removing that now).

[Note, I've recieved a note regarding the wakeup & shutdown problem... 
It's a bug perhaps? Does anyone know whether the bug is that acpi 
shouldn't get the power button event after the resume? Or is it a bug 
that acpid itself doesn't eat the event as we've just resumed (How does 
it know the button was to wakeup & wasn't really to shutdown?) or is the 
bug in the scripts (unlikely... The 'workaround' I was pointed at 
scrapes the log to find out if we've just resumed... But what if the 
logfilesystem is full... No log & we'll shutdown anyway, so I'd suspect 
acpid myself... Anyone confirm which area is actually responsible?

TIA
Hamish.

