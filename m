Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312973AbSDYHof>; Thu, 25 Apr 2002 03:44:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312980AbSDYHoe>; Thu, 25 Apr 2002 03:44:34 -0400
Received: from smtp1.libero.it ([193.70.192.51]:31638 "EHLO smtp1.libero.it")
	by vger.kernel.org with ESMTP id <S312973AbSDYHod>;
	Thu, 25 Apr 2002 03:44:33 -0400
Date: Thu, 25 Apr 2002 09:44:26 +0200
From: Luca Amigoni <alnet@tin.it>
To: linux-kernel@vger.kernel.org
Subject: [BUG] emu10k1 driver BUG()
Message-Id: <20020425094426.01239ae5.alnet@tin.it>
X-Mailer: Sylpheed version 0.7.4claws (GTK+ 1.2.10; i386-debian-linux-gnu)
X-Operating-System: Debian GNU/Linux
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart_Thu__25_Apr_2002_09:44:26_+0200_082ce638"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.

--Multipart_Thu__25_Apr_2002_09:44:26_+0200_082ce638
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I'm trying to use rawrec with a SB Live, but I get a kernel BUG():

al@mater:~$ rawrec file.raw
 kernel BUG at audio.c:1474!
 invalid operand: 0000
 CPU:    0
 EIP:    0010:[<e289a343>]    Not tainted
 EFLAGS: 00010082
 eax: 00000029   ebx: df979d08   ecx: c0332958   edx: de718000
 esi: 0000e000   edi: 00005555   ebp: 00003556   esp: de719ecc
 ds: 0018   es: 0018   ss: 0018
 Process rawrec (pid: 558, stackpage=de719000)
 Stack: e28a29a0 0000e000 00005555 00000202 df979cc0 00000000 bffff038 0000ffff
        00018000 0001c000 00010000 00014000 e289962e df979cc0 c0045004 ffffffe7
        bffff038 dfb9c0c0 c168d340 e28a49c0 dfb9c0c0 00000000 df979cc0 00000000
 Call Trace: [<e28a29a0>] [<e289962e>] [<e28a49c0>] [<c0135d42>] [<c0142ee9>]
    [<c01086e3>]

 Code: 0f 0b c5 05 80 29 8a e2 83 c4 0c 89 f6 5b 5e 5f 5d 83 c4 14
 Segmentation fault


In line 1474 I see

if (buffer->size % buffer->fragment_size)
	BUG();

I've added a printk just before the BUG() call and I got this:

buffer->size = 57344; buffer->fragment_size = 21845

Kernel version is 2.4.19-pre7-ac2, same with 2.4.19-pre3-ac6 + preempt patch.
I've not tried with earlier versions, nor 2.5.x tree.
Attached file is an 'lspci -vv' output relative to the sound card.

Loaded modules are:

al@mater:~$ /sbin/lsmod 
Module                  Size  Used by    Tainted: PF 
smbfs                  33216   2 (autoclean)
mousedev                3968   1
usb-storage            21116   0 (unused)
hid                    12992   0 (unused)
input                   3456   0 [mousedev hid]
usb-uhci               22404   0 (unused)
usbcore                37600   0 [usb-storage hid usb-uhci]
emu10k1                59328   0
ac97_codec              9696   0 [emu10k1]
sound                  55276   0 [emu10k1]
8139too                14272   1
mii                     1136   0 [8139too]



Regards,

  Luca

--Multipart_Thu__25_Apr_2002_09:44:26_+0200_082ce638
Content-Type: text/plain;
 name="lspci.out"
Content-Disposition: attachment;
 filename="lspci.out"
Content-Transfer-Encoding: base64

MDA6MGIuMCBNdWx0aW1lZGlhIGF1ZGlvIGNvbnRyb2xsZXI6IENyZWF0aXZlIExhYnMgU0IgTGl2
ZSEgRU1VMTBrMSAocmV2IDA0KQogICAgICAgIFN1YnN5c3RlbTogQ3JlYXRpdmUgTGFicyBDVDQ2
MjAgU0JMaXZlIQogICAgICAgIENvbnRyb2w6IEkvTysgTWVtLSBCdXNNYXN0ZXIrIFNwZWNDeWNs
ZS0gTWVtV0lOVi0gVkdBU25vb3AtIFBhckVyci0gU3RlcHBpbmctIFNFUlItIEZhc3RCMkItCiAg
ICAgICAgU3RhdHVzOiBDYXArIDY2TWh6LSBVREYtIEZhc3RCMkIrIFBhckVyci0gREVWU0VMPW1l
ZGl1bSA+VEFib3J0LSA8VEFib3J0LSA8TUFib3J0LSA+U0VSUi0gPFBFUlItCiAgICAgICAgTGF0
ZW5jeTogMzIgKDUwMG5zIG1pbiwgNTAwMG5zIG1heCkKICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBB
IHJvdXRlZCB0byBJUlEgMTIKICAgICAgICBSZWdpb24gMDogSS9PIHBvcnRzIGF0IGQwMDAgW3Np
emU9MzJdCiAgICAgICAgQ2FwYWJpbGl0aWVzOiBbZGNdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lv
biAxCiAgICAgICAgICAgICAgICBGbGFnczogUE1FQ2xrLSBEU0ktIEQxLSBEMi0gQXV4Q3VycmVu
dD0wbUEgUE1FKEQwLSxEMS0sRDItLEQzaG90LSxEM2NvbGQtKQogICAgICAgICAgICAgICAgU3Rh
dHVzOiBEMCBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1FLQo=

--Multipart_Thu__25_Apr_2002_09:44:26_+0200_082ce638--
