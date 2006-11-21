Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031429AbWKUU4Z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031429AbWKUU4Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 15:56:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031430AbWKUU4Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 15:56:25 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:1068 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1031429AbWKUU4Y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 15:56:24 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ocPqNIXRUUoUAzi2pyMJNd6uRQ3+Evh07EofodAK2mtvMXq+NoxB5OGL0RnAGWHfGdbgE9Q6BKW8zust+zQHihk1i8oofaSWEOTXYUW+IsPEkVH+/DMItjYO0W7sUT8dh+/3JnMKXQH5vtlIM3am5iUTrv4yPutIXxnfzhEHm1U=
Message-ID: <2625b9520611211256y4dbfaf1eyd95e2ca8fb94cec6@mail.gmail.com>
Date: Tue, 21 Nov 2006 12:56:20 -0800
From: "Thushara Wijeratna" <thushw@gmail.com>
To: "Samuel Korpi" <strontianite@gmail.com>
Subject: Re: some help in kernel debugging
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <dfed62190611200053g3fff5296te8251a22675730e0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <2625b9520611171304x213b3bc6h6e2a40d43ce4497c@mail.gmail.com>
	 <dfed62190611200053g3fff5296te8251a22675730e0@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samuel, thanks much for the pointers, I'm following up on UML.
BTW, I fixed my earlier problem after realizing (a chat with a Linux
savvy friend had nothing to do with it...) Basically I made the initrd
image on the dev machine for the same kernel version and copied it
over to the test machine, it then booted.

I can now actually attach gdb and poke around and try to figure out
why it is throwing a SIGSEV. I have a stack like this:

Program received signal SIGSEGV, Segmentation fault.
[Switching to Thread 1]
0x00000000 in ?? ()
(gdb) bt
#0  0x00000000 in ?? ()
#1  0xc03051db in psmouse_interrupt (serio=0xc048cde0, data=250
'\uffff', flags=0,
    regs=0x0) at drivers/input/mouse/psmouse-base.c:206
#2  0xc030882a in i8042_interrupt (irq=0, dev_id=0x0, regs=0x0)
    at drivers/input/serio/i8042.c:433
#3  0xc03084f9 in i8042_aux_write (port=0x0, c=232 '\uffff')
    at drivers/input/serio/i8042.c:235
#4  0xc03053bb in psmouse_sendbyte (psmouse=0xf70aa7f8, byte=232 '\uffff')
    at include/linux/serio.h:77

and this is the code inside psmouse-base.c that is crashing:

	rc = psmouse->protocol_handler(psmouse, regs);

So I'm guessing I did't specify an option correctly in the `make
menuconfig` so that the kernel identifies my mouse and installs a
proper handler for it? It is a USB mouse and I thought I enabled it,
but I'm guessing I missed something.

Thanks a lot for all your help, at some point I want to contribute
testing builds, this is good training...

On 11/20/06, Samuel Korpi <strontianite@gmail.com> wrote:
> Hi,
>
> I don't know what sort of debugging needs you have, exactly, but I
> would suggest you take a look at User Mode Linux (UML). UML provides a
> safe and pretty easy way to start you with kernel debugging and just
> looking into kernel internals. It is a virtual kernel running in user
> space, so it doesn't require a separate test machine, and you can
> debug it with normal gdb. Furthermore, it is included in current
> vanilla kernels, so you can get started without any extra patches.
>
> Main sources for information concerning UML are:
>
> Main page: http://www.user-mode-linux.org/
> HOWTO: http://user-mode-linux.sourceforge.net/UserModeLinux-HOWTO.html
> Wiki: http://uml.jfdi.org/
> Precompiled kernels and root file systems: http://uml.nagafix.co.uk/
>
> /Samuel Korpi
>
