Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318250AbSHIMNn>; Fri, 9 Aug 2002 08:13:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318255AbSHIMNm>; Fri, 9 Aug 2002 08:13:42 -0400
Received: from tistel.levonline.com ([193.15.191.243]:35068 "EHLO
	utter.levonline.com") by vger.kernel.org with ESMTP
	id <S318250AbSHIMNl>; Fri, 9 Aug 2002 08:13:41 -0400
Date: Fri, 9 Aug 2002 14:17:22 +0200 (CEST)
From: Johan Martensson <a0087901@levonline.com>
To: linux-kernel@vger.kernel.org
cc: jom@virrvarr.com
Subject: 2.4.19 Oops :Unable to handle kernel paging request
Message-ID: <Pine.LNX.4.44.0208091334100.3991-100000@utter.levonline.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
One of our machines running linux 2.4.19 with grsecurity 1.9.6 got an Oops 
last night. I'm sorry if it is obvious that this is caused by grsecurity 
and wouldn't happen with vanilla 2.4.19 (I'm too stupid to tell:)).

The machine has been running without any problems since May using various 
kernels. Since early July using 2.4.19-rc1/grsec 1.9.5. A few hours after 
upgrading to 2.4.19/grsec 1.9.6 we got the Oops. I haven't been able to 
reproduce it. When it happend the system was pretty much idle.

Any help on how to find or reproduce the oops is much appreciated.

Below is at least some relevant information.
Please cc replies to me since I'm not subscribed to lkml for the moment.

Thanks,
 Johan


The hardware is a HP rc7100 4-way XEON with 2 gigs of ram.

#lsmod
Module                  Size  Used by    Not tainted
e1000                  65020   1
eepro100               17808   1
st                     27476   0  (unused)
aic7xxx               120480   0  (unused)
lpfcdd                224104   8
megaraid               24800   9

(swap is on megaraid).


sar -r output.
12:00:00 AM kbmemfree kbmemused  %memused kbmemshrd kbbuffers  kbcached 
kbswpfree kbswpused  %swpused
12:04:00 AM      7020   2062752     99.66         0    124600   1765060   
1946212    102036      4.98
12:05:00 AM      6964   2062808     99.66         0    124948   1764728   
1946128    102120      4.99
12:06:00 AM     18648   2051124     99.10         0    125500   1758728   
1944448    103800      5.07
12:07:00 AM     18360   2051412     99.11         0    125856   1758736   
1944448    103800      5.07


