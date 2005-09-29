Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932311AbVI2Xu1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932311AbVI2Xu1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Sep 2005 19:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932370AbVI2Xu1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Sep 2005 19:50:27 -0400
Received: from web34103.mail.mud.yahoo.com ([66.163.178.101]:40793 "HELO
	web34103.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932311AbVI2Xu0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Sep 2005 19:50:26 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=NOIvYuYBuSMmIZlykPRu72IFsnFmkY2RcdVZsKh55ESvI98hNaqKLWl+0owVAqCbIZvpbsIJLZ/EL97cq+JvPqCkMo5o+q5jNxACxtOX5B73dQV/7kw0XydO1SCDJvpsyEpI/PAQoYFVC6YOHHbJ06Cs+yxOajn2mP0nKA5usF4=  ;
Message-ID: <20050929235025.13166.qmail@web34103.mail.mud.yahoo.com>
Date: Thu, 29 Sep 2005 16:50:25 -0700 (PDT)
From: Wilson Li <yongshenglee@yahoo.com>
Subject: Re: Slow loading big kernel module in 2.6 on PPC platform
To: "linux-os \(Dick Johnson\)" <linux-os@analogic.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Samuel Masham <Samuel.Masham@jp.sony.com>
In-Reply-To: <Pine.LNX.4.61.0509290837500.22964@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>--- "linux-os (Dick Johnson)" <linux-os@analogic.com> wrote:
> 
> On Wed, 28 Sep 2005, Wilson Li wrote:
> 
> I have a module I am currently working on. It has some assembly
> stuff linked with it, so it was easy to modify. In the assembly
> I allocated 16 megabytes of static storage (using the .space
> keyword),
> first in the .data section, then in .rodata, then in .text. The
> .text section is where code exists. In no case did the module take
> more than 1/4 second to load. In all cases the size shown by
> `lsmod`
> reflected the enormous size of the module.
> 
> Now, that's static storage. If your code uses kmalloc() and
> friends to allocate a lot of storage when it is being loaded,
> then that's a different story. FYI, when you see a kernel message
> on the screen, that's not necessarily when it was "printed". It
> gets buffered, you know. If you want to time-check when various
> sections get control, to find out what's eating the time, then
> put the jiffie count into your kernel messages.
> 
> A simple macro using the __FUNCTION__ string and the jiffie
> count can go a long way towards finding out what's happening.
> 
> For instance, I once had a problem with continuous interrupts
> from a device, that couldn't be cleared, until the device was
> initialized. That slowed the system to a stand-still until
> I found that. The fix was easy, do some initialization before
> attaching the interrupt, at least enough to quiet the board.
> This board had an empty FPGA, whos bits need to be loaded
> with a bit-banger to make it work. The pin connected to an
> interrupt was just whatever-it-was-from-the-factory, before
> the intelligence was loaded. That system took about a minute
> for the first kernel message to be printed. Sometimes the
> system was very quiet <forever> and needed to be kicked.
> 
> 
> Cheers,
> Dick Johnson
> Penguin : Linux version 2.6.13 on an i686 machine (5589.55
> BogoMips).
> Warning : 98.36% of all statistics are fiction.
> 
> ****************************************************************
> The information transmitted in this message is confidential and may
> be privileged.  Any review, retransmission, dissemination, or other
> use of this information by persons or entities other than the
> intended recipient is prohibited.  If you are not the intended
> recipient, please notify Analogic Corporation immediately - by
> replying to this message or by sending an email to
> DeliveryErrors@analogic.com - and destroy all copies of this
> information, including any attachments, without reading or
> disclosing them.
> 
> Thank you.

Appreciate your advice and help. I finally tracked it down to the
function called in init_module() in kernel/module.c.
 
/* Allow arches to frob section contents and sizes.  */
err = module_frob_arch_sections(hdr, sechdrs, secstrings, mod);

which takes most of time (more then 99%) during module loading just
as the reply from Semuel earlier.

Wilson Li
 



		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
