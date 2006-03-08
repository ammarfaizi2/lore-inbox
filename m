Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932501AbWCHISu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932501AbWCHISu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 03:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932504AbWCHISu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 03:18:50 -0500
Received: from xproxy.gmail.com ([66.249.82.204]:12815 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932501AbWCHISt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 03:18:49 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=TcaSqJvqJ8F1dLYh9WNwyRcz2QeaCS5pvCxhfTxG0inIPkFqS1b5tOGCV1Wmn+30KuhouW5jNJbeGTjb771/szvq3oGSA7NZedB1zOnaqLGjzpNPoswb+SM3nSmMXZeY/BqZcxTuO2Pp9wlpSQgAQ1X872IjYR7LJBbCTCJY8/g=
Message-ID: <4807377b0603080018h1b952e3av4966d81b85f6d346@mail.gmail.com>
Date: Wed, 8 Mar 2006 00:18:49 -0800
From: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
To: "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Subject: Re: de2104x: interrupts before interrupt handler is registered
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robert Hancock" <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <200603071051.35791.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <5N5Ql-30C-11@gated-at.bofh.it> <440D918D.2000502@shaw.ca>
	 <Pine.LNX.4.61.0603070908460.9133@chaos.analogic.com>
	 <200603071051.35791.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/7/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> On Tuesday 07 March 2006 07:21, linux-os (Dick Johnson) wrote:
> Maybe you could handle this with a PCI quirk that runs before
> pci_enable_device().  IIRC, we considered exposing a separate
> interface for PCI IRQ allocation and routing, but decided it
> wasn't worth the complexity since so few devices would need it.
>
> > Linux-2.4.x had IRQs that were stable. One could put
> > a handler in place that would handle the possible burst of interrupts
> > upon startup. Then this was changed so the IRQ value is wrong
> > until an unrelated and illogical event occurs.
>
> There are good reasons to wait to allocate the IRQ until you have
> a driver that cares about the device.  I'm sorry that this broke
> your specific case.

FWIW, I'd be interested in following up on something like this in
another thread because e100 appears to have (at least in one
reporter's dual e100 machine) a similar "hardware problem" where a
shared interrupt line gets asserted too early and the kernel prints a
Nobody Cared message.

So we have a new way of doing things that exposes more broken
hardware, shouldn't we provide a way for that hardware to continue
working?

http://bugzilla.kernel.org/show_bug.cgi?id=5918

Jesse
