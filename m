Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbUDMPwr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Apr 2004 11:52:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263561AbUDMPwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Apr 2004 11:52:47 -0400
Received: from natnoddy.rzone.de ([81.169.145.166]:46493 "EHLO
	natnoddy.rzone.de") by vger.kernel.org with ESMTP id S263607AbUDMPwi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Apr 2004 11:52:38 -0400
Date: Tue, 13 Apr 2004 17:50:22 +0200
From: Peter Seiderer <seiderer123@ciselant.de>
To: linux-kernel@vger.kernel.org
Subject: [Bug][2.6.5] SEGV while video memory mmaped, computer hangs
Message-ID: <20040413155022.GA1711@zodiak>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="gBBFr7Ir9EOA20Yy"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello,
the following short programm stops (no more input, no telnet login, etc...)
my linux system (kernel 2.6.5) immediately (this is the short version of what
xfree does on XF86DGADirectVideo(), mmap the video memory).

SysRq-t tells that bash hangs with the following call trace:

handle_mm_fault
do_page_fault
sys_wait4
sigprocmask
default_wake_function
sys_rt_sigprocmask
default_ware_function
syscall_call

Thanks in advance for your help,
Peter

#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/mman.h>
#include <assert.h>

int main(int argc, char *argv[]) {
        int fd;
        assert((fd = open("/dev/mem", O_RDWR)) != (-1));

        size_t s = 67108864;
        void *m;
        assert((m = mmap(NULL, s, PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0xd0000000)) != NULL);

        char *c = 0;
        char a = *c;
        return 0;
}

-- 
------------------------------------------------------------------------
Peter Seiderer                     E-Mail:  seiderer123@ciselant.de

--gBBFr7Ir9EOA20Yy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="iomem.txt"

00000000-0009fbff : System RAM
0009fc00-0009ffff : reserved
000a0000-000bffff : Video RAM area
000cd000-000ce7ff : Extension ROM
000d0000-000d8007 : reserved
000f0000-000fffff : System ROM
00100000-1ffeffff : System RAM
  00100000-0033660e : Kernel code
  0033660f-003d72ff : Kernel data
1fff0000-1fff7fff : ACPI Tables
1fff8000-1fffffff : ACPI Non-volatile Storage
20000000-200003ff : 0000:00:1f.1
cb400000-db5fffff : PCI Bus #01
  d0000000-d7ffffff : 0000:01:00.0
db800000-db9fffff : PCI Bus #01
  db9f0000-db9fffff : 0000:01:00.0
dc000000-ddffffff : 0000:03:02.0
dfc00000-dfdfffff : 0000:03:02.0
dfec0000-dfedffff : 0000:03:04.0
  dfec0000-dfedffff : e100
dfefe000-dfefefff : 0000:03:04.0
  dfefe000-dfefefff : e100
dffff900-dffff9ff : 0000:00:1f.5
dffffa00-dffffbff : 0000:00:1f.5
dffffc00-dfffffff : 0000:00:1d.7
e0000000-e3ffffff : 0000:00:00.0
fec00000-fec00fff : reserved
fee00000-fee00fff : reserved
ffb00000-ffbfffff : reserved
fff00000-ffffffff : reserved

--gBBFr7Ir9EOA20Yy--
