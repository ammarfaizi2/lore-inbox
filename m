Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317743AbSIAVFt>; Sun, 1 Sep 2002 17:05:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSIAVFt>; Sun, 1 Sep 2002 17:05:49 -0400
Received: from sisko.nothing-on.tv ([213.208.99.114]:40848 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S317743AbSIAVFs>;
	Sun, 1 Sep 2002 17:05:48 -0400
Message-ID: <3D7282F3.2090001@nothing-on.tv>
Date: Sun, 01 Sep 2002 22:13:23 +0100
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Oops in pl2303 driver
References: <3D7117D3.5080100@nothing-on.tv> <20020901005124.GA15259@kroah.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Razor-id: 8a1504f3dc600461f8bcd812234f3c1228e12939
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> 
> I'm guessing thie is 2.4.20-pre5?  If so can you try the following two
> patches that I just sent off to Marcelo:
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-usbserial-2.4.20-pre5.patch
> and
> 	http://www.kernel.org/pub/linux/kernel/people/gregkh/usb/2.4/usb-pl2303-2.4.20-pre5.patch
> 
> and let me know if that solves the problem for you or not?
> 
>
No change (new oops appended... looks the same as the old one basically)

I also tried 2.5.32 and got exactly the same oops.

To reproduce...  type 'cat /dev/ttyUSB0' and hit control-C.

I have tried removing all modules except the USB serial related ones and 
get exactly the same, so I think the references to 'mousedev' are bogus 
in the oops (the taint is from the VMWare modules but I get the same 
without them so I don't think they're affecting anything).

Tony

Sep  1 22:04:49 spock kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000014
Sep  1 22:04:49 spock kernel: d48a1344
Sep  1 22:04:49 spock kernel: *pde = 00000000
Sep  1 22:04:49 spock kernel: Oops: 0000
Sep  1 22:04:49 spock kernel: CPU:    0
Sep  1 22:04:49 spock kernel: EIP: 
0010:[mousedev:__insmod_mousedev_O/lib/modules/2.4.20-pre5/kernel/drivers/+-298172/96] 
    Tainted: PF
Sep  1 22:04:49 spock kernel: EFLAGS: 00010087
Sep  1 22:04:49 spock kernel: eax: cf63b000   ebx: 00000000   ecx: 
cf4ebc00   edx: 00000000
Sep  1 22:04:49 spock kernel: esi: cf7ad440   edi: 00000000   ebp: 
00000246   esp: ce45bd80
Sep  1 22:04:49 spock kernel: ds: 0018   es: 0018   ss: 0018
Sep  1 22:04:49 spock kernel: Process cat (pid: 912, stackpage=ce45b000)
Sep  1 22:04:49 spock kernel: Stack: 00000000 cf7ad440 00000000 00000282 
d48a2b10 cf7ad440 cf7ad444 cf7ad440
Sep  1 22:04:49 spock kernel:        00000286 cf7021c0 00000001 00000000 
ce731400 cf70826c d48a1fe2 cf7ad440
Sep  1 22:04:49 spock kernel:        cf4ebc00 ffffffff cf4ebc1c cf4ebc00 
cf70826c d4891146 cf7ad440 d4920f39
Sep  1 22:04:49 spock kernel: Call Trace: 
[mousedev:__insmod_mousedev_O/lib/modules/2.4.20-pre5/kernel/drivers/+-292080/96] 
[mousedev:__insmod_mousedev_O/lib/modules/2.4.20-pre5/kernel/drivers/+-294942/96] 
[mousedev:__insmod_mousedev_O/lib/modules/2.4.20-pre5/kernel/drivers/+-364218/96] 
[<d4920f39>] [<d491a36f>]
Sep  1 22:04:49 spock kernel:   [<d491a42b>] [release_dev+576/1232] 
[__free_pages+27/32] [free_page_and_swap_cache+51/64] [__free_pte+64/80] 
[zap_page_range+403/576]
Sep  1 22:04:49 spock kernel: Code: 8b 52 14 8b 42 e8 8b 7a ec 25 00 00 
00 2f 0d 00 00 80 01 89


 >>eax; cf63b000 <_end+f371cbc/14587d1c>
 >>ecx; cf4ebc00 <_end+f2228bc/14587d1c>
 >>esi; cf7ad440 <_end+f4e40fc/14587d1c>
 >>esp; ce45bd80 <_end+e192a3c/14587d1c>

Trace; d491a42b <[parport_pc]__module_parm_verbose_probing+4cd/9fa>

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
    0:   8b 52 14                  mov    0x14(%edx),%edx
Code;  00000003 Before first symbol
    3:   8b 42 e8                  mov    0xffffffe8(%edx),%eax
Code;  00000006 Before first symbol
    6:   8b 7a ec                  mov    0xffffffec(%edx),%edi
Code;  00000009 Before first symbol
    9:   25 00 00 00 2f            and    $0x2f000000,%eax
Code;  0000000e Before first symbol
    e:   0d 00 00 80 01            or     $0x1800000,%eax
Code;  00000013 Before first symbol
   13:   89 00                     mov    %eax,(%eax)

