Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265118AbUAVWrM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 17:47:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265125AbUAVWrM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 17:47:12 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:26862 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265118AbUAVWrH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 17:47:07 -0500
Message-ID: <401052D1.4040306@mvista.com>
Date: Thu, 22 Jan 2004 14:46:41 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
CC: "Amit S. Kale" <amitkale@emsyssoft.com>,
       Hollis Blanchard <hollisb@us.ibm.com>,
       KGDB bugreports <kgdb-bugreport@lists.sourceforge.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Powerpc Linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PPC KGDB changes and some help?
References: <20040120172708.GN13454@stop.crashing.org> <30216351-4CEF-11D8-A2A1-000A95A0560C@us.ibm.com> <20040122154529.GE15271@stop.crashing.org> <200401222136.10887.amitkale@emsyssoft.com> <20040122164521.GF15271@stop.crashing.org>
In-Reply-To: <20040122164521.GF15271@stop.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Rini wrote:
> 
> 
> FWIW, this is true of KGDB on all PPCs.  IIRC, so long as the serial
> definitions are filled out statically, the stub currently in kernel.org
> for PPC can do first-line-of-C already.
> 
> 
>>How about changing the code in kgdbstub to allow kgdb to be configured in one 
>>of the following ways:
>>Late kgdb - kgdb comes up after smp_init in the kernel boot sequence. kgdb8250 
>>can be used with more flexibility through kernel command line options. One 
>>can boot a kgdb kernel without activating kgdb. Works with the interface 
>>chosen by kernel command line (kgdb8250 and kgdbeth for the moment).
> 
A further thought on this.  I think kgdb should take control on oops, panic and 
other bad news things.  This without being anthing but configured in.  Thus the 
command line options to set up the interface, etc, should not automatically 
connect to gdb.
> 
> Which is basically how it goes now, right?
> 
> 
>>Early kgdb - kgdb comes up right at the begining of start_kernel at the cost 
>>of flexibility. It doesn't show any messages such as "waiting for gdb". 

I question the utility of ever using this message.  Either the user has asked 
for the connection, either via a ^C or the command line or a breakpoint was hit. 
  If he asked, why tell him?  If it is a breakpoint, it is foolish and dangerous 
to call any outside function, such as printk.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

