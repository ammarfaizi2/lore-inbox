Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266069AbUF2VTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266069AbUF2VTl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Jun 2004 17:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266071AbUF2VTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Jun 2004 17:19:41 -0400
Received: from damned.travellingkiwi.com ([81.6.239.220]:22059 "EHLO
	ballbreaker.travellingkiwi.com") by vger.kernel.org with ESMTP
	id S266069AbUF2VTf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Jun 2004 17:19:35 -0400
Message-ID: <40E1DCD0.7090604@travellingkiwi.com>
Date: Tue, 29 Jun 2004 22:19:12 +0100
From: Hamie <hamish@travellingkiwi.com>
User-Agent: Mozilla Thunderbird 0.6 (X11/20040605)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: 2.6.7-mm4 compile buglet
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all.

Sorry. Wasn't sure if this short of thing should be raised on bugtracker 
or not... Basically I downloaded 2.6.7-mm4 because I found a kernel bug 
that was apparently fixed in -mm2 (& hopefully later) where the acpi 
button events get 'lost' after a suspend-resume.

It appears that the -=mm4 patch introduces a bug however where it won't 
compile unless local apic is defined due to the following

  LD      arch/i386/lib/built-in.o
  CC      arch/i386/lib/bitops.o
  AS      arch/i386/lib/checksum.o
  CC      arch/i386/lib/dec_and_lock.o
  CC      arch/i386/lib/delay.o
  AS      arch/i386/lib/getuser.o
  CC      arch/i386/lib/memcpy.o
  CC      arch/i386/lib/strstr.o
  CC      arch/i386/lib/usercopy.o
  AR      arch/i386/lib/lib.a
  GEN     .version
  CHK     include/linux/compile.h
  UPD     include/linux/compile.h
  CC      init/version.o
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.init.text+0x90ed): In function `do_wrlvtpc':
: undefined reference to `apic_write'
drivers/built-in.o(.init.text+0x90fd): In function `do_wrlvtpc':
: undefined reference to `apic_write'
drivers/built-in.o(.init.text+0x910d): In function `do_wrlvtpc':
: undefined reference to `apic_write'
drivers/built-in.o(.init.text+0x911d): In function `do_wrlvtpc':
: undefined reference to `apic_write'
drivers/built-in.o(.init.text+0x912d): In function `do_wrlvtpc':
: undefined reference to `apic_write'
drivers/built-in.o(.init.text+0x913d): more undefined references to 
`apic_write' follow
make: *** [.tmp_vmlinux1] Error 1
ballbreaker:/archive/linux/kernel/linux-2.6.7#


apic_write seems to be defined in apic.h & ifdef'ed out if local apic is 
not selected, however there are several calls to it that aren't ifdef'ed 
out...

Turning on local apic means the kernel compiles... But in the past this 
introduces a power down bug on the thinkpad where a shutdown won't power 
off the laptop without a manual off using the power button (Sorry. 
Haven't had a chance to test whether this would be fixed in -mm4 or not 
yet).

regards
  Hamish.

