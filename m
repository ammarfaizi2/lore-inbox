Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266684AbUFYJzt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266684AbUFYJzt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 05:55:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266670AbUFYJzt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 05:55:49 -0400
Received: from dialin-145-254-075-218.arcor-ip.net ([145.254.75.218]:177 "EHLO
	karin.de.interearth.com") by vger.kernel.org with ESMTP
	id S266687AbUFYJzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 05:55:15 -0400
Mime-Version: 1.0 (Apple Message framework v618)
Content-Transfer-Encoding: 7bit
Message-Id: <FED7554E-C68A-11D8-A3BE-000A958E35DC@fhm.edu>
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha1; boundary="Apple-Mail-9-327263088"
To: Mailinglist <linux-kernel@vger.kernel.org>
From: Daniel Egger <degger@fhm.edu>
Subject: 2.4.26 kernel oops in kswapd
Date: Fri, 25 Jun 2004 11:35:29 +0200
X-Pgp-Agent: GPGMail 1.0.2
X-Mailer: Apple Mail (2.618)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--Apple-Mail-9-327263088
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII; format=flowed

Hija,

I just experienced the following crash while compiling a new
CVS version of gdb on some Athlon XP-2500 machine. The device
is on NFS root and doesn't have a harddrive and thus no swap.
Decoded OOPS is attached further below....

processor       : 0
vendor_id       : AuthenticAMD
cpu family      : 6
model           : 10
model name      : AMD Athlon(TM) XP 2500+
stepping        : 0
cpu MHz         : 1822.568
cache size      : 512 KB
fdiv_bug        : no
hlt_bug         : no
f00f_bug        : no
coma_bug        : no
fpu             : yes
fpu_exception   : yes
cpuid level     : 1
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge 
mca cmov pat pse36 mmx fxsr sse syscall mmxext 3dnowext 3dnow
bogomips        : 3630.69

         total:    used:    free:  shared: buffers:  cached:
Mem:  528371712 334487552 193884160        0        0 181035008
Swap:        0        0        0
MemTotal:       515988 kB
MemFree:        189340 kB
MemShared:           0 kB
Buffers:             0 kB
Cached:         176792 kB
SwapCached:          0 kB
Active:         151276 kB
Inactive:        59332 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       515988 kB
LowFree:        189340 kB
SwapTotal:           0 kB
SwapFree:            0 kB



ksymoops 2.4.9 on i686 2.4.26mine.  Options used
      -V (default)
      -k /proc/ksyms (default)
      -l /proc/modules (default)
      -o /lib/modules/2.4.26mine/ (default)
      -m /usr/src/linux-2.4.26mine/System.map (specified)

kernel BUG at slab.c:1605!
invalid operand: 0000
CPU:    0
EIP:    0010:[<c0131ce5>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010086
eax: 0000001d   ebx: 00414a80   ecx: c15ae000   edx: df187f7c
esi: d7be05d4   edi: 00000286   ebp: c15afef4   esp: c15afee0
ds: 0018   es: 0018   ss: 0018
Process kswapd (pid: 4, stackpage=c15af000)
Stack: c0287072 d7be05d4 c68ce138 d782f308 d9ad4044 c15aff10 c014cf94 
d7be05d4
        d9ad4044 0000000a c14d6214 c02ba778 c15aff1c c014d275 00003f80 
c15aff4c
        c0132d21 00000006 000001d0 c15ae000 ffffffff 0000332e 000001d0 
0000000a
Call Trace:    [<c014cf94>] [<c014d275>] [<c0132d21>] [<c01330ac>] 
[<c0133113>]
   [<c01332a9>] [<c013330c>] [<c013343d>] [<c01333b0>] [<c0105000>] 
[<c010574b>]
   [<c01333b0>]
Code: 0f 0b 45 06 43 70 28 c0 8b 15 f0 08 32 c0 eb c4 89 74 24 04


 >>EIP; c0131ce5 <kfree+75/a0>   <=====

 >>ecx; c15ae000 <_end+126c874/204ce8f4>
 >>edx; df187f7c <_end+1ee467f0/204ce8f4>
 >>esi; d7be05d4 <_end+1789ee48/204ce8f4>
 >>ebp; c15afef4 <_end+126e768/204ce8f4>
 >>esp; c15afee0 <_end+126e754/204ce8f4>

Trace; c014cf94 <prune_dcache+134/150>
Trace; c014d275 <shrink_dcache_memory+25/40>
Trace; c0132d21 <shrink_cache+151/350>
Trace; c01330ac <shrink_caches+3c/50>
Trace; c0133113 <try_to_free_pages_zone+53/b0>
Trace; c01332a9 <kswapd_balance_pgdat+69/b0>
Trace; c013330c <kswapd_balance+1c/40>
Trace; c013343d <kswapd+8d/b0>
Trace; c01333b0 <kswapd+0/b0>
Trace; c0105000 <_stext+0/0>
Trace; c010574b <arch_kernel_thread+2b/40>
Trace; c01333b0 <kswapd+0/b0>

Code;  c0131ce5 <kfree+75/a0>
00000000 <_EIP>:
Code;  c0131ce5 <kfree+75/a0>   <=====
    0:   0f 0b                     ud2a      <=====
Code;  c0131ce7 <kfree+77/a0>
    2:   45                        inc    %ebp
Code;  c0131ce8 <kfree+78/a0>
    3:   06                        push   %es
Code;  c0131ce9 <kfree+79/a0>
    4:   43                        inc    %ebx
Code;  c0131cea <kfree+7a/a0>
    5:   70 28                     jo     2f <_EIP+0x2f>
Code;  c0131cec <kfree+7c/a0>
    7:   c0 8b 15 f0 08 32 c0      rorb   $0xc0,0x3208f015(%ebx)
Code;  c0131cf3 <kfree+83/a0>
    e:   eb c4                     jmp    ffffffd4 <_EIP+0xffffffd4>
Code;  c0131cf5 <kfree+85/a0>
   10:   89 74 24 04               mov    %esi,0x4(%esp,1)

Servus,
       Daniel

--Apple-Mail-9-327263088
content-type: application/pgp-signature; x-mac-type=70674453;
	name=PGP.sig
content-description: This is a digitally signed message part
content-disposition: inline; filename=PGP.sig
content-transfer-encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (Darwin)

iQEVAwUBQNvx4TBkNMiD99JrAQKX0gf/XOqeTfhr9KBGlXxwQ1wr3Rx9VcVwv2aN
A/Jjv6ibSxkbfXsS++4iu4JUaOMrsfGiCIXwnYsn1UGl3XmscqCiu0/jY2quv4Mp
QNOxisxBWDsVOLg8GT6jYilB09cSFOnl5mq/1JCUpIl9jiBbnX5Y7t1YyGXUO7/K
AoZFTt1DwUaRknrjxYNbSedzcJmuu3EkN/AXdoODIoSk67qNUf9piS9+Ujhfy1d2
yk5wZFu7tVHVlOJ29sS3/28EGsGfNZt3P4rigTW3d4FFafTw/pCeqPjy1QwTy1ZF
x3cFf4fHAUcrTShcbPeTQxErI/ddlJETTUhUI03GjmnsCp+qfz/SrQ==
=HZQT
-----END PGP SIGNATURE-----

--Apple-Mail-9-327263088--

