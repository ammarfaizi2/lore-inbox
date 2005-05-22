Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261755AbVEVWlg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261755AbVEVWlg (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 May 2005 18:41:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261795AbVEVWlg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 May 2005 18:41:36 -0400
Received: from zproxy.gmail.com ([64.233.162.197]:38249 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261755AbVEVWlZ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 May 2005 18:41:25 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=Ky7pmZlkTQp1EV+yKm4EplHelH/vPpR/1EZWvJxK99DualzKUO7rWC9z37XGhac2EbA8GnOjHPkAFC3GdEg5GzJj0JBZDZWkWFsfO/pXSJCpgku50QvvBsgBCmCoUs7vIL5HY6fso8YCMmKqbQS8n44UI1gj5e/Q+x+maIgQPuE=
Message-ID: <9a874849050522154157cf7457@mail.gmail.com>
Date: Mon, 23 May 2005 00:41:21 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Bjorn Helgaas <bjorn.helgaas@hp.com>
Subject: Re: spurious 8259A interrupt: IRQ7
Cc: Lee Revell <rlrevell@joe-job.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1113512638.22496.47.camel@eeyore>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1113498693.18871.11.camel@mindpipe>
	 <1113511426.22496.43.camel@eeyore> <1113512210.19373.3.camel@mindpipe>
	 <1113512638.22496.47.camel@eeyore>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/05, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Thu, 2005-04-14 at 16:56 -0400, Lee Revell wrote:
> > Is the VIA IRQ fixup related to the "spurious interrupts" messages in
> > any way?  Googling the 2.4 threads on the issue gave me the impression
> > that it's related to broken hardware.  I think excessive disk activity
> > might trigger it.
> 
> If you need the VIA IRQ fixup and don't have it, I would expect
> some interrupt to be routed to the wrong IRQ.  That might give
> you a "spurious interrupt" on the wrong IRQ, but your device would
> probably just not work at all.
> 

For what it's worth I'll chime in with my own info on this subject.

I also see the 
   spurious 8259A interrupt: IRQ7.
messages from time to time. Actually I got one just a little while ago : 
   $ dmesg | grep spurious
   [18994.222451] spurious 8259A interrupt: IRQ7.
The system seems to be in good shape - it has never caused me any
actual trouble.

As for the via irq fixup I see this :
   $ dmesg | grep -i fixup
   [   74.629393] PCI: Via PIC IRQ fixup for 0000:00:09.0, from 255 to 3

The hardware is a ASUS A7M266 mobo with a AMD Athlon (t-bird) 1.4GHz CPU.

The kernel is 2.6.12-rc4-mm2 : 
   $ uname -a
   Linux dragon 2.6.12-rc4-mm2 #2 Mon May 16 18:14:13 CEST 2005 i686
unknown unknown GNU/Linux

I've seen some references to APIC for this issue, so here are the APIC
related settings in my .config :

   juhl@dragon:~/download/kernel/linux-2.6.12-rc4-mm2$ grep -i APIC .config
   CONFIG_X86_GOOD_APIC=y
   # CONFIG_X86_UP_APIC is not set


-- 
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
