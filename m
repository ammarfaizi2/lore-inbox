Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S276903AbRJCHvQ>; Wed, 3 Oct 2001 03:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S276905AbRJCHvG>; Wed, 3 Oct 2001 03:51:06 -0400
Received: from [195.66.192.167] ([195.66.192.167]:41735 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S276903AbRJCHu6>; Wed, 3 Oct 2001 03:50:58 -0400
Date: Wed, 3 Oct 2001 10:49:35 +0200
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <694747236.20011003104935@port.imtp.ilyichevsk.odessa.ua>
To: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
CC: linux-kernel@vger.kernel.org
Subject: Re: System reset on Kernel 2.4.10
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz>
In-Reply-To: <527872464EC@vcnet.vc.cvut.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Petr,
Wednesday, October 03, 2001, 2:02:28 PM, you wrote:
PV> Look at fs/binfmt_elf.c, at line 642 (in -ac2). There is

PV> error = elf_map(....)

PV> but nobody bothers with checking error value, it even tries it
PV> to use as an offset if stars are in wrong constellation.
PV> If you could add these lines below the call:

PV> if ((unsigned long)error >= (unsigned long)(-256)) {
PV>   set_fs(old_fs);
PV>   printk(KERN_DEBUG "Something went wrong with elf_map()\n");
PV>   kfree(elf_phdata);
PV>   send_sig(SIGSEGV, current, 0);
PV>   return 0;
PV> }

PV> and then report results...

It fixes reboot for me. Now vmlinux segfaults, and I see
"Something went wrong with elf_map()" in the log.
-- 
Best regards, VDA
mailto:VDA@port.imtp.ilyichevsk.odessa.ua


