Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129415AbRAFHx0>; Sat, 6 Jan 2001 02:53:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129655AbRAFHxQ>; Sat, 6 Jan 2001 02:53:16 -0500
Received: from ppp0.ocs.com.au ([203.34.97.3]:12292 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S129627AbRAFHxL>;
	Sat, 6 Jan 2001 02:53:11 -0500
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: jamagallon@able.es (J . A . Magallon),
        linux-kernel@vger.kernel.org (linux-kernel)
Subject: Re: Module section warning 
In-Reply-To: Your message of "Fri, 05 Jan 2001 20:51:46 -0000."
             <E14Edq0-0008PC-00@the-village.bc.nu> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 06 Jan 2001 18:53:05 +1100
Message-ID: <18121.978767585@ocs3.ocs-net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 5 Jan 2001 20:51:46 +0000 (GMT), 
Alan Cox <alan@lxorguk.ukuu.org.uk> wrote:
>> o  binutils               2.9.1.0.25              # ld -v
>> o  modutils               2.4.0                   # insmod -V
>> 
>> and 2.4 uses gas instead of as86 for real mode.
>> 
>> Are not that versions enough to delete the
>> __asm__(".section .modinfo\n\t.previous");
>> in module.h ?
>
>Firstly they are guidelines for x86. Secondly certain configs need the updates
>so its pretty invasive to force it yet - 2.5.0 yes

Any modutils >= 2.3.19 automatically treats .modinfo as no load,
irrespective of what the kernel says.  Since modutils 2.3.21 fixes the
local root exploit on modprobe, nobody on kernel 2.4 should be running
modutils < 2.3.21.  I am tempted to put a check in modules_install to
detect insecure modutils and bitch.

Modutils 2.4 is backwards compatible down to 2.0 kernels.  I have no
qualms about removing __asm__(".section .modinfo\n\t.previous"); from
module.h in 2.4 kernels and will be sending in patches to do that,
along with other changes to module.h.  Worst case when omitting that
line and still using old modutils is a slightly larger module in
memory.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
