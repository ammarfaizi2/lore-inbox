Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264158AbTGBATN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Jul 2003 20:19:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264178AbTGBATM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Jul 2003 20:19:12 -0400
Received: from H239-211.STATE.RESNET.ALBANY.EDU ([169.226.239.211]:8087 "EHLO
	bouncybouncy.net") by vger.kernel.org with ESMTP id S264158AbTGBATG convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Jul 2003 20:19:06 -0400
Subject: usb serial/visor oops in 2.4.22-pre2
From: Justin A <justin@bouncybouncy.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Message-Id: <1057106020.22290.17.camel@s.bouncybouncy.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.0 
Date: 01 Jul 2003 20:33:40 -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

basically, pilot-xfer and all don't work anymore, dmesg reports:

hub.c: new USB device 00:11.2-1, assigned address 3
usb.c: USB device 3 (vend/prod 0x82d/0x100) is not claimed by any active
driver.
usb.c: registered new driver serial
usbserial.c: USB Serial support registered for Generic
usbserial.c: USB Serial Driver core v1.4
usbserial.c: USB Serial support registered for Handspring Visor / Treo /
Palm 4.0 / Clié 4.x
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter
detected
visor.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x: Number of ports:
2
visor.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x: port 1, is for
Generic use and is bound to ttyUSB0
visor.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x: port 2, is for
HotSync use and is bound to ttyUSB1
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter now
attached to ttyUSB0 (or usb/tts/0 for devfs)
usbserial.c: Handspring Visor / Treo / Palm 4.0 / Clié 4.x converter now
attached to ttyUSB1 (or usb/tts/1 for devfs)
usbserial.c: USB Serial support registered for Sony Clié 3.5
visor.c: USB HandSpring Visor, Palm m50x, Treo, Sony Clié driver v1.7
usb-uhci.c: interrupt, status 3, frame# 1201
usb.c: USB disconnect on device 00:11.2-1 address 3
visor.c: Bytes In = 0  Bytes Out = 0
Unable to handle kernel NULL pointer dereference at virtual address
000009a4
 printing eip:
e2302d96
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<e2302d96>]    Tainted: P 
EFLAGS: 00013246
eax: 00000000   ebx: dd66d01c   ecx: ddf30000   edx: 00000001
esi: 00000001   edi: dd66d000   ebp: 00000000   esp: defdbf4c
ds: 0018   es: 0018   ss: 0018
Process khubd (pid: 61, stackpage=defdb000)
Stack: e2303fa0 df44bb40 e2303fc0 e097f09a de963200 dd66d000 00000100
00000001 
       df0b4600 00000000 00000000 de963200 e09814da df0b4710 00000000
00000001 
       df0b4600 de8e62c0 00000000 de8e62e8 0000000a e098177d de8e62c0
00000000 
Call Trace:    [<e2303fa0>] [<e2303fc0>] [<e097f09a>] [<e09814da>]
[<e098177d>]
  [<e0981945>] [<c01055b8>]

Code: c7 80 a4 09 00 00 00 00 00 00 8d 4b 5c ff 43 5c 0f 8e 06 04 

which is
>>EIP; e2302d96 <[usbserial]usb_serial_disconnect+66/1f0>   <=====

>>ebx; dd66d01c <_end+1d325db0/205f3df4>
>>ecx; ddf30000 <_end+1dbe8d94/205f3df4>
>>edi; dd66d000 <_end+1d325d94/205f3df4>
>>esp; defdbf4c <_end+1ec94ce0/205f3df4>

Trace; e2303fa0 <[usbserial]usb_serial_driver+0/3c>
Trace; e2303fc0 <[usbserial]usb_serial_driver+20/3c>
Trace; e097f09a <[usbcore]usb_disconnect+8a/130>
Trace; e09814da <[usbcore]usb_hub_port_connect_change+4a/210>
Trace; e098177d <[usbcore]usb_hub_events+dd/270>
Trace; e0981945 <[usbcore]usb_hub_thread+35/b0>
Trace; c01055b8 <arch_kernel_thread+28/40>

Code;  e2302d96 <[usbserial]usb_serial_disconnect+66/1f0>
00000000 <_EIP>:
Code;  e2302d96 <[usbserial]usb_serial_disconnect+66/1f0>   <=====
   0:   c7 80 a4 09 00 00 00      movl   $0x0,0x9a4(%eax)   <=====
Code;  e2302d9d <[usbserial]usb_serial_disconnect+6d/1f0>
   7:   00 00 00 
Code;  e2302da0 <[usbserial]usb_serial_disconnect+70/1f0>
   a:   8d 4b 5c                  lea    0x5c(%ebx),%ecx
Code;  e2302da3 <[usbserial]usb_serial_disconnect+73/1f0>
   d:   ff 43 5c                  incl   0x5c(%ebx)
Code;  e2302da6 <[usbserial]usb_serial_disconnect+76/1f0>
  10:   0f 8e 06 04 00 00         jle    41c <_EIP+0x41c>

This is very strange since the visor has always worked perfectly, but
recently stopped, I've tried messing with older versions of pilot-link,
switching usb slots...  I have a feeling it's probably heat related.

I don't know where the Oops is coming from, before it would just hang,
now it oopses.
CC: replies :)
-- 
Justin A <justin@bouncybouncy.net>
