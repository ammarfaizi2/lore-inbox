Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129689AbQKGVpE>; Tue, 7 Nov 2000 16:45:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129722AbQKGVoy>; Tue, 7 Nov 2000 16:44:54 -0500
Received: from altrade.nijmegen.inter.nl.net ([193.67.237.6]:56215 "EHLO
	altrade.nijmegen.inter.nl.net") by vger.kernel.org with ESMTP
	id <S129689AbQKGVok>; Tue, 7 Nov 2000 16:44:40 -0500
Date: Tue, 7 Nov 2000 21:00:50 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.0-test10 Oops
Message-ID: <20001107210050.A883@iapetus.localdomain>
In-Reply-To: <20001106230344.C992@iapetus.localdomain> <9731.973567145@ocs3.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0i
In-Reply-To: <9731.973567145@ocs3.ocs-net>; from kaos@ocs.com.au on Tue, Nov 07, 2000 at 02:19:05PM +1100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2000 at 02:19:05PM +1100, Keith Owens wrote:
> On Mon, 6 Nov 2000 23:03:44 +0100, 
> Frank van Maarseveen <F.vanMaarseveen@inter.NL.net> wrote:
> >First a firewall is installed (ppp0). Starting the network (eth0/lo only. ppp0 is
> >nonexistent at this point) gives the following Oops:
> 
> klogd has tried to convert the addresses and got it completely wrong,
> leaving nothing useful for ksymoops.  Change /etc/rc.d/init.d/syslog to
> run klogd as "klogd -x", restart klogd, reproduce the problem and run
> the result through ksymoops.
Bingo.

ksymoops 2.3.3 on i686 2.4.0-test10-x23.  Options used
     -V (default)
     -k /proc/ksyms (default)
     -l /proc/modules (default)
     -o /lib/modules/2.4.0-test10-x23/ (default)
     -m /boot/System.map-2.4.0-test10-x23 (specified)

Nov  7 20:50:06 iapetus kernel: ac97_codec: AC97 Audio codec, id: 0x5452:0x4102 (Unknown) 
Nov  7 20:50:17 iapetus kernel: Unable to handle kernel NULL pointer dereference at virtual address 00000070 
Nov  7 20:50:17 iapetus kernel: c68385ab 
Nov  7 20:50:17 iapetus kernel: *pde = 00000000 
Nov  7 20:50:17 iapetus kernel: Oops: 0002 
Nov  7 20:50:17 iapetus kernel: CPU:    1 
Nov  7 20:50:17 iapetus kernel: EIP:    0010:[<c68385ab>] 
Using defaults from ksymoops -t elf32-i386 -a i386
Nov  7 20:50:17 iapetus kernel: EFLAGS: 00010202 
Nov  7 20:50:17 iapetus kernel: eax: 00000000   ebx: 00000070   ecx: 00006d50   edx: 21045000 
Nov  7 20:50:17 iapetus kernel: esi: 00000000   edi: 00000000   ebp: 00000300   esp: c35adee4 
Nov  7 20:50:17 iapetus kernel: ds: 0018   es: 0018   ss: 0018 
Nov  7 20:50:17 iapetus kernel: Process modprobe (pid: 322, stackpage=c35ad000) 
Nov  7 20:50:17 iapetus kernel: Stack: 00000000 00000000 00000000 ffffffea c027ae58 00000000 ffffffea c027ac80  
Nov  7 20:50:17 iapetus kernel:        0000257c 00000100 00000003 0000000a 51ff0000 00000000 ffffffea c1044010  
Nov  7 20:50:17 iapetus kernel:        c027ac8c 21045000 ffff0499 c683935b 00000000 c6838000 00000000 c0119f1f  
Nov  7 20:50:17 iapetus kernel: Call Trace: [<ffff0499>] [<c683935b>] [<c6838000>] [<c0119f1f>] [<c6838048>] [<c684f000>] [<c6838048>]  
Nov  7 20:50:17 iapetus kernel:        [<c010a7db>]  
Nov  7 20:50:17 iapetus kernel: Code: 89 50 70 8b 54 24 48 66 89 53 04 89 68 20 8b 54 24 2c 89 50  

>>EIP; c68385ab <[3c509].text.start+54b/6e8>   <=====
Trace; ffff0499 <END_OF_CODE+397a0da2/????>
Trace; c683935b <[3c509]init_module+57/74>
Trace; c6838000 <[iptable_filter].data.end+19dd/1a3d>
Trace; c0119f1f <sys_init_module+477/52c>
Trace; c6838048 <[iptable_filter].data.end+1a25/1a3d>
Trace; c684f000 <[ipt_REJECT]__module_kernel_version+0/60>
Trace; c6838048 <[iptable_filter].data.end+1a25/1a3d>
Trace; c010a7db <system_call+33/38>
Code;  c68385ab <[3c509].text.start+54b/6e8>
00000000 <_EIP>:
Code;  c68385ab <[3c509].text.start+54b/6e8>   <=====
   0:   89 50 70                  movl   %edx,0x70(%eax)   <=====
Code;  c68385ae <[3c509].text.start+54e/6e8>
   3:   8b 54 24 48               movl   0x48(%esp,1),%edx
Code;  c68385b2 <[3c509].text.start+552/6e8>
   7:   66 89 53 04               movw   %dx,0x4(%ebx)
Code;  c68385b6 <[3c509].text.start+556/6e8>
   b:   89 68 20                  movl   %ebp,0x20(%eax)
Code;  c68385b9 <[3c509].text.start+559/6e8>
   e:   8b 54 24 2c               movl   0x2c(%esp,1),%edx
Code;  c68385bd <[3c509].text.start+55d/6e8>
  12:   89 50 00                  movl   %edx,0x0(%eax)

lsmod just after the oops is a further confirmation:
Module                  Size  Used by
3c509                   7408   1  (initializing)
ipt_REJECT              2048   2  (autoclean)
ipt_LOG                 3344   7  (autoclean)
ipt_state                816   2  (autoclean)
ip_conntrack           22368   1  (autoclean) [ipt_state]
iptable_filter          1872   0  (unused)
ip_tables              13120   4  [ipt_REJECT ipt_LOG ipt_state iptable_filter]
es1371                 29904   0  (autoclean)
ac97_codec              7760   0  (autoclean) [es1371]

-- 
Frank
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
