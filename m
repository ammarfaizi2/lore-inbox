Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261525AbTCJWMB>; Mon, 10 Mar 2003 17:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261522AbTCJWMB>; Mon, 10 Mar 2003 17:12:01 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:40861 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S261504AbTCJWLs>; Mon, 10 Mar 2003 17:11:48 -0500
Date: Mon, 10 Mar 2003 23:22:22 +0100
To: linux-kernel@vger.kernel.org
Subject: IRQ affinity good for lowering interrupt latency?
Message-ID: <20030310222222.GA26247@pusa.informat.uv.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi all

I have measured interrupt latency of a bi-processor system with akpm's intlat/timepeg
utilities and kernel 2.4.20. The system uses is a two-way PIII@800Mhz
-- Intel motherboard, ISP 2100 if I remember ok, with a SCSI disk on a aic-7896

I tried to know if I could reduce the latency of an interrupt handler by
binding this handler to a particular cpu and not allowing any other
interrupt to execute in that cpu.

I found that overall latency increases, but also the latency on both cpus,
that is, I could not reduce the latency on the interrupt I was interested

I also tried to disallowing just scsi & ethernet handlers to execute on the
cpu in wich I'm binding the interrupt handler I'm insterested with, I get
similar results

the interrupt handler I'm interested with is an ATM card receiving
around 6000 interrupts/second

any comment will be greatly appreciated

Thanks in advance


I attach a sample table

	Ulisses

                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

bound-*      -> binding irq's to specific cpu's
not_bound-*  -> default irq balancing
idle-*       -> no extra load, just receiving interrupts, and using irq balancing 
                (not tcpdumping from the device)

*-round?     -> same test, just another sample

The following loads were added:

*/cpu_io_load* -> adding a process load, and another process doing intensive I/O (write) +tcpdump
*/cpu_load*    -> process load +tcpdump
*/io_load*     -> I/O load +tcpdump
*/no_load*     -> just tcpdump (always running on the ATM card)

time unit is microseconds

<config name>                                <cpu0>      <cpu1>     <both cpu>   <running time>
bound-round1/cpu_io_load.conf-capturando-atm 72721403.12 32011026.4 104732430.03 334000000
bound-round1/cpu_load.conf-capturando-atm 17330835.03 22209536.73 39540372.14 301000000
bound-round1/io_load.conf-capturando-atm 26490926.85 35473241.13 61964168.45 332000000
bound-round1/no_load.conf-capturando-atm 17723058.55 24066995.44 41790054.28 300000000
bound-round2/cpu_io_load.conf-capturando-atm 70139325.9899999 31673560.18 101812886.64 332000000
bound-round2/cpu_load.conf-capturando-atm 20834850.44 22103680.54 42938531.31 300000000
bound-round2/io_load.conf-capturando-atm 25995860.86 35030250.99 61026112.51 331000000
bound-round2/no_load.conf-capturando-atm 16926317.67 22890716.86 39817034.87 300000000
not_bound-round1/cpu_io_load.conf-capturando-atm 27857114.18 30214652.36 58071767.23 330000000
not_bound-round1/cpu_load.conf-capturando-atm 17861389.71 17826837.68 35688227.83 300000000
not_bound-round1/io_load.conf-capturando-atm 28921009.86 30368027.35 59289037.74 329000000
not_bound-round1/no_load.conf-capturando-atm 17095881.6 17804144.4 34900026.4 301000000
not_bound-round2/cpu_io_load.conf-capturando-atm 28958809.19 29576235.94 58535045.78 333000000
not_bound-round2/cpu_load.conf-capturando-atm 17654701.15 19004883.19 36659584.82 301000000
not_bound-round2/io_load.conf-capturando-atm 30383447.95 31634551.35 62017999.99 332000000
not_bound-round2/no_load.conf-capturando-atm 18103003.63 17573932.55 35676936.69 300000000
idle-round1/no_load.conf-idle 0 0 16030718.21 300000000
idle-round2/no_load.conf-idle 0 0 16106698.44 300000000
