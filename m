Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262802AbSIPTtb>; Mon, 16 Sep 2002 15:49:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262803AbSIPTtb>; Mon, 16 Sep 2002 15:49:31 -0400
Received: from smtp-send.myrealbox.com ([192.108.102.143]:6605 "EHLO
	smtp-send.myrealbox.com") by vger.kernel.org with ESMTP
	id <S262802AbSIPTta>; Mon, 16 Sep 2002 15:49:30 -0400
Message-ID: <3D8636D5.5000203@myrealbox.com>
Date: Mon, 16 Sep 2002 22:53:57 +0300
From: Andriy Rysin <arysin@myrealbox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1b) Gecko/20020722
X-Accept-Language: uk, en-us, ru
MIME-Version: 1.0
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: turning off APIC
Content-Type: text/plain; charset=KOI8-U; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> On Sun, 15 Sep 2002 14:28:44 +0300, Andriy Rysin wrote:
> >If APIC is compiled in the kernel (wich is the case with most
> >distributions) when I start kernel with "noapic" option, APIC is getting
> >enabled anyway and only later gets disabled. This causes problems on
> >some VAIO notebooks - it seems like BIOS gets confused if APIC was
> >turned on (particularly on my laptop when I try to reboot from Linux it
> >hangs saying that thera problems with keyboard). That would be much
> >better to have an option to turn it off in the boot options and not to
> >recompile the kernel. Could somebody comment this please?
> >Please CC me on this email address.
>
> Which APIC? local or I/O? Please be specific.
> "noapic" does not and never has had anything to do with the
> local APIC, only the I/O APIC. There is currently no kernel
> option for preventing the local APIC from being enabled if
> the kernel was built with local APIC support.
>
> You have four options:
> 1. Recompile with CONFIG_SMP=n and CONFIG_X86_LOCAL_APIC=n.
> 2. Run dmidecode on your Vaio, dig out the identification strings,
>    and add them to arch/i386/kernel/dmi_scan.c's local APIC
>    blacklist.
> 3. Add a __setup in arch/i386/kernel/apic.c after the declaration
>    for dont_enable_local_apic, which sets it to 1.
> 4. Tell Sony to fix the Vaio's BIOS.
>
> /Mikael


Thanks Mikael, item 2) seems to be most reasonable. I did not know there 
are different APICs, though what's interesting is the line in 
kernel-parameters.txt
 
    noapic        [SMP,APIC] Tells the kernel not to make use of any
            APIC that may be present on the system.

Note: not to make use of _ANY_ APIC that may be present......
I would suggest either "noapic" should turn off ALL APICs as is 
described in the doc or fix the doc. Personally I like fist option 
better though second is much simplier.

Andriy

