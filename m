Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312209AbSCRGZt>; Mon, 18 Mar 2002 01:25:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312210AbSCRGZk>; Mon, 18 Mar 2002 01:25:40 -0500
Received: from smtp1.extremenetworks.com ([216.52.8.6]:11140 "HELO
	smtp1.extremenetworks.com") by vger.kernel.org with SMTP
	id <S312209AbSCRGZY>; Mon, 18 Mar 2002 01:25:24 -0500
Message-ID: <3C95884C.DCD11F6F@extremenetworks.com>
Date: Sun, 17 Mar 2002 22:25:16 -0800
From: Jason Li <jli@extremenetworks.com>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.2-2smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: EXPORT_SYMBOL doesn't work
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

Have been puzzled by the problem for a couple of hours now, can some
experts here please help me out. Thanks very much for any info you can
provide here. Please remember to reply back to me also as I am not on
the list yet.

I am trying to use module to do kernel development. Currently I have
some code to be loaded as a module. In the code though I need some hooks
to the existing kernel.

Basically I am working on the bridge code. In the bridge there is a hook
created by myslef as:



int (*fdbIoSwitchHook)(
                           unsigned long arg0,
                           unsigned long arg1,
                           unsigned long arg2)=NULL;
EXPORT_SYMBOL(fdbIoSwitchHook);


The hook will be connected by my module on module_init:

	fdbIoSwitchHook = myFdbFunc;

But the symbol fdbIoSwitchHook can't bve resolved by the insmod for my
module.

I saw there is no fdbIoSwitchHook in the /proc/ksyms. My kernel is
versioned it seems.


When I compile the export_symbol file, it did complained:
gcc -D__KERNEL__ -I/home/jli/cvs2/exos/linux/include -Wall
-Wstrict-prototypes -Wno-trigraphs -O2 -fomit-frame-pointer
-fno-strict-aliasing -fno-common -pipe -mpreferred-stack-boundary=2
-march=i686    -c -o br_ioctl.o br_ioctl.c
br_ioctl.c:26: warning: type defaults to `int' in declaration of
`EXPORT_SYMBOL'
br_ioctl.c:26: warning: parameter names (without types) in function
declaration
br_ioctl.c:26: warning: data definition has no type or storage class
br_ioctl.c: In function `br_ioctl_device':
br_ioctl.c:206: warning: implicit declaration of function `fdbShow'

Can someone please shed some light on this please? I don't understand
why the symbol is not exported and what I need to do to finished my task
ahead.

Best regards,
Jason
