Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266813AbUHOPzE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266813AbUHOPzE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Aug 2004 11:55:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266824AbUHOPzE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Aug 2004 11:55:04 -0400
Received: from ool-44c1e325.dyn.optonline.net ([68.193.227.37]:55763 "HELO
	dyn.galis.org") by vger.kernel.org with SMTP id S266813AbUHOPy6
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Aug 2004 11:54:58 -0400
From: "George Georgalis" <george@galis.org>
Mail-Followup-To: netdev@oss.sgi.com,
  linux-kernel@vger.kernel.org,
  romieu@fr.zoreil.com,
  alan@lxorguk.ukuu.org.uk
Date: Sun, 15 Aug 2004 11:54:57 -0400
To: Francois Romieu <romieu@fr.zoreil.com>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: netdev@oss.sgi.com, linux-kernel@vger.kernel.org
Subject: Re: kernel-2.6.8.1 EIP is at velocity_netdev_event+0x16/0x50
Message-ID: <20040815155457.GB32195@trot.local>
References: <20040815095814.GA32195@trot.local> <20040815110625.GA2829@electric-eye.fr.zoreil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040815110625.GA2829@electric-eye.fr.zoreil.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 15, 2004 at 01:06:25PM +0200, Francois Romieu wrote:
>George Georgalis <george@galis.org> :
>[...]
>> Unable to handle kernel NULL pointer dereference at virtual address 000000e4
>>  printing eip:
>> c03034d6
>> *pde = 00000000
>> Oops: 0000 [#1]
>> PREEMPT 
>> CPU:    0
>> EIP:    0060:[<c03034d6>]    Not tainted
>> EFLAGS: 00010282   (2.6.8.1) 
>> EIP is at velocity_netdev_event+0x16/0x50
>> eax: 00000000   ebx: c060b724   ecx: 00000000   edx: f7d7dd60
>> esi: f6d771e0   edi: 00000001   ebp: 0100007f   esp: f6ccdeb4
>> ds: 007b   es: 007b   ss: 0068
>> Process ifconfig (pid: 328, threadinfo=f6ccc000 task=f6ca80d0)
>
>You may apply on top of your 2.6.8.1 kernel:
>http://www.fr.zoreil.com/people/francois/misc/20040815-2.6.8-via-velocity-test.patch
>
>It will sync the via-velocity driver with the one in 2.6.8-rc4-mm1.
>It is supposed to fix this issue.
>
>Once the patch is applied, it will be interesting to know if CONFIG_SUPEND
>makes a difference or not.
>
>Please add netdev@oss.sgi.com to the Cc:

...that patch doesn't build

  26674 Aug 15 06:51 ../20040815-2.6.8-via-velocity-test.patch

$ cd linux-2.6.8.1-via-velocity-test/
$ patch -p1 <../20040815-2.6.8-via-velocity-test.patch
patching file drivers/net/via-velocity.h
patching file drivers/net/via-velocity.c
$ make bzImage
make[1]: `arch/i386/kernel/asm-offsets.s' is up to date.
  CHK     include/linux/compile.h
  OUI2C   drivers/ieee1394/oui.c
  CC      drivers/ieee1394/oui.o
  LD      drivers/ieee1394/ieee1394.o
  LD      drivers/ieee1394/built-in.o
  CC      drivers/net/via-velocity.o
drivers/net/via-velocity.c:310: error: `PCI_DEVICE_ID_VIA_612X' undeclared here (not in a function)
drivers/net/via-velocity.c:310: error: initializer element is not constant
drivers/net/via-velocity.c:310: error: (near initialization for `velocity_id_table[0].device')
drivers/net/via-velocity.c:311: error: initializer element is not constant
drivers/net/via-velocity.c:311: error: (near initialization for `velocity_id_table[0]')
drivers/net/via-velocity.c:312: error: initializer element is not constant
drivers/net/via-velocity.c:312: error: (near initialization for `velocity_id_table[1]')
make[2]: *** [drivers/net/via-velocity.o] Error 1
make[1]: *** [drivers/net] Error 2
make: *** [drivers] Error 2

Also note, I don't actually have one of these devices to test, I only
included it in case I come across one.

// George

-- 
George Georgalis, Architect and administrator, Linux services. IXOYE
http://galis.org/george/  cell:646-331-2027  mailto:george@galis.org
Key fingerprint = 5415 2738 61CF 6AE1 E9A7  9EF0 0186 503B 9831 1631
