Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261723AbSJMXxd>; Sun, 13 Oct 2002 19:53:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261770AbSJMXxd>; Sun, 13 Oct 2002 19:53:33 -0400
Received: from h-64-105-34-19.SNVACAID.covad.net ([64.105.34.19]:48771 "EHLO
	freya.yggdrasil.com") by vger.kernel.org with ESMTP
	id <S261723AbSJMXxc>; Sun, 13 Oct 2002 19:53:32 -0400
From: "Adam J. Richter" <adam@yggdrasil.com>
Date: Sun, 13 Oct 2002 16:59:01 -0700
Message-Id: <200210132359.QAA01092@adam.yggdrasil.com>
To: rmk@arm.linux.org.uk
Subject: Re: Patch: linux-2.5.42/kernel/sys.c - warm reboot should not suspend devices
Cc: ebiederm@xmission.com, eblade@blackmagik.dynup.net,
       linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell King wrote:
>On Sun, Oct 13, 2002 at 04:10:01PM -0700, Adam J. Richter wrote:
>>       I have no objection to replacing or supplementing the reboot
>> notifier chain with a method in struct device_driver, but let's not
>> overload these methods with ambiguous semantics.  I do not want to
>> call thirty functions that primarily return memory to various memory
>> allocators, mark a bunch of inodes as invalid, and otherwise arrange
>> things so that the kernel can smoothly continue to run user level
>> programs when, in fact, we just want to pull the reset line on the
>> computer.
>
>And what about setups where you can't pull the reset line from software.
>I have several machines here like that.  And one of them needs software
>to talk to the cards to put them back into a sane state before rebooting.
>
>"rebooting" in this particular case is "turn MMU off, jump to location 0"

As I send in my response Eric Biederman,

|        If you have a platform where, for example, somehow PCI devices
| are able to continue jabbering away after the computer has been reset,
| then that could probably be done more consistently for most drivers by
| having machine_restart on that platform walk the PCI bus and shut down
| everything (drivers that need to do something really special would
| still use the reboot notifier).
|
|         I could even see calling device_shutdown from machine_restart
| on that platform only, [...]


>And I never said anything about needing to allocate memory to do this.
>I agree with you that suspending devices on reboot _is_ silly.  However,
>that's not what I was proposing.

	Then you've started a new thread of discussion, because
device_shutdown is defined in drivers/base/power.c as:

void device_shutdown(void)
{  
        device_suspend(4, SUSPEND_POWER_DOWN);
}


	Perhaps device_suspend ought to be renamed device_power_down.

	However, I'm not trying to quash what you want to discuss.
I'd be interested in hearing about clarifications and perhaps
extensions of the struct device_driver methods, which I think is what
you're getting at, perhaps here or on linux-hotplug.  It's just that,
for this thread, I'm trying to focus on my patch that eliminates the
software suspend on reboot (pros and cons, alternatives to it, etc.).

Adam J. Richter     __     ______________   575 Oroville Road
adam@yggdrasil.com     \ /                  Milpitas, California 95035
+1 408 309-6081         | g g d r a s i l   United States of America
                         "Free Software For The Rest Of Us."
