Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130290AbQL3P5Y>; Sat, 30 Dec 2000 10:57:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130614AbQL3P5D>; Sat, 30 Dec 2000 10:57:03 -0500
Received: from pipe.aspec.ru ([195.161.29.125]:17927 "EHLO pipe.aspec.ru")
	by vger.kernel.org with ESMTP id <S130290AbQL3P5A>;
	Sat, 30 Dec 2000 10:57:00 -0500
Message-ID: <002301c07274$dcf217c0$771da1c3@aspec.ru>
From: "Dmitry Melekhov" <dm@belkam.com>
To: <linux-kernel@vger.kernel.org>
Subject: 2.2.18 oops
Date: Sat, 30 Dec 2000 19:26:20 +0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="koi8-r"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2615.200
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2615.200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I have problems with kernels >=2.2.15
Always have similar oops about 1-2 times per week.
2.2.13 works good for me, but now I need big ide drive support.
I don't tried 2.2.14 yet, but looks like bug is in 2.2.14 and greater.
I have dual processors server with 5 eepro100 interfaces (2 cards are dual),
I think that problem is in eepro dirver, but not shure- I'm not programmer.
Anyway, I need help, because I need big ide drive support and can't use
new kernels, because they crash. Possibly I need patch for 2.2.13 with big
ide drives support.

Here is oops trace for 2.2.18 ( I posted oops for 2.2.15, 2.2.16 and
2.2.17pre3 before)

WARNING: This version of ksymoops is obsolete.
WARNING: The current version can be obtained from ftp://ftp.<country>
/pub/linux/utils/kernel/ksymoops
Options used: -V (default)
              -o /lib/modules/2.2.18/ (default)
              -k /proc/ksyms (default)
              -l /proc/modules (default)
              -m /usr/src/linux/System.map (default)
              -c 1 (default)

You did not tell me where to find symbol information.  I will assume
that the log matches the kernel and modules that are running right no
and I'll use the default options above for symbol resolution.
If the current kernel and/or modules do not match the log, you can ge
more accurate output by telling me the kernel version and where to fi
map, modules, ksyms etc.  ksymoops -h explains the options.

Oops: 0000
CPU: 0
EIP: 0010: [<c01669d8>]
EFLAGS: 00010286
eax: f1048197 ebx: cf8d4500 ecx: 00000014 edx: 0000003c
esi: 0000003c edi: de7bb0e4 ebp: f1048197 esp: dffebd80
ds: 0018
Stack: de7bb04e de7bbea4 e00510b0 cf8d4500 f1048197 0000003c 00000000
00004000
       de7bb04e de7bb000 00004050 00000014 de7bb8e4 00000014 00000001
0000003f
       e0050aad de7bb000 de860760 04000001 00000000 00000005 e0055000
000000c8
Call Trace: [<e00510b0>] [<e0050aad>] [<e0055000>] [<e0055000>] [<c010bbe2>]
[<c
01107da>] [<c010b853>]
            [<c010a328>] [<c0170018>] [<c01f6470>] [<c01f6508>] [<c0166a47>]
[<e
00510b0>] [<e0050aad>] [<e005d000>]
            [<e005d000>] [<c010b6e2>] [<c01107da>] [<c010b853>] [<c010a328>]
[<c
0107a65>] [<c010a2fa>] [<c011b5e1>]
            [<c010b86a>] [<c010a328>]
Code: 66 83 7d 0c 08 74 21 8b bb 80 00 00 00 00 89 d1 c1 e9 02 89 ce

>>EIP: c01669d8 <eth_copy_and_sum+10/90>
Trace: e00510b0 <speedo_rx+18c/2c4>
Trace: e0050aad <speedo_interrupt+d5/350>
Trace: e0055000 <root_speedo_dev+1f18/????>
Trace: e0055000 <root_speedo_dev+1f18/????>
Trace: c010bbe2 <probe_irq_off+26/90>
Trace: c01107da <do_level_ioapic_IRQ+62/a0>
Trace: c010b853 <do_IRQ+3b/5c>
Trace: c010a328 <common_interrupt+18/20>
Trace: e005d000 <END_OF_CODE+9f18/????>
Trace: c010b86a <do_IRQ+52/5c>
Code:  c01669d8 <eth_copy_and_sum+10/90>       00000000 <_EIP>: <===
Code:  c01669d8 <eth_copy_and_sum+10/90>          0:    66 83 7d 0c 08
cmpw   $0x8,0xc(%ebp) <===
Code:  c01669dd <eth_copy_and_sum+15/90>          5:    74 21
je      c0166a00 <eth_copy_and_sum+38/90>
Code:  c01669df <eth_copy_and_sum+17/90>          7:    8b bb 80 00 00 00
movl   0x80(%ebx),%edi
Code:  c01669e5 <eth_copy_and_sum+1d/90>          d:    00 89 d1 c1 e9 02
addb   %cl,0x2e9c1d1(%ecx)
Code:  c01669eb <eth_copy_and_sum+23/90>         13:    89 ce
movl   %ecx,%esi

Aiee, killing interrupt handler
Kernel panic: Attemted to kill idle task!



Please, help me!


-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
