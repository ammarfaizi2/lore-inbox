Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263112AbUJ2G32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263112AbUJ2G32 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 02:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263098AbUJ2G32
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 02:29:28 -0400
Received: from pD9F8759B.dip0.t-ipconnect.de ([217.248.117.155]:4738 "EHLO
	susi.maya.org") by vger.kernel.org with ESMTP id S263112AbUJ2G3O
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 02:29:14 -0400
From: Andreas Hartmann <andihartmann@01019freenet.de>
X-Newsgroups: fa.linux.kernel
Subject: kswapd crashed 2.4.27
Date: Fri, 29 Oct 2004 08:27:29 +0200
Organization: privat
Message-ID: <clsnsh$6p0$1@pD9F8759B.dip0.t-ipconnect.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Complaints-To: abuse@fu.berlin.de
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.7.4) Gecko/20041017
X-Accept-Language: de, en-us, en
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
To: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

I had a hard crash this morning on a XSeries 235 with IBM Serveraid, 512
MB RAM and 1024 MB Swap during rsyncing datas to this machine. The datas
were copied to a drbd-device, which reported some seconds before:

Oct 29 05:30:20 FAGINTSC kernel: drbd16: Epoch set size wrong!!found=1061
reported=1060


~> ksymoops -m /usr/src/linux-2.4.27/System.map oops
ksymoops 2.4.5 on i686 2.4.27.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.27/ (default)
     -m /usr/src/linux-2.4.27/System.map (specified)

Oct 29 05:30:29 FAGINTSC kernel: CPU:    0
Oct 29 05:30:29 FAGINTSC kernel: EIP:    0010:[<c0135400>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
Oct 29 05:30:29 FAGINTSC kernel: EFLAGS: 00010002
Oct 29 05:30:29 FAGINTSC kernel: eax: ffffffff   ebx: dbcbd160   ecx:
00000001   edx: dffed600
Oct 29 05:30:29 FAGINTSC kernel: esi: c158a37c   edi: 00001db7   ebp:
dffed6a4   esp: c15b9f30
Oct 29 05:30:29 FAGINTSC kernel: ds: 0018   es: 0018   ss: 0018
Oct 29 05:30:29 FAGINTSC kernel: Process kswapd (pid: 5, stackpage=c15b9000)
Oct 29 05:30:29 FAGINTSC kernel: Stack: 00000000 c1243108 c158a38c
c158a384 c15b8000 dffed600 00000000 00000008
Oct 29 05:30:29 FAGINTSC kernel:        00000000 00000000 00000000
00000020 000001d0 c028f69c c028f69c c01368ac
Oct 29 05:30:29 FAGINTSC kernel:        c15b9f90 000001d0 0000003c
00000020 c0136952 c15b9f90 00000246 00000000
Oct 29 05:30:29 FAGINTSC kernel: Call Trace:    [<c01368ac>] [<c0136952>]
[<c0136b0c>] [<c0136b78>] [<c0136cbd>]
Oct 29 05:30:29 FAGINTSC kernel:   [<c0105000>] [<c010745e>] [<c0136c20>]
Oct 29 05:30:29 FAGINTSC kernel: Code: 8b 00 47 3b 44 24 08 75 f7 8b 5e 2c
89 fa 8b 46 4c 88 d9 d3


>>EIP; c0135400 <kmem_cache_reap+230/340>   <=====

>>eax; ffffffff <END_OF_CODE+1f701d74/????>
>>ebx; dbcbd160 <_end+1b96ee68/204b3d68>
>>edx; dffed600 <_end+1fc9f308/204b3d68>
>>esi; c158a37c <_end+123c084/204b3d68>
>>edi; 00001db7 Before first symbol
>>ebp; dffed6a4 <_end+1fc9f3ac/204b3d68>
>>esp; c15b9f30 <_end+126bc38/204b3d68>

Trace; c01368ac <shrink_caches+1c/60>
Trace; c0136952 <try_to_free_pages_zone+62/f0>
Trace; c0136b0c <kswapd_balance_pgdat+6c/b0>
Trace; c0136b78 <kswapd_balance+28/40>
Trace; c0136cbd <kswapd+9d/b7>
Trace; c0105000 <_stext+0/0>
Trace; c010745e <arch_kernel_thread+2e/40>
Trace; c0136c20 <kswapd+0/b7>

Code;  c0135400 <kmem_cache_reap+230/340>
00000000 <_EIP>:
Code;  c0135400 <kmem_cache_reap+230/340>   <=====
   0:   8b 00                     mov    (%eax),%eax   <=====
Code;  c0135402 <kmem_cache_reap+232/340>
   2:   47                        inc    %edi
Code;  c0135403 <kmem_cache_reap+233/340>
   3:   3b 44 24 08               cmp    0x8(%esp,1),%eax
Code;  c0135407 <kmem_cache_reap+237/340>
   7:   75 f7                     jne    0 <_EIP>
Code;  c0135409 <kmem_cache_reap+239/340>
   9:   8b 5e 2c                  mov    0x2c(%esi),%ebx
Code;  c013540c <kmem_cache_reap+23c/340>
   c:   89 fa                     mov    %edi,%edx
Code;  c013540e <kmem_cache_reap+23e/340>
   e:   8b 46 4c                  mov    0x4c(%esi),%eax
Code;  c0135411 <kmem_cache_reap+241/340>
  11:   88 d9                     mov    %bl,%cl
Code;  c0135413 <kmem_cache_reap+243/340>
  13:   d3 00                     roll   %cl,(%eax)


Does anybody know what could be broken?


Kind regards,
Andreas Hartmann
