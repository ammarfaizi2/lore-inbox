Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261946AbVBULGa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261946AbVBULGa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Feb 2005 06:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261948AbVBULGa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Feb 2005 06:06:30 -0500
Received: from chewbacca.hagos.de ([213.217.124.234]:64647 "EHLO mail.hagos.de")
	by vger.kernel.org with ESMTP id S261946AbVBULGW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Feb 2005 06:06:22 -0500
From: Klaus Muth <muth@hagos.de>
Organization: HAGOS eG
To: Jonathan Sambrook <jonathan@dsvr.net>
Subject: Re: kernel panic with 2.4.26
Date: Mon, 21 Feb 2005 12:06:11 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <200501210715.03716.muth@hagos.de> <200502161402.33666.muth@hagos.de> <421363D4.5050209@dsvr.net>
In-Reply-To: <421363D4.5050209@dsvr.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200502211206.11037.muth@hagos.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 16. Februar 2005 16:16 schrieb Jonathan Sambrook:
> Klaus Muth wrote:
> > Am Mittwoch, 16. Februar 2005 12:14 schrieb Jonathan Sambrook:
> >
> > Server oopsed again 10 minutes ago. Same symptoms.
>
> <sigh> schade
Your help is really appreciated.

> > The kernel upgrade did not
> > help... Would an update to an 2.6 kernel help or should I better turn
> > hyperthreading off?
>
> My experience is running _modified_ 2.4 kernels. Turning HT off solved
> the problem here. Of course YMMV if the root cause is different.
Hypertreading turned off, machine crashed again in a matter of minutes. But
 I took a photograph again and did run kymoops over the yield:
---------------------------------------
Unable to handle kernel paging request at virtual addresss ffffffff
f8a3589d
*pde = 00000000
Oops: 0002
CPU:    0
EIP:    0010:[<f8a3589d>]    Not tainted
Using defaults from ksymoops -t elf32-i386 -a i386
EFLAGS: 00010256
eax: ffffffff   ebx: 00000002   ecx: f5942000   edx: 0000000d
esi: e162f000   edi: 00000000   ebp: f60d701c   esp: c0379ee4
ds: 0018   es: 0018   ss: 0018
Process swapper (pid: 0, stackpage=c0379000)
Stack: 00000000 f593d580 00000000 f77ba480 00000040 f60d7000 00000000 f5942000
       0093d580 f593fd80 f8a24982 f593d580 f6347188 f77ba480 00000002 00000000
       00000000 00000000 f5942200 00000000 f8a24a61 f77ba480 f593d588 f621ec40
Call Trace:    [<f8a24982>] [<f8a24a61>] [<c010a041>] [<c010a236>] [<c0106d60>]
  [<c0106d60>] [<c0106d60>] [<c0106d60>] [<c0106d89>] [<c0106df2>] [<c0105000>]
  [<c010504f>]
 <0>Kernel panic: Aiee, killing interrupt handler!
Warning (Oops_read): Code line not seen, dumping what data is available


>>EIP; f8a3589d <[ftdi_sio]ftdi_read_bulk_callback+361/438>   <=====

>>eax; ffffffff <END_OF_CODE+754d54c/????>
>>ecx; f5942000 <_end+35507244/385d6244>
>>esi; e162f000 <_end+211f4244/385d6244>
>>ebp; f60d701c <_end+35c9c260/385d6244>
>>esp; c0379ee4 <init_task_union+1ee4/2000>

Trace; f8a24982 <[usb-uhci]process_urb+1e6/230>
Trace; f8a24a61 <[usb-uhci]uhci_interrupt+95/fc>
Trace; c010a041 <handle_IRQ_event+5d/88>
Trace; c010a236 <do_IRQ+a6/ec>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d60 <default_idle+0/34>
Trace; c0106d89 <default_idle+29/34>
Trace; c0106df2 <cpu_idle+3e/54>
Trace; c0105000 <_stext+0/0>
Trace; c010504f <rest_init+4f/50>
---------------------------------------

This strongly suggests a problem in the ftdi_sio_usb USB to serial driver
and I filed this at the SourceForge bugtracker already.

klaus

