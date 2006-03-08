Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751477AbWCHQGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751477AbWCHQGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Mar 2006 11:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751672AbWCHQGI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Mar 2006 11:06:08 -0500
Received: from atlrel6.hp.com ([156.153.255.205]:20446 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1751477AbWCHQGH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Mar 2006 11:06:07 -0500
From: Bjorn Helgaas <bjorn.helgaas@hp.com>
To: "Jesse Brandeburg" <jesse.brandeburg@gmail.com>
Subject: Re: de2104x: interrupts before interrupt handler is registered
Date: Wed, 8 Mar 2006 09:05:59 -0700
User-Agent: KMail/1.8.3
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "Robert Hancock" <hancockr@shaw.ca>,
       linux-kernel <linux-kernel@vger.kernel.org>
References: <5N5Ql-30C-11@gated-at.bofh.it> <200603071051.35791.bjorn.helgaas@hp.com> <4807377b0603080018h1b952e3av4966d81b85f6d346@mail.gmail.com>
In-Reply-To: <4807377b0603080018h1b952e3av4966d81b85f6d346@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603080905.59470.bjorn.helgaas@hp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 08 March 2006 01:18, Jesse Brandeburg wrote:
> On 3/7/06, Bjorn Helgaas <bjorn.helgaas@hp.com> wrote:
> > On Tuesday 07 March 2006 07:21, linux-os (Dick Johnson) wrote:
> > Maybe you could handle this with a PCI quirk that runs before
> > pci_enable_device().  IIRC, we considered exposing a separate
> > interface for PCI IRQ allocation and routing, but decided it
> > wasn't worth the complexity since so few devices would need it.
> >
> > > Linux-2.4.x had IRQs that were stable. One could put
> > > a handler in place that would handle the possible burst of interrupts
> > > upon startup. Then this was changed so the IRQ value is wrong
> > > until an unrelated and illogical event occurs.
> >
> > There are good reasons to wait to allocate the IRQ until you have
> > a driver that cares about the device.  I'm sorry that this broke
> > your specific case.
> 
> FWIW, I'd be interested in following up on something like this in
> another thread because e100 appears to have (at least in one
> reporter's dual e100 machine) a similar "hardware problem" where a
> shared interrupt line gets asserted too early and the kernel prints a
> Nobody Cared message.
> 
> So we have a new way of doing things that exposes more broken
> hardware, shouldn't we provide a way for that hardware to continue
> working?

Booting with "pci=routeirq" gives the previous behavior.

It would be interesting to know whether that makes a difference
in the e100 issue you mention.
