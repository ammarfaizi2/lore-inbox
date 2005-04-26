Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbVDZTde@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbVDZTde (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 15:33:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261753AbVDZTde
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 15:33:34 -0400
Received: from postman4.arcor-online.net ([151.189.20.158]:54964 "EHLO
	postman.arcor.de") by vger.kernel.org with ESMTP id S261752AbVDZTd1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 15:33:27 -0400
Date: Tue, 26 Apr 2005 21:34:40 +0200
From: Juergen Quade <quade@hsnr.de>
To: Prasanna S Panchamukhi <prasanna@in.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: system-freeze: kprobe and do_gettimeofday
Message-ID: <20050426193440.GA16597@hsnr.de>
References: <20050423101251.GA327@hsnr.de> <20050425155649.GA30272@in.ibm.com> <20050425160859.GA23019@hsnr.de> <20050426145210.GC32766@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20050426145210.GC32766@in.ibm.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 26, 2005 at 08:22:10PM +0530, Prasanna S Panchamukhi wrote:
> 
> On Mon, Apr 25, 2005 at 06:08:59PM +0200, Juergen Quade wrote:
> > On Mon, Apr 25, 2005 at 09:26:49PM +0530, Prasanna S Panchamukhi wrote:
> > > On Sat, Apr 23, 2005 at 12:12:51PM +0200, Juergen Quade wrote:
> > > > Playing around with kprobe I noticed, that "kprobing"
> > > > the function "do_gettimeofday" completly freezes the
> > > > system (2.6.12-rc3). Other functions like "do_fork" or
> > > 
> > > Kprobe on "do_gettimeofday" seems to work fine on 4-way SMP i386 box.
> > > What is configuration of your machine?
> > 
> > Thank you for your answer!
> > Find my kernel-config attached.
> > The processor of the system is an Pentium M
> > (1400MHz, 512MByte Memory - nothing specific).
> > 
> 
> I tested with your configuration file and it still
> works fine. Can you get some more info about current tasks 
> using Alt+SysRq+t and  Alt+SysRq+d keys.

I did now a lot of additional tests. When running
"insmod kgettime.ko" from the console (not from x-windows)
I get:

kprobe registered address c0107bd0 // output from the module
double fault, gdt at c049bd00 [255 bytes]
double fault, tss at c03d4060
eip = c0103c86, esp = db932000
eax = ffffffff, ebx = db932134, ecx = 0000000d, edx = 00000000
esi = db932080, edi = 0000000d

Alt+SysRq did not work...

Then I removed all my modules (except 2) I was able to load the module
without problems. I added module by module and checked every time with
"insmod kgettime.ko". When loading the "ohci1394" module it crashed
again. But next time I loaded the "ohci"-module first - no crash.  (So I
don't think it is the ohci-module). I was able to load all modules and
it still worked.

Hmmm. What else to check?

          Juergen.
