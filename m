Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261437AbVCaN0H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261437AbVCaN0H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 08:26:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261438AbVCaN0H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 08:26:07 -0500
Received: from twister.ispgateway.de ([80.67.18.17]:1243 "EHLO
	twister.ispgateway.de") by vger.kernel.org with ESMTP
	id S261437AbVCaNY6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 08:24:58 -0500
Date: Thu, 31 Mar 2005 15:24:49 +0200
From: Steffen Moser <lists@steffen-moser.de>
To: linux-kernel@vger.kernel.org
Subject: Oops with "linux-2.4.29"
Message-ID: <20050331132449.GO10495@steffen-moser.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

one of our file servers (SuSE Linux 7.2, running "linux-2.4.29")  
oopsed some days ago - here is the bug report:

[1.] One line summary of the problem:

Kernel "linux-2.4.29" oopses irregularly. The oopses seem to be 
triggered by high I/O load on the SCSI subsystem.


[2.] Full description of the problem/report:

The machine which is mainly used as a "samba" and "NIS/NFS" server of
a comprehensive secondry school's network runs unstable - especially 
under heavy I/O load, for example, when a virus scanner ("antivir" {1}) 
is doing a scan over the whole user data files.

The oopses are not only triggered by "antivir", but also during high
I/O load caused by a "samba" process, for example. 

The machine is running quite an old installation of SuSE Linux 7.2. The
kernel which is used is "linux-2.4.29". The security relevant things 
("samba", "ssh", "kernel", and so on) have been patched manually. I 
haven't had the time to set up this machine based on a newer distri-
bution, yet. :-/

We are running software RAID1 on two SCSI hard disks, two further SCSI
disks are running without RAID. Only "ext3fs" is used on this machine. 

One thing I have to add: The machine was running a bit unstable some 
months ago (Nov 2003). I didn't have the time to write a bug report 
at that time. :-(

But you can find some debug output from that time at {2}.

The errors I got in November 2003 (running linux-2.4.22) seem to be 
clearly related to disk issues. I assume that the oops I am reporting 
within this message is also related to disk, file system or SCSI sub-
system issues.

Between November 2003 and now the machine has ran bit more stable (per-
haps about one crash every two months), but at the moment I have to re-
boot it at least once a week. 

That's the reason I am writing this report now.

I suppose that the unstable behaviour is caused by hardware problems
(disk problems or SCSI problems?), but I don't know it for sure. 

"memtest" hasn't found anything, but I've had it running only for about 
five hours up to now. The SCSI cabling has been also checked and seems 
to be alright. Letting run a CPU time consuming application in the back-
ground (for example, a distributed.net client) doesn't seem to trigger 
the problem.


[3.] Keywords (i.e., modules, networking, kernel):

linux kernel 2.4.29 oops ext3 I/O high load SCSI


[4.] Kernel version (from /proc/version):

 | Linux version 2.4.29 (root@fsa01) (gcc version 2.95.3 20010315 (SuSE)) #2 Thu Jan 20 12:25:04 CET 2005


[5.] Output of Oops.. message (if applicable) with symbolic information
resolved (see Documentation/oops-tracing.txt)

 | v00001@fsa01:~ > ./ksymoops-2.4.11/ksymoops -m /boot/System.map
 | ksymoops 2.4.11 on i686 2.4.29.  Options used
 |      -V (default)
 |      -k /proc/ksyms (default)
 |      -l /proc/modules (default)
 |      -o /lib/modules/2.4.29/ (default)
 |      -m /boot/System.map (specified)
 | 
 | Reading Oops report from the terminal
 
[...]
 
 | Code: 00 00 00 00 17 3a 23 00 01 00 00 00 04 09 00 00 00 00 00 00
 | Unable to handle kernel NULL pointer dereference at virtual address
 | 00000000
 | ccabe7a0
 | *pde = 00000000
 | Oops: 0002
 | CPU:    0
 | EIP:    0010:[<ccabe7a0>]    Not tainted
 | Using defaults from ksymoops -t elf32-i386 -a i386
 | EFLAGS: 00010282
 | eax: 00000000   ebx: c13b8214   ecx: 00000017   edx: c0273c5c
 | esi: dfe91504   edi: 00000000   ebp: da00a804   esp: d4e5bf20
 | ds: 0018   es: 0018   ss: 0018
 | Process antivir (pid: 28362, stackpage=d4e5b000)
 | Stack: c13b8214 c015991c c0124041 d3baf260 c13b8214 00000000 d3baf260 08179504
 |        d3baf280 00001000 00000001 00000000 00000000 da00a740 c0124583 d3baf260
 |        d3baf280 d4e5bf8c c012446c 00000000 d3baf260 ffffffea 00000400 00000000
 | Call Trace:    [<c015991c>] [<c0124041>] [<c0124583>] [<c012446c>] [<c0130d56>]
 |   [<c0106b33>]
 | Code: 00 00 00 00 17 3a 23 00 01 00 00 00 04 09 00 00 00 00 00 00
 | 
 | 
 | >>EIP; ccabe7a0 <_end+c7cd2ac/20552b0c>   <=====
 | 
 | >>ebx; c13b8214 <_end+10c6d20/20552b0c>
 | >>edx; c0273c5c <contig_page_data+dc/3c0>
 | >>esi; dfe91504 <_end+1fba0010/20552b0c>
 | >>ebp; da00a804 <_end+19d19310/20552b0c>
 | >>esp; d4e5bf20 <_end+14b6aa2c/20552b0c>
 | 
 | Trace; c015991c <ext3_get_block+0/64>
 | Trace; c0124041 <do_generic_file_read+291/438>
 | Trace; c0124583 <generic_file_read+8b/190>
 | Trace; c012446c <file_read_actor+0/8c>
 | Trace; c0130d56 <sys_read+96/f0>
 | Trace; c0106b33 <system_call+33/38>
 |
 | Code;  ccabe7a0 <_end+c7cd2ac/20552b0c>
 | 00000000 <_EIP>:
 | Code;  ccabe7a0 <_end+c7cd2ac/20552b0c>   <=====
 |    0:   00 00                     add    %al,(%eax)   <=====
 | Code;  ccabe7a2 <_end+c7cd2ae/20552b0c>
 |    2:   00 00                     add    %al,(%eax)
 | Code;  ccabe7a4 <_end+c7cd2b0/20552b0c>
 |    4:   17                        pop    %ss
 | Code;  ccabe7a5 <_end+c7cd2b1/20552b0c>
 |    5:   3a 23                     cmp    (%ebx),%ah
 | Code;  ccabe7a7 <_end+c7cd2b3/20552b0c>
 |    7:   00 01                     add    %al,(%ecx)
 | Code;  ccabe7a9 <_end+c7cd2b5/20552b0c>
 |    9:   00 00                     add    %al,(%eax)
 | Code;  ccabe7ab <_end+c7cd2b7/20552b0c>
 |    b:   00 04 09                  add    %al,(%ecx,%ecx,1)


[6.] A small shell script or example program which triggers the
problem (if possible):

Running "antivir /usr/lib/AntiVir/antivir -s -e -del /home /export"
every two hours (started by "cron") will produce a oops like this
within a few days.


[7.] Environment
 
[7.1.] Software (add the output of the ver_linux script here):

 | v00001@fsa01:~ > . /usr/src/linux-2.4.29/scripts/ver_linux
 | If some fields are empty or look unusual you may have an old version.
 | Compare to the current minimal requirements in Documentation/Changes.
 | 
 | Linux fsa01 2.4.29 #2 Thu Jan 20 12:25:04 CET 2005 i686 unknown
 | 
 | Gnu C                  2.95.3
 | Gnu make               3.79.1
 | binutils               2.10.91.0.4
 | util-linux             2.11l
 | mount                  2.11l
 | modutils               2.4.5
 | e2fsprogs              1.25
 | pcmcia-cs              3.1.25
 | quota-tools            3.08.
 | Linux C Library        x    1 root     root      1341670 Dec 18  2001 /lib/libc.so.6
 | Dynamic linker (ldd)   2.2.2
 | Procps                 2.0.7
 | Net-tools              1.60
 | Kbd                    1.04
 | Sh-utils               2.0
 | Modules Loaded         ipv6 3c59x ipchains serial


[7.2.] Processor information (from /proc/cpuinfo):

 | processor      : 0
 | vendor_id      : GenuineIntel
 | cpu family     : 6
 | model          : 8
 | model name     : Pentium III (Coppermine)
 | stepping       : 10
 | cpu MHz                : 871.044
 | cache size     : 256 KB
 | fdiv_bug       : no
 | hlt_bug                : no
 | f00f_bug       : no
 | coma_bug       : no
 | fpu            : yes
 | fpu_exception  : yes
 | cpuid level    : 2
 | wp             : yes
 | flags          : fpu vme de pse tsc msr pae mce cx8 sep mtrr pge mca cmov pat pse36 mmx fxsr sse
 | bogomips       : 1736.70
 

[7.3.] Module information (from /proc/modules):

 | ipv6                  144736  -1 (autoclean)
 | 3c59x                  25088   1 (autoclean)
 | ipchains               38048   0
 | serial                 43456   1 (autoclean)


[7.4.] SCSI information (from /proc/scsi/scsi):

 | Attached devices:
 | Host: scsi0 Channel: 00 Id: 00 Lun: 00
 |   Vendor: IBM      Model: DPSS-336950M     Rev: S96H
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 | Host: scsi0 Channel: 00 Id: 01 Lun: 00
 |   Vendor: IBM      Model: DPSS-336950M     Rev: S96H
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 | Host: scsi0 Channel: 00 Id: 03 Lun: 00
 |   Vendor: HP       Model: C1537A           Rev: L005
 |   Type:   Sequential-Access                ANSI SCSI revision: 02
 | Host: scsi0 Channel: 00 Id: 04 Lun: 00
 |   Vendor: IBM      Model: DNES-318350      Rev: SA30
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 | Host: scsi0 Channel: 00 Id: 05 Lun: 00
 |   Vendor: IBM      Model: DNES-318350      Rev: SA30
 |   Type:   Direct-Access                    ANSI SCSI revision: 03
 

[7.5.] Other information that might be relevant to the problem
(please look in /proc and include all information that you
think to be relevant):

 | System memory (at time of oops):
 |
 |         total:    used:    free:  shared: buffers:  cached:
 | Mem:  528605184 510717952 17887232        0 89063424 31199232
 | Swap: 526336000        0 526336000
 | MemTotal:       516216 kB
 | MemFree:         17468 kB
 | MemShared:           0 kB
 | Buffers:         86976 kB
 | Cached:          30468 kB
 | SwapCached:          0 kB
 | Active:          98716 kB
 | Inactive:        18864 kB
 | HighTotal:           0 kB
 | HighFree:            0 kB
 | LowTotal:       516216 kB
 | LowFree:         17468 kB
 | SwapTotal:      514000 kB
 | SwapFree:       514000 kB
 
 | System uptime:
 |
 |  10:40am  up 9 days, 17 min,  2 users,  load average: 6.01, 6.00, 6.00

 | Partitioning:
 |
 | fsa01:~ # fdisk -l
 |
 | Disk /dev/sda: 255 heads, 63 sectors, 4492 cylinders
 | Units = cylinders of 16065 * 512 bytes
 | 
 |    Device Boot    Start       End    Blocks   Id  System
 | /dev/sda1   *         1         2     16033+  fd  Linux raid autodetect
 | /dev/sda2             3      4492  36065925    5  Extended
 | /dev/sda5             3        47    361431   fd  Linux raid autodetect
 | /dev/sda6            48        92    361431   fd  Linux raid autodetect
 | /dev/sda7            93       284   1542208+  fd  Linux raid autodetect
 | /dev/sda8           285      1814  12289693+  fd  Linux raid autodetect
 | /dev/sda9          1815      4459  21245931   fd  Linux raid autodetect
 | /dev/sda10         4460      4491    257008+  82  Linux swap
 | 
 | Disk /dev/sdb: 255 heads, 63 sectors, 4492 cylinders
 | Units = cylinders of 16065 * 512 bytes
 | 
 |    Device Boot    Start       End    Blocks   Id  System
 | /dev/sdb1             1         2     16033+  fd  Linux raid autodetect
 | /dev/sdb2             3      4492  36065925    5  Extended
 | /dev/sdb5             3        47    361431   fd  Linux raid autodetect
 | /dev/sdb6            48        92    361431   fd  Linux raid autodetect
 | /dev/sdb7            93       284   1542208+  fd  Linux raid autodetect
 | /dev/sdb8           285      1814  12289693+  fd  Linux raid autodetect
 | /dev/sdb9          1815      4459  21245931   fd  Linux raid autodetect
 | /dev/sdb10         4460      4491    257008+  82  Linux swap
 | 
 | Disk /dev/sdc: 255 heads, 63 sectors, 2231 cylinders
 | Units = cylinders of 16065 * 512 bytes
 | 
 |    Device Boot    Start       End    Blocks   Id  System
 | /dev/sdc1             1      2231  17920476   83  Linux
 | 
 | Disk /dev/sdd: 255 heads, 63 sectors, 2231 cylinders
 | Units = cylinders of 16065 * 512 bytes
 | 
 |    Device Boot    Start       End    Blocks   Id  System
 | /dev/sdd1             1      2231  17920476   83  Linux
 
 | Mounts:
 |
 | fsa01:~ # mount
 | /dev/md1 on / type ext3 (rw)
 | proc on /proc type proc (rw)
 | devpts on /dev/pts type devpts (rw,mode=0620,gid=5)
 | /dev/md2 on /var type ext3 (rw)
 | /dev/md3 on /usr type ext3 (rw)
 | /dev/md0 on /boot type ext3 (rw)
 | /dev/md4 on /home type ext3 (rw,usrquota)
 | /dev/md5 on /export type ext3 (rw)
 | /dev/sdc1 on /export/tausch type ext3 (rw)
 | /dev/sdd1 on /export/admin type ext3 (rw)
 | shmfs on /dev/shm type shm (rw)

 | Disk free status:
 |
 | fsa01:~ # df -h
 | Filesystem            Size  Used Avail Use% Mounted on
 | /dev/md1              342M   53M  271M  17% /
 | /dev/md2              342M   38M  286M  12% /var
 | /dev/md3              1.4G  903M  504M  65% /usr
 | /dev/md0               15M  5.0M  9.3M  35% /boot
 | /dev/md4               11G  9.9G  1.0G  91% /home
 | /dev/md5               20G  5.7G   13G  31% /export
 | /dev/sdc1              17G   59M   15G   1% /export/tausch
 | /dev/sdd1              17G   14G  2.0G  88% /export/admin
 | shmfs                 252M     0  252M   0% /dev/shm


 - The relatively high load average (6.01) is caused by six hanging 
and unkillable (and un-strace-able) "antivir" processes (one began 
to hang when the oops happened and "cron" started five further 
"antivir" processes (which got also stuck) until I noticed the oops 
and commented out the line in "/etc/crontab".

Output of "ps aux", output of "smartctl -a /dev/sd[a-d]", "lspci", 
kernel config, and so on, you will find at {3} - to make this mail
not too long. 

If you need further information or debug material, pleast let me 
know.

Any help will be greatly appreciated! Thank you in advance!

Bye,
Steffen

{1} http://www.antivir.de/en/index.html
{2} http://www.uni-ulm.de/~s_smoser/ml/lkml/2003-11-09_01/
{3} http://www.uni-ulm.de/~s_smoser/ml/lkml/2005-03-31_01/
