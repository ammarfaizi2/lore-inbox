Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262844AbVGHUOQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262844AbVGHUOQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 16:14:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262869AbVGHUJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 16:09:58 -0400
Received: from vsmtp1alice.tin.it ([212.216.176.144]:14732 "EHLO
	vsmtp1alice.tin.it") by vger.kernel.org with ESMTP id S262844AbVGHUGg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 16:06:36 -0400
Message-ID: <42CEDC0B.2040803@inwind.it>
Date: Fri, 08 Jul 2005 22:03:23 +0200
From: federico <xaero@inwind.it>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050515)
X-Accept-Language: it, it-it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: kbd newbie [Fwd: Re: setkeycodes, sysrq, and USB keyboard]
X-Enigmail-Version: 0.90.2.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>>can you tell me in which source file this happens?
>>    
>>
> 
>drivers/char/keyboard.c 
>

i looked at that source (sincerely, this is the first time i look into
the linux sources! :)

int setkeycode(unsigned int scancode, unsigned int keycode)
{
...
    list_for_each(node,&kbd_handler.h_list) {
        struct input_handle *handle = to_handle_h(node);
        if (handle->dev->keycodesize) {
            dev = handle->dev;
            break;
        }
    }

    if (!dev)
        return -ENODEV;


here i try to change scandodes for a keycode, but the the kernel says
ENODEV.
$ cat /proc/bus/input/devices   says me:

I: Bus=0010 Vendor=001f Product=0001 Version=0100
N: Name="PC Speaker"
P: Phys=isa0061/input0
H: Handlers=kbd event0
...

I: Bus=0003 Vendor=045e Product=0084 Version=0000
N: Name="Microsoft Basic Optical Mouse"
...

I: Bus=0003 Vendor=05ac Product=0205 Version=0122
N: Name="Mitsumi Electric Apple Extended USB Keyboard"
P: Phys=usb-0000:00:02.1-1.1/input0
H: Handlers=kbd event2
B: EV=120013
B: KEY=10000 7 ff87207a c14057ff febeffdf ffefffff ffffffff fffffffe
B: MSC=10
B: LED=1f

I: Bus=0003 Vendor=05ac Product=0205 Version=0122
N: Name="Mitsumi Electric Apple Extended USB Keyboard"
P: Phys=usb-0000:00:02.1-1.1/input1
H: Handlers=kbd event3
B: EV=13
B: KEY=1 0 10000 17a 800c000 e0000 0 0 0
B: MSC=10


that handler "kbd" is the one that should receive the scancodes?
maybe the kernel can't get the device for that keyboard? or we miss a
scancode table?

sorry for my being so newbie ;)
ciao!
Federico


