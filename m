Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263937AbTIIEJZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Sep 2003 00:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263939AbTIIEJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Sep 2003 00:09:25 -0400
Received: from dyn-ctb-203-221-72-196.webone.com.au ([203.221.72.196]:49924
	"EHLO chimp.local.net") by vger.kernel.org with ESMTP
	id S263937AbTIIEJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Sep 2003 00:09:22 -0400
Message-ID: <3F5D5134.2030502@cyberone.com.au>
Date: Tue, 09 Sep 2003 14:04:04 +1000
From: Nick Piggin <piggin@cyberone.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030827 Debian/1.4-3
X-Accept-Language: en
MIME-Version: 1.0
To: linux-acpi@intel.com
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: 2.6.0-test5: Hang in i8042_init
References: <3F4EDC47.2020302@cyberone.com.au>	<1062153908.700.4.camel@teapot.felipe-alfaro.com>	<3F4F3162.9040307@cyberone.com.au> <20030829092418.09a140f3.akpm@osdl.org> <3F51C6AC.2070605@cyberone.com.au>
In-Reply-To: <3F51C6AC.2070605@cyberone.com.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm still getting these hangs in 2.6.0-test5.


Nick Piggin wrote:

>
>
> Andrew Morton wrote:
>
>> Nick Piggin <piggin@cyberone.com.au> wrote:
>>
>>>
>>>
>>> Felipe Alfaro Solana wrote:
>>>
>>>
>>>> On Fri, 2003-08-29 at 06:53, Nick Piggin wrote:
>>>>
>>>>
>>>>> Is what I am getting. Last line is something like input: PC Speaker
>>>>> (followed by the initcall).
>>>>>
>>>>> dmseg and lspci from a working kernel attached. Let me know if I can
>>>>> do more.
>>>>>
>>>>>
>>>> Could it be something related with
>>>> http://bugzilla.kernel.org/show_bug.cgi?id=1123?
>>>>
>>>>
>>>>
>>>>
>>> Yes it seems quite likely. Further poking reveals that the
>>> box still locks with a PS2 mouse _and_ the USB mouse. A PS2
>>> mouse on its own allows the system to boot, although
>>> interrupt 10 (eth0, usb) is not working. Booting with
>>> acpi=off allows the system to boot normally with the USB
>>> mouse, and interrupt 10 works.
>>>
>>>
>>
>> Nick, please send a full report.  There's been quite some breakage 
>> from the
>> recent ACPI updates and it'd be nice to work out what happened.
>>
>> Here's the recipe:
>>
>>  The dmesg output of the failing case is really helpful, As is the
>>  output of acpidmp to examine the ACPI tables on the system.  (Red Hat
>>  includes both of these in their severn beta1, acpidmp is also in 
>> pmtools
>>  on intel's ACPI web page) dmidecode output is useful to identify the 
>> BIOS
>>  version.
>>
>>  Of course the 1st thing to check with ACPI failures is that the BIOS
>>  version shown by dmidmp is the latest provided by the vendor...  
>> Plus, if
>>  we determine the BIOS is toast, DMI provides what we need to add the
>>  system to the DMI or acpi blacklists.
>>
>>  We're seeting the most problems on VIA chip-sets with no IO-APIC.  The
>>  one below is unusual because it is a 2-way system with 3 IO-APICs.
>>
>>  The latest code in linus' tree includes ACPICA 20030813, which is
>>  slightly newer than the one below, it might be a good idea to try that
>>  with CONFIG_ACPI_DEBUG.  Note that it will spit out the DMI info 
>> upon the
>>  mount root failure automatically.
>>
>> Thanks.
>>
>>
>
> OK, well the computer is a 1 CPU Pentium 4 Celeron. I can't get the
> failing dmesg because I can't get a serial console onto it (it isn't
> my computer). The last line of the dmesg is: "input: PC Speaker", and
> the last initcall is i8042_init.
>
> The computer has a PS2 keyboard and a USB mouse. Booting with a PS2
> mouse attached as well still causes a hang. Booting without the USB
> mouse works, however the USB interrupt (2 ohci-hcd's and eth0 share it)
> no longer works, so eth0 doesn't work, and plugging in the USB mouse
> does nothing.
>
> Attached are dmesg, interrupts, .config, acpidmp, dmidecode, etc.
>
>

