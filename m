Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932597AbWB1XeA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932597AbWB1XeA (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Feb 2006 18:34:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932600AbWB1XeA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Feb 2006 18:34:00 -0500
Received: from wproxy.gmail.com ([64.233.184.205]:8098 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932597AbWB1Xd7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Feb 2006 18:33:59 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=RXLl1NxIxVXMT1UC/HLhZrGbmCb9QFOdP2xSIhP+9gO2DKK5msD53TJUGGQy4iNxLzZH3ClhCHklBQ7rutLxjYG0+v9YpaGTjfF0ZayRodApiR3CrzdV10HPFE+hmrm5IY7OYhbRmS0r8DMf8PHnQoQ+UAS5tWEDp014ErJum30=
Message-ID: <9a8748490602281533s13139d50o223c220bc853c482@mail.gmail.com>
Date: Wed, 1 Mar 2006 00:33:59 +0100
From: "Jesper Juhl" <jesper.juhl@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.16-rc5-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20060228151544.019aa2b4.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060228042439.43e6ef41.akpm@osdl.org>
	 <9a8748490602281313t4106dcccl982dc2966b95e0a7@mail.gmail.com>
	 <20060228151544.019aa2b4.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/06, Andrew Morton <akpm@osdl.org> wrote:
> "Jesper Juhl" <jesper.juhl@gmail.com> wrote:
> >
> >  Since I'm in X when the lockup happens and I don't have enough time
> >  from clicking the eclipse icon to the box locks up to make a switch to
> >  a text console I don't know if an Oops or similar is dumped to the
> >  console (there's nothing in the locks after a reboot)  :-(
>
> In a shell, do
>
>         sleep 10 ; /path-to-eclipse
>

Yeah, I did (in a plain text console) :

export DISPLAY=:0.0 ; sleep 3 ; eclipse

then switched to tty0 and got the following - written down by hand so
I left out some bits, hope I got the important bits - a few things may
have scrolled off the top of the screen though..
If needed this is completely repproducible, so in a pinch I could
reboot with a higher fb resolution + write down every little bit by
hand, but I hope the following is enough :

EIP is at __wake_up_common+0x15/0x60
...
Process swapper (pid:0, threadinfo=c0454000 task=c03b9ae0)
Stack: ...
...
Call trace:
  show_stack_log_lvl		show_registers
  die				do_page_fault
  error_code			__wake_up
  __wake_up_bit			wake_up_bit
  unlock_buffer			end_buffer_read_sync
  end_bio_bh_io_sync		bio_endio
  __end_that_request_first	end_that_request_chunk
  scsi_end_request		scsi_io_completion
  sd_rw_intr			scsi_finish_command
  scsi_softirq_done		blk_done_softirq
  __do_softirq			do_softirq
==============
  irq_exit			do_IRQ
  common_interrupt		cpu_idle
  rest_init			start_kernel
  0xc0100210
Code: ...
...
Kernel panic - not syncing: Fatal exception in interrupt
BUG: warning at arch/i386/kernel/smp.c:538/smp_call_function
  show_trace			dump_stack
  smp_call_function		smp_send_stop
  panic				die
  do_page_fault			error_code
  __wake_up			__wake_up_bit
  wake_up_bit			unlock_buffer
  end_buffer_read_sync		end_bio_bh_io_sync
  bio_endio			__end_that_request_first
  end_that_request_chunk	scsi_end_request
  scsi_io_completion		sd_rw_intr
  scsi_finish_command		scsi_softirq_done
  blk_done_softirq		__do_softirq
  do_softirq
===========
  irq_exit			do_IRQ
  common_interrupt		cpu_idle
  rest_init			start_kernel
  0xc0100210



--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
