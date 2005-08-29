Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750735AbVH2GnS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750735AbVH2GnS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 02:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751131AbVH2GnS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 02:43:18 -0400
Received: from web8510.mail.in.yahoo.com ([202.43.219.172]:5055 "HELO
	web8510.mail.in.yahoo.com") by vger.kernel.org with SMTP
	id S1750735AbVH2GnR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 02:43:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.co.in;
  h=Message-ID:Received:Date:From:Subject:To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=4yTC97tWkCmOt9K/ckpOfGN/qkZbLAYJzlDvic52nhICUwoozw/fojmQGaorru38gBWo9FheHwmTy0jH1PU5Ncdw70Ha1pYCsGs1w1dX2KbB9NioDM4H5oZ0D6XkzuPso5PJ44l+9KVrqP/JAa01TVj8B//LPyrLI9MPzt+EFHk=  ;
Message-ID: <20050829064308.33986.qmail@web8510.mail.in.yahoo.com>
Date: Mon, 29 Aug 2005 07:43:08 +0100 (BST)
From: manomugdha biswas <manomugdhab@yahoo.co.in>
Subject: kernel panic
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1824763413-1125297788=:32985"
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

--0-1824763413-1125297788=:32985
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Id: 
Content-Disposition: inline

Hi,
I am using the following makefile and the .c file to
generate a kernel module. I can load this module
without error and warning. But when I call ioctl()
from user application to run this module it gets
kernel panic!

I am using redhat 9.0 and kernel 2.4.20-8.

testmngmnt.c:
=============
This file has been attached with this mail.

Makefile:
=========
# set the approriate value for additional cflags
GCC_VER := $(strip $(shell gcc -dumpversion))
XTRA_CFLAGS =
ifeq ($(GCC_VER), 3.2.2)
XTRA_CFLAGS = -DRH_9_0
endif # GCC_VER
ifeq ($(GCC_VER), 3.2.3)
XTRA_CFLAGS = -DRH_9_0
endif # GCC_VER
                                                      
                         
CC  = gcc
LD  = ld
LDFLAG = -r
LINUX_VERSION = linux-$(shell uname -r)
                                                      
                         
CFLAGS  = -g  -Wall -DMODULE -O2 -D__KERNEL__
$(XTRA_CFLAGS) -DLINK_ETHERNET \
    -I/usr/src/$(LINUX_VERSION)/include -I${INCLUDE}
-D__DEBUG__
                                                      
                         
dvr_objs = testmngmnt.o
                                                      
                         
                                                      
                         
test.o: ${dvr_objs}
  ld -X -r -o test.o ${dvr_objs} ; \
                                                      
                         
testmngmnt.o:  testmngmnt.c
  ${CC} ${CFLAGS} -c testmngmnt.c
                                                      
                         
clean:
  rm -f *.o *~ include/*~
                                                      
                         
all: test.o



Kernel panic dump:
==================
Unable to handle kernel NULL pointer dereference at
virtual address 00000005
 printing eip:
c0118ffd
*pde = 00000000
Oops: 0002
test soundcore ide-cd cdrom i830 agpgart parport_pc lp
parport cisco_ipsec autofs 8139too mii keybdev
mousedev hid input usb-uhci ehci-hcd usbcore ext3 jbd
CPU:    0
EIP:    0060:[<c0118ffd>]    Tainted: P
EFLAGS: 00210086
 
EIP is at interruptible_sleep_on_timeout [kernel] 0x2d
(2.4.20-8)
eax: f4f31f78   ebx: 00200286   ecx: f4f31f50   edx:
00000001
esi: 00000002   edi: f5050300   ebp: f4f31f60   esp:
f4f31f48
ds: 0068   es: 0068   ss: 0068
Process vnicClientMirro (pid: 4971,
stackpage=f4f31000)
Stack: 00000000 f4f30000 f5113980 f5113980 0000001d
00000000 f4f31f90 f8fe60b8
       f8fe615c 0000001d f5113fa4 f5113700 00000001
f4f31f7c f4f31f7c 00000000
       00000002 ffffffe7 00000003 c01566e9 bfffd880
f5050300 00000000 bfffd880
Call Trace:   [<f8fe60b8>] VNICClientStart [test] 0x58
(0xf4f31f64))
[<f8fe615c>] .rodata.str1.1 [test] 0x2c (0xf4f31f68))
[<c01566e9>] sys_ioctl [kernel] 0xc9 (0xf4f31f94))
[<c0109537>] system_call [kernel] 0x33 (0xf4f31fc0))
 
 
Code: 89 4a 04 89 55 f0 89 45 f4 89 08 89 f0 e8 a1 cb
00 00 89 c6

Could you please give some light on this issue?

Regards,
Manomugdhab

Manomugdha Biswas


		
_______________________________________________________ 
Too much spam in your inbox? Yahoo! Mail gives you the best spam protection for FREE! http://in.mail.yahoo.com
--0-1824763413-1125297788=:32985
Content-Type: application/octet-stream; name="testmngmnt.c"
Content-Transfer-Encoding: base64
Content-Description: 3024876882-testmngmnt.c
Content-Disposition: attachment; filename="testmngmnt.c"

LyoKICAKICBDb3B5cmlnaHQgKGMpIEl4aWEgMjAwMy0yMDA1CiAgQWxsIHJp
Z2h0cyByZXNlcnZlZC4KCiovCiNpbmNsdWRlIDxsaW51eC9jb25maWcuaD4K
I2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVkZSA8bGludXgva2Vy
bmVsLmg+CiNpbmNsdWRlIDxsaW51eC9pbml0Lmg+CiNpbmNsdWRlIDxsaW51
eC9zY2hlZC5oPgojaW5jbHVkZSA8bmV0L3RjcC5oPgojaW5jbHVkZSA8bGlu
dXgvc2tidWZmLmg+CiNpbmNsdWRlIDxhc20vdWFjY2Vzcy5oPgojaW5jbHVk
ZSA8bGludXgvbmV0ZGV2aWNlLmg+CgoKaW50ICAgICAgICAgICAgICAgICBz
Q2xpZW50TWFqb3JOdW0gPSAwOwpzdGF0aWMgaW50IFZOSUNDbGllbnRJb2N0
bChzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZSwKICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdW5zaWduZWQgaW50IGNtZCwgdW5z
aWduZWQgbG9uZyBhcmcpOwoKc3RhdGljIGludCBWTklDQ2xpZW50U3RhcnQo
dW5zaWduZWQgbG9uZyBhcmcpOwoKc3RhdGljIHN0cnVjdCBmaWxlX29wZXJh
dGlvbnMgVk5JQ0ZvcHMgPSB7CiAgICAgICAgb3duZXI6ICAgICAgICAgIFRI
SVNfTU9EVUxFLAogICAgICAgIGlvY3RsOiAgICAgICAgICBWTklDQ2xpZW50
SW9jdGwKfTsKCnN0YXRpYyBpbnQKVk5JQ0NsaWVudFN0YXJ0KHVuc2lnbmVk
IGxvbmcgYXJnKQp7CiAgdW5zaWduZWQgaW50ICAgICAgICAgICAgICAgcmV0
cnlDbnQgICA9IDMwOwogIERFQ0xBUkVfV0FJVF9RVUVVRV9IRUFEKHdxKTsK
ICBpbml0X3dhaXRxdWV1ZV9oZWFkKCZ3cSk7CiAgICAgIAogIHByaW50aygi
XG5yZXRyeSBjb3VudCAtLS0tLSA6ICVkXG4iLCByZXRyeUNudCk7CiAgd2hp
bGUgKHJldHJ5Q250KSB7CiAgICAtLXJldHJ5Q250OwogIHByaW50aygiXG5y
ZXRyeSBjb3VudCA6ICVkXG4iLCByZXRyeUNudCk7CgogICBpZiAoIXJldHJ5
Q250KSB7CiAgICAgcmV0dXJuIC0xOyAKICAgfSAKCiAgIC8qIHdhaXQgZm9y
IHNtYWxsICovCiAgIHByaW50aygiXG4rKysrYmVmb3JlIHNsZWVwKysrXG4i
KTsKICAgaW50ZXJydXB0aWJsZV9zbGVlcF9vbl90aW1lb3V0KCZ3cSwgMik7
IAogICBwcmludGsoIlxuKysrK2FmdGVyIHNsZWVwKysrXG4iKTsKICB9IC8q
IGVuZCB3aGlsZSAocmV0cnlDbnQpKi8KICByZXR1cm4gMDsgLyogZm9yIHN1
Y2Nlc3MgKi8KfSAvKiBlbmQgVk5JQ0NsaWVudFN0YXJ0KCkgKi8KCnN0YXRp
YyBpbnQKVk5JQ0NsaWVudElvY3RsKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHN0
cnVjdCBmaWxlICpmaWxlLAogICAgICAgICAgICAgIHVuc2lnbmVkIGludCBj
bWQsIHVuc2lnbmVkIGxvbmcgYXJnKQp7CiAgCiAgc3dpdGNoIChjbWQpIHsK
ICAgIC8vY2FzZSBWTklDX0NMSUVOVF9TVEFSVDoKICAgIGNhc2UgMDoKICAg
ICAgcmV0dXJuIFZOSUNDbGllbnRTdGFydChhcmcpOwogICAgICBicmVhazsK
ICAgIGRlZmF1bHQgOgogICAgICByZXR1cm4gMCA7CiAgICAgIGJyZWFrOwog
IH0gLyogRW5kIG9mIHN3aXRjaCAqLwoKICByZXR1cm4gMDsgLyogVk5JQ19J
T0NUTF9TVUNDRVNTICovCn0KCmludCBfX2luaXQKVk5JQ0NsaWVudE1vZHVs
ZUluaXQodm9pZCkKewogIC8qIHJlZ2lzdGVyIHRoZSBjaGFyYWN0ZXIgZGV2
aWNlICovCiAgc0NsaWVudE1ham9yTnVtID0gcmVnaXN0ZXJfY2hyZGV2KDAs
ICJWTklDQ2xpZW50IiwgJlZOSUNGb3BzKTsKICBpZiAoc0NsaWVudE1ham9y
TnVtIDwgMCkgewogICAgcmV0dXJuIC1FSU87CiAgfQogIHJldHVybiAwOwp9
Cgp2b2lkIApWTklDQ2xpZW50TW9kdWxlQ2xlYW5VcCh2b2lkKQp7CiAgLyog
dW5SZWdpdGVyIHRoZSBjaGFyYWN0ZXIgZGV2aWNlKCk7ICovCiAgdW5yZWdp
c3Rlcl9jaHJkZXYoc0NsaWVudE1ham9yTnVtLCAiVk5JQ0NsaWVudCIpOwp9
Cgptb2R1bGVfaW5pdChWTklDQ2xpZW50TW9kdWxlSW5pdCk7Cm1vZHVsZV9l
eGl0KFZOSUNDbGllbnRNb2R1bGVDbGVhblVwKTsKCiNpZmRlZiBNT0RVTEVf
TElDRU5TRQogIE1PRFVMRV9MSUNFTlNFKCJHUEwiKTsgCiNlbmRpZiAvKiBN
T0RVTEVfTElDRU5TRSAqLwo=

--0-1824763413-1125297788=:32985--