klogd/ksymops:
Aug  9 00:05:50 dpluplu3 kernel: Unable to handle kernel paging request at 
virtual address 00200044
Aug  9 00:05:50 dpluplu3 kernel: c024cfe0
Aug  9 00:05:50 dpluplu3 kernel: *pde = 00000000
Aug  9 00:05:50 dpluplu3 kernel: Oops: 0000
Aug  9 00:05:50 dpluplu3 kernel: CPU:    1
Aug  9 00:05:50 dpluplu3 kernel: EIP:    0010:[gr_check_create+448/832]    
Not tainted
Aug  9 00:05:50 dpluplu3 kernel: EIP:    0010:[<c024cfe0>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Aug  9 00:05:50 dpluplu3 kernel: EFLAGS: 00010206
Aug  9 00:05:50 dpluplu3 kernel: eax: 0000002f   ebx: c4c4aff0   ecx: 
f89f46d0   edx: 00200044
Aug  9 00:05:50 dpluplu3 kernel: esi: c4c4aff1   edi: 00200044   ebp: 
0000033c   esp: f2445ed0
Aug  9 00:05:50 dpluplu3 kernel: ds: 0018   es: 0018   ss: 0018
Aug  9 00:05:50 dpluplu3 kernel: Process dbsnmp (pid: 1084, 
stackpage=f2445000)
Aug  9 00:05:54 dpluplu3 kernel: Stack: c014a0be f7f49790 f26ac005 
0e01899f c4c4a000 00001000 00000005 f2445f8c
Aug  9 00:05:54 dpluplu3 kernel:        f770e380 c01491e0 c283ba00 
f2445f8c 00000000 c014a59a c283ba00 c283ba00
Aug  9 00:05:54 dpluplu3 kernel:        da00ca00 c283ba00 00000243 
c014abe8 da00ca00 c283ba00 f7bb2e80 00000005
Aug  9 00:05:54 dpluplu3 kernel: Call Trace:    [link_path_walk+3198/3536] 
[cached_lookup+16/80] [lookup_hash+74/208] [open_namei+1048/2912] 
[filp_open+54/96]
Aug  9 00:05:54 dpluplu3 kernel: Call Trace:    [<c014a0be>] [<c01491e0>] 
[<c014a59a>] [<c014abe8>] [<c013dc26>]
Aug  9 00:05:54 dpluplu3 kernel:   [<c013df74>] [<c0108c3b>]
Aug  9 00:05:54 dpluplu3 kernel: Code: ae 75 08 84 c0 75 f8 31 c0 eb 04 19 
c0 0c 01 85 c0 74 02 31

>>EIP; c024cfe0 <gr_check_create+1c0/340>   <=====
Trace; c014a0be <link_path_walk+c7e/dd0>
Trace; c01491e0 <cached_lookup+10/50>
Trace; c014a59a <lookup_hash+4a/d0>
Trace; c014abe8 <open_namei+418/b60>
Trace; c013dc26 <filp_open+36/60>
Trace; c013df74 <sys_open+34/a0>
Trace; c0108c3b <system_call+33/38>
Code;  c024cfe0 <gr_check_create+1c0/340>
00000000 <_EIP>:
Code;  c024cfe0 <gr_check_create+1c0/340>   <=====
   0:   ae                        scas   %es:(%edi),%al   <=====
Code;  c024cfe1 <gr_check_create+1c1/340>
   1:   75 08                     jne    b <_EIP+0xb> c024cfeb 
<gr_check_create+1cb/340>
Code;  c024cfe3 <gr_check_create+1c3/340>
   3:   84 c0                     test   %al,%al
Code;  c024cfe5 <gr_check_create+1c5/340>
   5:   75 f8                     jne    ffffffff <_EIP+0xffffffff> 
c024cfdf <gr_check_create+1bf/340>
Code;  c024cfe7 <gr_check_create+1c7/340>
   7:   31 c0                     xor    %eax,%eax
Code;  c024cfe9 <gr_check_create+1c9/340>
   9:   eb 04                     jmp    f <_EIP+0xf> c024cfef 
<gr_check_create+1cf/340>
Code;  c024cfeb <gr_check_create+1cb/340>
   b:   19 c0                     sbb    %eax,%eax
Code;  c024cfed <gr_check_create+1cd/340>
   d:   0c 01                     or     $0x1,%al
Code;  c024cfef <gr_check_create+1cf/340>
   f:   85 c0                     test   %eax,%eax
Code;  c024cff1 <gr_check_create+1d1/340>
  11:   74 02                     je     15 <_EIP+0x15> c024cff5 
<gr_check_create+1d5/340>
Code;  c024cff3 <gr_check_create+1d3/340>
  13:   31 00                     xor    %eax,(%eax)


The c code from linux/grsecurity/gracl.c

int
gr_check_create(struct dentry *new_dentry, struct dentry *parent,
                struct vfsmount *mnt, __u16 mode)
{
        struct name_entry *match;
        struct acl_object_label *matchpo;
        int retval = GR_NOTFOUND;
        char *buffer;
        char *pathname;

        if (!(gr_status & GR_READY))
                return mode;

        buffer = (char *) get_free_page(GFP_KERNEL);
        if (!buffer)
                return 0;       /* OOM : can't let anything get through */

        pathname = d_path(new_dentry, mnt, buffer, PAGE_SIZE);
.......

