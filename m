Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283375AbRK2SUp>; Thu, 29 Nov 2001 13:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283376AbRK2SUg>; Thu, 29 Nov 2001 13:20:36 -0500
Received: from mailout04.sul.t-online.com ([194.25.134.18]:35977 "EHLO
	mailout04.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S283375AbRK2SUa>; Thu, 29 Nov 2001 13:20:30 -0500
Date: Thu, 29 Nov 2001 19:19:38 +0100
From: Dirk Pritsch <dirk@enterprise.in-berlin.de>
To: linux-kernel@vger.kernel.org
Subject: oops with 2.5.1-pre3 in ide-scsi module 
Message-ID: <20011129191938.A1402@Enterprise.in-berlin.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.23i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

just tried the new 2.5.1-pre3 and got the following oops when trying to
burn a cd (ide-cd/rw with ide-scsi emulation).

I Hope this is some useful information.


____
ksymoops 2.4.3 on i586 2.5.1-pre3.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.5.1-pre3/ (default)
     -m /boot/System.map-2.5.1-pre3 (default)

Warning: You did not tell me where to find
symbol information.  I will
assume that the log matches the kernel and
modules that are running
right now and I'll use the default options
above for symbol resolution.
If the current kernel and/or modules do not
match the log, you can get
more accurate output by telling me the kernel
version and where to find
map, modules, ksyms etc.  ksymoops -h explains
the options.


Unable to handle kernel NULL pointer dereference at virtual address
00000038
c01af582
*pde = 00000000
Oops: 0000
CPU:    0
EIP:    0010:[idescsi_queue+1158/1396]    Not tainted
EFLAGS: 00210002
eax: 00000000   ebx: d3f64320   ecx: d3f64ea0   edx: 00000000
esi: c0989000   edi: d3f64ea0   ebp: d3f64320   esp: c7321cc4
ds: 0018   es: 0018   ss: 0018
Process cdrecord (pid: 1055, stackpage=c7321000)
Stack: 00200293 d36761d4 d3eef800 d3f2dba0 00000000 c8a76ee0 d3eef858 c0989000 
       00000001 00000000 c7d5d3c0 c150eee0 c02c3be4 c01a7309 d3eef800 c01a77b4 
       d3eef800 d36761d4 d3eef8b8 d36761d4 00000000 c01ac422 d3eef800 d3eef800 
Call Trace: [scsi_dispatch_cmd+257/372] [scsi_done+0/144] [scsi_request_fn+786/808] [__scsi_in sert_special+118/128] [scsi_insert_special_req+25/32] 
Code: 03 42 38 89 46 00 83 c6 14 89 74 24 1c 83 6c 24 20 01 73 bf 
Using defaults from ksymoops -t elf32-i386 -a i386

Code;  00000000 Before first symbol
00000000 <_EIP>:
Code;  00000000 Before first symbol
   0:   03 42 38                  add    0x38(%edx),%eax
Code;  00000002 Before first symbol
   3:   89 46 00                  mov    %eax,0x0(%esi)
Code;  00000006 Before first symbol
   6:   83 c6 14                  add    $0x14,%esi
Code;  00000008 Before first symbol
   9:   89 74 24 1c               mov %esi,0x1c(%esp,1)
Code;  0000000c Before first symbol
   d:   83 6c 24 20 01            subl $0x1,0x20(%esp,1)
Code;  00000012 Before first symbol
  12:   73 bf                     jae ffffffd3 <_EIP+0xffffffd3> ffffffd2 <END_OF_CODE+2af53fd0/????>


1 warning issued.  Results may not be reliable.
____

After the oops the following message appeared in syslog:

Nov 29 18:06:01 enterprise kernel:  <6>scsi: device set offline -
command error recover failed: host 0 channel 0 id 0 lun 0

____

lsmod shows no loaded ide-scsi or cdrom modules, so the oops happened
before loading them.

____




Please CC: me in replies or if you need further information as I'm not
subscribed to l-k.


Cheers,

Dirk

