Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135685AbRDZREt>; Thu, 26 Apr 2001 13:04:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135688AbRDZREj>; Thu, 26 Apr 2001 13:04:39 -0400
Received: from [195.56.210.24] ([195.56.210.24]:17544 "EHLO lima")
	by vger.kernel.org with ESMTP id <S135685AbRDZRE2>;
	Thu, 26 Apr 2001 13:04:28 -0400
Message-ID: <3AE85451.D197FCB9@sch.bme.hu>
Date: Thu, 26 Apr 2001 19:01:05 +0200
From: Marcell GAL <cell@sch.bme.hu>
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.3 oopses at lots of ppp sessions
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Guys,

2.4.3 (UP kernel UP machine, http://home.sch.bme.hu/~cell/.config) 
oopses when I start lots of pppd eth0 simultaneously.
(I guess the problem is not pppoe specific, but I do not know exactly)

The last pppd sighs: PPP: couldn't register device (-17)
This is 2 oops not just 1...

:51 lima pppd[2093]: pppd 2.4.0 started by root, uid 0
:51 lima pppd[2093]: Sending PADI
:51 lima pppd[2093]: HOST_UNIQ successful match 
:51 lima pppd[2093]: Tag error: TAG_SYS_ERR
:51 lima pppd[2093]: Failed to negotiate PPPoE connection: 25
Inappropriate ioctl for device
:51 lima pppd[2093]: Exit.
:51 lima kernel: EIP:    0010:[ppp_create_interface+400/452]
:51 lima kernel: EFLAGS: 00010286
:51 lima kernel: eax: c3ab77d8   ebx: c17d4e00   ecx: 00000000   edx:
c3ab77d8
:51 lima kernel: esi: 00000033   edi: c3ab77a0   ebp: 00000000   esp:
c3b23f28
:51 lima kernel: ds: 0018   es: 0018   ss: 0018
:51 lima kernel: Process pppd (pid: 2031, stackpage=c3b23000)
:51 lima kernel: Stack: fffffff2 08076f48 c2cc3d80 ffffffe7 c3ab77a0
00000000 c029de64 c019e775 
:51 lima kernel:        ffffffff c3b23f5c 08076f48 08076f48 c004743e
fffffff2 c019e13c 00000000 
:51 lima kernel:        c2cc3d80 c004743e 08076f48 c2cc3d80 08076f48
c004743e ffffffe7 fffffff2 
:51 lima kernel: Call Trace: [ppp_unattached_ioctl+97/320]
[ppp_ioctl+48/1544] [sys_ioctl+363/388] [system_call+51/56] 
:51 lima kernel: 
:51 lima kernel: Code: 89 41 04 8b 5c 24 10 89 4b 38 89 50 04 89 02 8b
44 24 24 8b 
:51 lima kernel: PPP: couldn't register device (-17)
:51 lima kernel: Unable to handle kernel NULL pointer dereference at
virtual address 00000008
:51 lima kernel:  printing eip:
:51 lima kernel: c01a014f
:51 lima kernel: *pde = 00000000
:51 lima kernel: Oops: 0000
:51 lima kernel: CPU:    0
:51 lima kernel: EIP:    0010:[ppp_create_interface+79/452]
:51 lima kernel: EFLAGS: 00010286
:51 lima kernel: eax: 00000033   ebx: ffffffc8   ecx: 00000032   edx:
00000032
:51 lima kernel: esi: ffffffff   edi: c321ec00   ebp: ffffffe7   esp:
c17bff28
:51 lima kernel: ds: 0018   es: 0018   ss: 0018
:51 lima kernel: Process pppd (pid: 2035, stackpage=c17bf000)
:51 lima kernel: Stack: fffffff2 08076f48 c321ec00 ffffffe7 ffffffc8
ffffffef 00000000 c019e775 
:51 lima kernel:        ffffffff c17bff5c 08076f48 08076f48 c004743e
fffffff2 c019e13c 00000000 
:51 lima kernel:        c321ec00 c004743e 08076f48 c321ec00 08076f48
c004743e ffffffe7 fffffff2 
:51 lima kernel: Call Trace: [ppp_unattached_ioctl+97/320]
[ppp_ioctl+48/1544] [sys_ioctl+363/388] [system_call+51/56] 
:51 lima kernel: 
:51 lima kernel: Code: 8b 53 40 39 c2 7f 0f eb ca 8b 7c 24 10 8b 47 40
89 c2 39 d6 


----
0xc01a0100 <ppp_create_interface>:      sub    $0xc,%esp
0xc01a0103 <ppp_create_interface+3>:    push   %ebp
0xc01a0104 <ppp_create_interface+4>:    push   %edi
0xc01a0105 <ppp_create_interface+5>:    push   %esi
0xc01a0106 <ppp_create_interface+6>:    push   %ebx
0xc01a0107 <ppp_create_interface+7>:    mov    0x20(%esp,1),%esi
0xc01a010b <ppp_create_interface+11>:   mov    $0xffffffff,%ecx
0xc01a0110 <ppp_create_interface+16>:   movl   $0xffffffef,0x14(%esp,1)
0xc01a0118 <ppp_create_interface+24>:   movl   $0xc029de64,0x18(%esp,1)
0xc01a0120 <ppp_create_interface+32>:   jmp    0xc01a012c
<ppp_create_interface+44>
0xc01a0122 <ppp_create_interface+34>:   cmp    %edx,%esi
0xc01a0124 <ppp_create_interface+36>:   je     0xc01a029f
<ppp_create_interface+415>
0xc01a012a <ppp_create_interface+42>:   mov    %edx,%ecx
0xc01a012c <ppp_create_interface+44>:   mov    0x18(%esp,1),%eax
0xc01a0130 <ppp_create_interface+48>:   mov    (%eax),%eax
0xc01a0132 <ppp_create_interface+50>:   mov    %eax,0x18(%esp,1)
0xc01a0136 <ppp_create_interface+54>:   cmp    $0xc029de64,%eax
0xc01a013b <ppp_create_interface+59>:   je     0xc01a0165
<ppp_create_interface+101>
0xc01a013d <ppp_create_interface+61>:   add    $0xffffffc8,%eax
0xc01a0140 <ppp_create_interface+64>:   mov    %eax,0x10(%esp,1)
0xc01a0144 <ppp_create_interface+68>:   test   %esi,%esi
0xc01a0146 <ppp_create_interface+70>:   jge    0xc01a0158
<ppp_create_interface+88>
0xc01a0148 <ppp_create_interface+72>:   mov    0x10(%esp,1),%ebx
0xc01a014c <ppp_create_interface+76>:   lea    0x1(%ecx),%eax
0xc01a014f <ppp_create_interface+79>:   mov    0x40(%ebx),%edx
^^^^^^ NULL pointer dereference HERE
0xc01a0152 <ppp_create_interface+82>:   cmp    %eax,%edx
0xc01a0154 <ppp_create_interface+84>:   jg     0xc01a0165
<ppp_create_interface+101>
0xc01a0156 <ppp_create_interface+86>:   jmp    0xc01a0122
<ppp_create_interface+34>
....
0xc01a0265 <ppp_create_interface+357>:  call   0xc0111d7c <printk>
0xc01a026a <ppp_create_interface+362>:  push   %ebx
0xc01a026b <ppp_create_interface+363>:  call   0xc0124330 <kfree>
0xc01a0270 <ppp_create_interface+368>:  push   %edi
0xc01a0271 <ppp_create_interface+369>:  call   0xc0124330 <kfree>
0xc01a0276 <ppp_create_interface+374>:  add    $0x10,%esp
0xc01a0279 <ppp_create_interface+377>:  jmp    0xc01a029f
<ppp_create_interface+415>
0xc01a027b <ppp_create_interface+379>:  nop    
0xc01a027c <ppp_create_interface+380>:  lea    0x0(%esi,1),%esi
0xc01a0280 <ppp_create_interface+384>:  mov    0x18(%esp,1),%ecx
0xc01a0284 <ppp_create_interface+388>:  mov    0x4(%ecx),%edx
0xc01a0287 <ppp_create_interface+391>:  mov    0x10(%esp,1),%eax
0xc01a028b <ppp_create_interface+395>:  add    $0x38,%eax
0xc01a028e <ppp_create_interface+398>:  mov    (%edx),%ecx
0xc01a0290 <ppp_create_interface+400>:  mov    %eax,0x4(%ecx)
^^^^^^ NULL pointer dereference HERE
0xc01a0293 <ppp_create_interface+403>:  mov    0x10(%esp,1),%ebx
0xc01a0297 <ppp_create_interface+407>:  mov    %ecx,0x38(%ebx)

-------------------
ppp_create_interface(int unit, int *retp)
{
        struct ppp *ppp;
        struct net_device *dev;
        struct list_head *list;
        int last_unit = -1;
        int ret = -EEXIST;
        int i;

        spin_lock(&all_ppp_lock);
        list = &all_ppp_units;
        while ((list = list->next) != &all_ppp_units) {
                ppp = list_entry(list, struct ppp, file.list);
                if ((unit < 0 && ppp->file.index > last_unit + 1)
                                 ^^^^^^^^ _MAYBE_ this is
ppp_create_interface+79 ?? 
                    || (unit >= 0 && unit < ppp->file.index))
                        break;
                if (unit == ppp->file.index)
...

        if (ret != 0) {
                printk(KERN_ERR "PPP: couldn't register device (%d)\n",
ret);
                kfree(dev);
                kfree(ppp);
                goto out;
        }

        list_add(&ppp->file.list, list->prev);
                   ^^^^^^^^^ _MAYBE_ ppp_create_interface+400 ??
...
}
------
The caller of ppp_create_interface:

0xc019e75d <ppp_unattached_ioctl+73>:   call   0xc022ddd4 <__get_user_4>
0xc019e762 <ppp_unattached_ioctl+78>:   test   %eax,%eax
0xc019e764 <ppp_unattached_ioctl+80>:   jne    0xc019e848
<ppp_unattached_ioctl+308>
0xc019e76a <ppp_unattached_ioctl+86>:   lea    0xc(%esp,1),%eax
0xc019e76e <ppp_unattached_ioctl+90>:   push   %eax
0xc019e76f <ppp_unattached_ioctl+91>:   push   %edx
0xc019e770 <ppp_unattached_ioctl+92>:   call   0xc01a0100
<ppp_create_interface>

----
I do not have more time to debug this...at least today.
What could be the problem, what should I check next?

thanx:
	Cell

-- 
It's lucky you're going so slowly, because you're going in the wrong
direction.
