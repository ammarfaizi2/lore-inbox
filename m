Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261700AbTCLPVj>; Wed, 12 Mar 2003 10:21:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261726AbTCLPVj>; Wed, 12 Mar 2003 10:21:39 -0500
Received: from pusa.informat.uv.es ([147.156.10.98]:28088 "EHLO
	pusa.informat.uv.es") by vger.kernel.org with ESMTP
	id <S261700AbTCLPVg>; Wed, 12 Mar 2003 10:21:36 -0500
Date: Wed, 12 Mar 2003 16:32:14 +0100
To: Mark Hahn <hahn@physics.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
Subject: Re: is irq smp affinity good for anything?
Message-ID: <20030312153214.GA21259@pusa.informat.uv.es>
References: <20030312101116.GB12206@pusa.informat.uv.es> <Pine.LNX.4.44.0303120858480.19850-100000@coffee.psychology.mcmaster.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Pine.LNX.4.44.0303120858480.19850-100000@coffee.psychology.mcmaster.ca>
User-Agent: Mutt/1.3.28i
From: uaca@alumni.uv.es
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Mark

thanks again for your reply

On Wed, Mar 12, 2003 at 09:00:13AM -0500, Mark Hahn wrote:
> > I think that user space code always has to make the best use of cache as it
> > can... in other words, i don't want to use a cpu exclusively for a device
> > that delivers 6000 ints/second
> 
> right, 6K is trivial.
> 
> > as spin_irq_locks just disables interrupts locally I should get better
> > latency that just one ISR on that particular cpu could at least reduce
> > a little the number of times that interrupts get disabled on that cpu
> > 
> > ... that was my reasoning...
> 
> but disabling irq's is not a really heavy operation, especially
> at only 6KHz.

yes... I assumead It could be noticiable...

> > but latency gets worse... that's not comphrensible for me...
> 
> if the machine is unloaded with cache-polluting user-space tasks,
> what's the latency?


in brief: 16 seconds of accumulated latency from 300 seconds of running time

no any user space load, just receiving and ATM traffic at 6000 interrupts/second

you can see my first post to lkml: in this case see the idle*/* results

	Ulisses

PD: just for fun: is it possible to change irq priorities on Linux+IO-APIC?

---------------------------------------------------------------------------------------------



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

>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>


                Debian GNU/Linux: a dream come true
-----------------------------------------------------------------------------
"Computers are useless. They can only give answers."            Pablo Picasso

--->	Visita http://www.valux.org/ para saber acerca de la	<---
--->	Asociación Valenciana de Usuarios de Linux		<---
 
