Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266763AbSKSQSm>; Tue, 19 Nov 2002 11:18:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266962AbSKSQSm>; Tue, 19 Nov 2002 11:18:42 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:57825 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP
	id <S266763AbSKSQSk>; Tue, 19 Nov 2002 11:18:40 -0500
Message-ID: <3DDA65B7.8070703@us.ibm.com>
Date: Tue, 19 Nov 2002 08:24:23 -0800
From: Dave Hansen <haveblue@us.ibm.com>
User-Agent: Mozilla/5.0 (compatible; MSIE5.5; Windows 98;
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andy Pfiffer <andyp@osdl.org>, Linus Torvalds <torvalds@transmeta.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Werner Almesberger <wa@almesberger.net>,
       Suparna Bhattacharya <suparna@in.ibm.com>,
       "Matt D. Robinson" <yakker@aparity.com>,
       Rusty Russell <rusty@rustcorp.com.au>, Mike Galbraith <efault@gmx.de>,
       "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: [ANNOUNCE][CFT] kexec for v2.5.48 && kexec-tools-1.7
References: <Pine.LNX.4.44.0211091901240.2336-100000@home.transmeta.com>	<m1vg349dn5.fsf@frodo.biederman.org> <1037055149.13304.47.camel@andyp>	<m1isz39rrw.fsf@frodo.biederman.org> <1037148514.13280.97.camel@andyp>	<m1k7jb3flo.fsf_-_@frodo.biederman.org>	<m1el9j2zwb.fsf@frodo.biederman.org>	<m11y5j2r9t.fsf_-_@frodo.biederman.org> <3DD99EA6.4010000@us.ibm.com> <m1of8l27fy.fsf@frodo.biederman.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> Dave Hansen <haveblue@us.ibm.com> writes:
>>The NUMAQ is another story, though.  I get nothing after "Starting new kernel".
>>But, I wasn't expecting much.  The NUMAQ is pretty weird hardware and god knows
>>what is actually happening.  I'll try it some more when I'm more confident in
>>what I'm doing.
> 
> I suspect the hardware shutdown and start up logic for NUMAQ cpus needs some
> special handling.   Does kexec_test not print anything, or were you not patient
> enough?

Starting new kernel
kexec_test 1.6 starting...
eax: 0E1FB007 ebx: 0000111C ecx: 00000000 edx: 00000000
esi: 00000000 edi: 00000000 esp: 00000000 ebp: 00000000
idt: 00000000 C0000000
gdt: 0000006F 000010A0
Switching descriptors.
Descriptors changed.
Legacy pic setup.
In real mode.
Interrupts enabled.
Base memory size: 027E
A20 disabled.
E820 Memory Map.
000000000009FC00 @ 0000000000000000 type: 00000001
00000000EFF00000 @ 0000000000100000 type: 00000001
0000000000180000 @ 00000000FFE80000 type: 00000002
0000000000009000 @ 00000000FEC00000 type: 00000002
0000000100000000 @ 0000000100000000 type: 00000001
E801  Memory size: 003D7400
Mem88 Memory size: FC00
Testing for APM.
APM test done.
Equiptment list: 4426
Sysdesc: F000:E6F5
Video type: VGA
Cursor Position(Row,Column): 0018 0000
Video Mode: 0003
Setting auto repeat rate  done
DASD type: 0300 00FAC53F
EDD:  ok
A20 enabled
Interrupts disabled.
In protected mode.
Halting.

>>What's the deal with "FIXME assuming 64M of ram"?  I was a little surprised when
>>
>>my 16GB machine started to OOM as I did a "make -j8 bzImage" :)  Why is it that
>>you need the memory size at load time?
> 
> Small steps.   When I bypass the BIOS I need to get all of the information
> the kernel normally would get from the BIOS from someplace else.  Currently
> you can use the "mem= " kernel command line parameters.  Of you can dig the
> /proc/iomem and /proc/meminfo and other places and get the BIOS's memory map.
> There isn't a really good source, so I started with something that would work,
> and I will work the user space tools up to something that works well.

I have a couple of ideas.  But, first, is it hard to reconstruct the 
memory map?  Will all 1GB systems have the same memory map?  Do you 
have documentation of the format?  I don't think that any of these 
qualify as the "right thing".  But, as hacks, they should keep me 
happy for a bit.

For now, I can write a quick script to fix it: 
--command-line="`memscript`"

Until it is working a --hack-mem option might be a good idea

Perhaps we could just save a copy off when the kernel loads for the 
first time. If we export it somewhere, the kexec executable can just 
copy it.  For now, we can just printk it and paste it into each 
version of kexec that we compile.

-- 
Dave Hansen
haveblue@us.ibm.com

