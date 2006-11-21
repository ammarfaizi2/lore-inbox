Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031290AbWKUW5u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031290AbWKUW5u (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 17:57:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031301AbWKUW5u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 17:57:50 -0500
Received: from rwcrmhc15.comcast.net ([204.127.192.85]:1458 "EHLO
	rwcrmhc15.comcast.net") by vger.kernel.org with ESMTP
	id S1031290AbWKUW5s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 17:57:48 -0500
Message-ID: <456380EA.9020902@wolfmountaingroup.com>
Date: Tue, 21 Nov 2006 15:42:50 -0700
From: "Jeff V. Merkey" <jmerkey@wolfmountaingroup.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050921 Red Hat/1.7.12-1.4.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thushara Wijeratna <thushw@gmail.com>
CC: Samuel Korpi <strontianite@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: some help in kernel debugging
References: <2625b9520611171304x213b3bc6h6e2a40d43ce4497c@mail.gmail.com>	 <dfed62190611200053g3fff5296te8251a22675730e0@mail.gmail.com> <2625b9520611211256y4dbfaf1eyd95e2ca8fb94cec6@mail.gmail.com>
In-Reply-To: <2625b9520611211256y4dbfaf1eyd95e2ca8fb94cec6@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


There's a debugger called MDB which debugs linux startup from boot with 
full symbols (it encapsulates
linux similar to Xen), including setup of the internal tables.  Its 
better than most of the other tools.   Unfortnately,
its not free, but it is as powerful as any periscope board you have ever 
seen. 

I use it for all my development and I can track down bugs very quickly 
with it.

http://www.kdebug.com

When you get tired of using printk and stone knives and bearskins to 
look for the problem, you may wish to
consider it, if these other approaches keep failing.   I have seen this 
thread bounce around and I share your frustration
with debugging Linux, its not easy for the most part and Linus' "use the 
force' model does not work for everyone.

Jeff


Thushara Wijeratna wrote:

> Samuel, thanks much for the pointers, I'm following up on UML.
> BTW, I fixed my earlier problem after realizing (a chat with a Linux
> savvy friend had nothing to do with it...) Basically I made the initrd
> image on the dev machine for the same kernel version and copied it
> over to the test machine, it then booted.
>
> I can now actually attach gdb and poke around and try to figure out
> why it is throwing a SIGSEV. I have a stack like this:
>
> Program received signal SIGSEGV, Segmentation fault.
> [Switching to Thread 1]
> 0x00000000 in ?? ()
> (gdb) bt
> #0  0x00000000 in ?? ()
> #1  0xc03051db in psmouse_interrupt (serio=0xc048cde0, data=250
> '\uffff', flags=0,
>    regs=0x0) at drivers/input/mouse/psmouse-base.c:206
> #2  0xc030882a in i8042_interrupt (irq=0, dev_id=0x0, regs=0x0)
>    at drivers/input/serio/i8042.c:433
> #3  0xc03084f9 in i8042_aux_write (port=0x0, c=232 '\uffff')
>    at drivers/input/serio/i8042.c:235
> #4  0xc03053bb in psmouse_sendbyte (psmouse=0xf70aa7f8, byte=232 
> '\uffff')
>    at include/linux/serio.h:77
>
> and this is the code inside psmouse-base.c that is crashing:
>
>     rc = psmouse->protocol_handler(psmouse, regs);
>
> So I'm guessing I did't specify an option correctly in the `make
> menuconfig` so that the kernel identifies my mouse and installs a
> proper handler for it? It is a USB mouse and I thought I enabled it,
> but I'm guessing I missed something.
>
> Thanks a lot for all your help, at some point I want to contribute
> testing builds, this is good training...
>
> On 11/20/06, Samuel Korpi <strontianite@gmail.com> wrote:
>
>> Hi,
>>
>> I don't know what sort of debugging needs you have, exactly, but I
>> would suggest you take a look at User Mode Linux (UML). UML provides a
>> safe and pretty easy way to start you with kernel debugging and just
>> looking into kernel internals. It is a virtual kernel running in user
>> space, so it doesn't require a separate test machine, and you can
>> debug it with normal gdb. Furthermore, it is included in current
>> vanilla kernels, so you can get started without any extra patches.
>>
>> Main sources for information concerning UML are:
>>
>> Main page: http://www.user-mode-linux.org/
>> HOWTO: http://user-mode-linux.sourceforge.net/UserModeLinux-HOWTO.html
>> Wiki: http://uml.jfdi.org/
>> Precompiled kernels and root file systems: http://uml.nagafix.co.uk/
>>
>> /Samuel Korpi
>>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

