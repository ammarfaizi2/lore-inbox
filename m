Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285325AbRLXU4I>; Mon, 24 Dec 2001 15:56:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285326AbRLXUzt>; Mon, 24 Dec 2001 15:55:49 -0500
Received: from grootstal.nijmegen.internl.net ([217.149.192.7]:31117 "EHLO
	grootstal.nijmegen.internl.net") by vger.kernel.org with ESMTP
	id <S285325AbRLXUzl>; Mon, 24 Dec 2001 15:55:41 -0500
Date: Mon, 24 Dec 2001 21:56:15 +0100
From: Frank van Maarseveen <F.vanMaarseveen@inter.NL.net>
To: Manfred Spraul <manfred@colorfullife.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: <=2.4.17 deadlock (RedHat 7.2, SMP, ext3 related?) (2)
Message-ID: <20011224215615.A22826@iapetus.localdomain>
In-Reply-To: <002101c18cb7$f575b3c0$010411ac@local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <002101c18cb7$f575b3c0$010411ac@local>; from manfred@colorfullife.com on Mon, Dec 24, 2001 at 09:17:00PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 24, 2001 at 09:17:00PM +0100, Manfred Spraul wrote:
> Frank,
> could you open your vmlinux file with gdb, and figure out where the 2
> stext_lock references lead to?
> stext_lock+1c82 just means that it spins trying to acquire a spinlock,
> but which one?
> IIRC
> gdb vmlinux
>     $x/30i 0xc03fe0a0
>     $x/30i 0xc0403050
> should be enough.

(gdb) x/30i 0xc03fe0a0                                          
0xc03fe0a0 <stext_lock+7272>:	lea    0xc04e79c0,%eax
0xc03fe0a6 <stext_lock+7278>:	call   0xc01062f4 <__read_lock_failed>
0xc03fe0ab <stext_lock+7283>:	pop    %eax
0xc03fe0ac <stext_lock+7284>:	jmp    0xc013fd3e <get_chrfops+78>
0xc03fe0b1 <stext_lock+7289>:	cmpb   $0x0,0xc05dd400
0xc03fe0b8 <stext_lock+7296>:	repz nop 
0xc03fe0ba <stext_lock+7298>:	jle    0xc03fe0b1 <stext_lock+7289>
0xc03fe0bc <stext_lock+7300>:	jmp    0xc013fde0 <get_chrfops+240>
0xc03fe0c1 <stext_lock+7305>:	push   %eax
0xc03fe0c2 <stext_lock+7306>:	lea    0xc04e79c0,%eax
0xc03fe0c8 <stext_lock+7312>:	call   0xc01062f4 <__read_lock_failed>
0xc03fe0cd <stext_lock+7317>:	pop    %eax
0xc03fe0ce <stext_lock+7318>:	jmp    0xc013feee <get_chrfops+510>
0xc03fe0d3 <stext_lock+7323>:	push   %eax
0xc03fe0d4 <stext_lock+7324>:	lea    0xc04e79c0,%eax
0xc03fe0da <stext_lock+7330>:	call   0xc01062d4 <__write_lock_failed>
0xc03fe0df <stext_lock+7335>:	pop    %eax
0xc03fe0e0 <stext_lock+7336>:	jmp    0xc013ff78 <register_chrdev+68>
0xc03fe0e5 <stext_lock+7341>:	push   %eax
0xc03fe0e6 <stext_lock+7342>:	lea    0xc04e79c0,%eax
0xc03fe0ec <stext_lock+7348>:	call   0xc01062d4 <__write_lock_failed>
0xc03fe0f1 <stext_lock+7353>:	pop    %eax
0xc03fe0f2 <stext_lock+7354>:	jmp    0xc013fff3 <register_chrdev+191>
0xc03fe0f7 <stext_lock+7359>:	push   %eax
0xc03fe0f8 <stext_lock+7360>:	lea    0xc04e79c0,%eax
0xc03fe0fe <stext_lock+7366>:	call   0xc01062d4 <__write_lock_failed>
0xc03fe103 <stext_lock+7371>:	pop    %eax
0xc03fe104 <stext_lock+7372>:	jmp    0xc01400a3 <unregister_chrdev+79>
0xc03fe109 <stext_lock+7377>:	cmpb   $0x0,0xc05dd400
0xc03fe110 <stext_lock+7384>:	repz nop 
(gdb) x/30i 0xc0403050                    
0xc0403050 <stext_lock+27672>:	nop    
0xc0403051 <stext_lock+27673>:	jle    0xc0403048 <stext_lock+27664>
0xc0403053 <stext_lock+27675>:	jmp    0xc0292971 <find_compressor+53>
0xc0403058 <stext_lock+27680>:	cmpb   $0x0,0xc057d540
0xc040305f <stext_lock+27687>:	repz nop 
0xc0403061 <stext_lock+27689>:	jle    0xc0403058 <stext_lock+27680>
0xc0403063 <stext_lock+27691>:	jmp    0xc0292ac0 <ppp_create_interface+72>
0xc0403068 <stext_lock+27696>:	cmpb   $0x0,0xc057d540
0xc040306f <stext_lock+27703>:	repz nop 
0xc0403071 <stext_lock+27705>:	jle    0xc0403068 <stext_lock+27696>
0xc0403073 <stext_lock+27707>:	jmp    0xc0292df0 <ppp_destroy_interface+68>
0xc0403078 <stext_lock+27712>:	cmpb   $0x0,(%ebx)
0xc040307b <stext_lock+27715>:	repz nop 
0xc040307d <stext_lock+27717>:	jle    0xc0403078 <stext_lock+27712>
0xc040307f <stext_lock+27719>:	jmp    0xc0292e60 <ppp_destroy_interface+180>
0xc0403084 <stext_lock+27724>:	cmpb   $0x0,(%ebx)
0xc0403087 <stext_lock+27727>:	repz nop 
0xc0403089 <stext_lock+27729>:	jle    0xc0403084 <stext_lock+27724>
0xc040308b <stext_lock+27731>:	jmp    0xc0292eb0 <ppp_destroy_interface+260>
0xc0403090 <stext_lock+27736>:	cmpb   $0x0,(%ebx)
0xc0403093 <stext_lock+27739>:	repz nop 
0xc0403095 <stext_lock+27741>:	jle    0xc0403090 <stext_lock+27736>
0xc0403097 <stext_lock+27743>:	jmp    0xc0292f40 <ppp_destroy_interface+404>
0xc040309c <stext_lock+27748>:	cmpb   $0x0,(%ebx)
0xc040309f <stext_lock+27751>:	repz nop 
0xc04030a1 <stext_lock+27753>:	jle    0xc040309c <stext_lock+27748>
0xc04030a3 <stext_lock+27755>:	jmp    0xc0293014 <ppp_destroy_interface+616>
0xc04030a8 <stext_lock+27760>:	push   %eax
0xc04030a9 <stext_lock+27761>:	push   %ecx
0xc04030aa <stext_lock+27762>:	push   %edx
(gdb) p stext_lock
$1 = {<text variable, no debug info>} 0xc03fc438 <stext_lock>
(gdb) p stext_lock+0x1c82
$1 = (<text variable, no debug info> *) 0xc03fe0ba <stext_lock+7298>
(gdb) p stext_lock+0x6c30
$2 = (<text variable, no debug info> *) 0xc0403068 <stext_lock+27696>

-- 
Frank
