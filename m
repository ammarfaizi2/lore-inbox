Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317898AbSHaTQh>; Sat, 31 Aug 2002 15:16:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317931AbSHaTQg>; Sat, 31 Aug 2002 15:16:36 -0400
Received: from sisko.nothing-on.tv ([213.208.99.114]:43650 "EHLO
	mail.cvsnt.org") by vger.kernel.org with ESMTP id <S317898AbSHaTQf>;
	Sat, 31 Aug 2002 15:16:35 -0400
Message-ID: <3D7117D3.5080100@nothing-on.tv>
Date: Sat, 31 Aug 2002 20:24:03 +0100
From: Tony Hoyle <tmh@nothing-on.tv>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020615 Debian/1.0.0-3
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Oops in pl2303 driver
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Razor-id: 0dfa94240368bbd4b695ccd2150dfbca8eb6792f
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just acquired a USB datacable for my phone which appears to have a 
PL2303 chipset in it (at least that's what hotplug loaded when I plugged 
it in).  However this driver doesn't appear to work...  No data is 
transferred and when the software (gnokii) gives up I get an oops:

Aug 31 20:05:31 spock kernel: Unable to handle kernel NULL pointer 
dereference at virtual address 00000014
Aug 31 20:05:31 spock kernel: d48a1344
Aug 31 20:05:31 spock kernel: *pde = 0d5e3067
Aug 31 20:05:31 spock kernel: Oops: 0000
Aug 31 20:05:31 spock kernel: CPU:    0
Aug 31 20:05:31 spock kernel: EIP: 
0010:[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-302268/96] 
    Not tainted
Aug 31 20:05:31 spock kernel: EFLAGS: 00010006
Aug 31 20:05:31 spock kernel: eax: cef18000   ebx: ffffff8d   ecx: 
cef8b400   edx: 00000000
Aug 31 20:05:31 spock kernel: esi: cee98c40   edi: 00000000   ebp: 
00000246   esp: c57c3e48
Aug 31 20:05:31 spock kernel: ds: 0018   es: 0018   ss: 0018
Aug 31 20:05:31 spock kernel: Process xgnokii (pid: 760, stackpage=c57c3000)
Aug 31 20:05:31 spock kernel: Stack: ffffff8d cee98c40 00000000 00000282 
d48a2b10 cee98c40 cee98c44 cee98c40
Aug 31 20:05:31 spock kernel:        00000286 cf0371c0 00000001 00000000 
cef18200 cf09826c d48a1fe2 cee98c40
Aug 31 20:05:31 spock kernel:        cef8b478 cef8b420 ffffffff cef8b400 
cf09826c d4891146 cee98c40 d48e5fb9
Aug 31 20:05:31 spock kernel: Call Trace: 
[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-296176/96] 
[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-299038/96] 
[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-368314/96] 
[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-20551/96] 
[usbmouse:__insmod_usbmouse_O/lib/modules/2.4.20-pre5/kernel/drivers/+-43801/96]
Aug 31 20:05:31 spock kernel: Code: 8b 52 14 8b 42 e8 8b 7a ec 25 00 00 
00 2f 0d 00 00 80 01 89


 >>eax; cef18000 <_end+ec4ecbc/14587d1c>
 >>ecx; cef8b400 <_end+ecc20bc/14587d1c>
 >>esi; cee98c40 <_end+ebcf8fc/14587d1c>
 >>esp; c57c3e48 <_end+54fab04/14587d1c>

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


1 warning issued.  Results may not be reliable.
spock:/home/tmh# lsmod
Module                  Size  Used by    Not tainted
soundcore               3556   0  (autoclean)
nfsd                   68208   8  (autoclean)
mousedev                3828   2
hid                    19332   0  (unused)
usbmouse                1812   0  (unused)
input                   3360   0  [mousedev hid usbmouse]
pl2303                 10424   1
usbserial              16188   0  [pl2303]
serial                 42404   0  (autoclean)
nfs                    64120   1  (autoclean)
lockd                  48688   1  (autoclean) [nfsd nfs]
sunrpc                 59932   1  (autoclean) [nfsd nfs lockd]
uhci                   24048   0  (unused)
usbcore                56480   1  [hid usbmouse pl2303 usbserial uhci]
raw1394                 6584   0  (unused)
ieee1394               30412   0  [raw1394]
radeon                 93760  15
agpgart                15060   3

Simply using 'cat /dev/ttyUSB0' seems to be enough to cause the oops, so 
it's definately the driver rather than the software.

Tony



