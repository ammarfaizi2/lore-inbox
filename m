Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263279AbTE3FZ4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 May 2003 01:25:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263280AbTE3FZ4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 May 2003 01:25:56 -0400
Received: from a11a.mannikko1.ton.tut.fi ([195.148.185.30]:31757 "EHLO
	a11a.mannikko1.ton.tut.fi") by vger.kernel.org with ESMTP
	id S263279AbTE3FZy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 May 2003 01:25:54 -0400
Date: Fri, 30 May 2003 08:38:58 +0300
From: Pasi Savolainen <psavo@iki.fi>
To: "akpm@digeo.com" <AndrewMorton@a11a.mannikko1.ton.tut.fi>,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: 2.5.70-mm2, modprobe mga oops, modutils hangs -> machine unbootable
Message-ID: <20030530053858.GA15114@a11a.mannikko1.ton.tut.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!
Running 2.7.70-mm2 (with two ext3 patches akpm posted), after starting
XFree86, which tries to modprobe mga I get an Oops (below). After that,
every single modutils command hangs. Attached is also 'strace modprobe mii'
(mii is compiled as module and not loaded on boot). strace was killable with
ctrl-c, but subsequent 'modprobe mii', wasn't.



May 30 08:00:50 tienel kernel: mga: Unknown symbol flush_tlb_all
May 30 08:00:50 tienel kernel:  printing eip:
May 30 08:00:50 tienel kernel: c013b3ec
May 30 08:00:50 tienel kernel: Oops: 0000 [#1]
May 30 08:00:50 tienel kernel: PREEMPTSMP 
May 30 08:00:50 tienel kernel: CPU:    1
May 30 08:00:50 tienel kernel: EIP:    0060:[load_module+2316/2896]    Not tainted VLI
May 30 08:00:50 tienel kernel: EFLAGS: 00013296
May 30 08:00:50 tienel kernel: eax: 00000016   ebx: e08eb000   ecx: e0939080   edx: dffeb0c0
May 30 08:00:50 tienel kernel: esi: fffffffe   edi: e0939080   ebp: e0939280   esp: dd011f04
May 30 08:00:50 tienel kernel: ds: 007b   es: 007b   ss: 0068
May 30 08:00:50 tienel kernel: Process modprobe (pid: 391, threadinfo=dd010000 task=dec36ca0)
May 30 08:00:50 tienel kernel: Stack: e0922000 e0922000 e0907d90 00000013 00000000 e0939080 00000001 000004b0 
May 30 08:00:50 tienel kernel:        0806ce84 00000000 00000000 00030002 e08a0000 e0939080 00000000 00000013 
May 30 08:00:50 tienel kernel:        00000000 00000000 00000000 00000012 00000018 00000016 00000000 0000000c 
May 30 08:00:50 tienel kernel: Call Trace: [sys_init_module+130/592]  [syscall_call+7/11] 
May 30 08:00:50 tienel kernel: Code: ff 8b 7c 24 34 8b 47 6c 89 3c 24 89 44 24 04 e8 bb 12 fe ff 8b 54 24 34 8b 42 70 89 14 24 89 44 24 04 e8 a8 12 fe ff 8b 4c 24 34 <8b> 81 50 01 00 00 85 c0 75 11 8b 7c 24 78 89 3c 24 e8 ce d4 00 

tienel:~# strace modprobe mii
...
open("/lib/modules/2.5.70-mm2/modules.dep", O_RDONLY) = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=22479, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40012000
read(3, "/lib/modules/2.5.70-mm2/kernel/l"..., 4096) = 4096
read(3, "e/oss/snd-mixer-oss.ko: /lib/mod"..., 4096) = 4096
read(3, "modules/2.5.70-mm2/kernel/fs/nls"..., 4096) = 4096
read(3, "v4/netfilter/ip_tables.ko\n/lib/m"..., 4096) = 4096
read(3, "2/kernel/drivers/message/i2o/i2o"..., 4096) = 4096
close(3)                                = 0
munmap(0x40012000, 4096)                = 0
open("/proc/modules", O_RDONLY)         = 3
fstat64(3, {st_mode=S_IFREG|0444, st_size=0, ...}) = 0
old_mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x40012000
read(3,  <unfinished ...>


pvsavola@tienel:/lib/modules/2.5.70-mm2$ find -name '*mga*'
./kernel/drivers/char/drm/mga.ko

pvsavola@tienel:~$ ps aux | grep ' D '
pvsavola   449  0.0  0.0  1192  300 pts/2    D    08:03   0:00 lsmod
root       461  0.0  0.0  1192  328 pts/3    D    08:03   0:00 cat modules
root      1852  0.0  0.0  1208  388 pts/1    D    08:22   0:00 modprobe mii
root      1957  0.0  0.0  1208  388 pts/1    D    08:32   0:00 modprobe mii
pvsavola  2013  0.0  0.0  1288  436 pts/6    R    08:38   0:00 grep  D 



-- 
   Psi -- <http://www.iki.fi/pasi.savolainen>
Vivake -- Virtuaalinen valokuvauskerho <http://members.lycos.co.uk/vivake/>
