Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932420AbVHKUdX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932420AbVHKUdX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Aug 2005 16:33:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932421AbVHKUdW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Aug 2005 16:33:22 -0400
Received: from fsmlabs.com ([168.103.115.128]:55689 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S932420AbVHKUdW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Aug 2005 16:33:22 -0400
Date: Thu, 11 Aug 2005 14:39:06 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Steven Rostedt <rostedt@goodmis.org>
cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       Coywolf Qi Hunt <coywolf@gmail.com>, 7eggert@gmx.de,
       Ukil a <ukil_a@yahoo.com>, linux-kernel@vger.kernel.org
Subject: Re: Need help in understanding x86 syscall
In-Reply-To: <1123783862.17269.89.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.61.0508111430280.19138@montezuma.fsmlabs.com>
References: <4Ae73-6Mm-5@gated-at.bofh.it> <E1E3DJm-0000jy-0B@be1.lrz> 
 <Pine.LNX.4.61.0508110954360.14541@chaos.analogic.com> 
 <1123770661.17269.59.camel@localhost.localdomain>  <2cd57c90050811081374d7c4ef@mail.gmail.com>
  <Pine.LNX.4.61.0508111124530.14789@chaos.analogic.com> 
 <1123775508.17269.64.camel@localhost.localdomain> 
 <1123777184.17269.67.camel@localhost.localdomain>  <2cd57c90050811093112a57982@mail.gmail.com>
  <2cd57c9005081109597b18cc54@mail.gmail.com>  <Pine.LNX.4.61.0508111310180.15153@chaos.analogic.com>
  <1123781187.17269.77.camel@localhost.localdomain> 
 <Pine.LNX.4.61.0508111342170.15330@chaos.analogic.com>
 <1123783862.17269.89.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Aug 2005, Steven Rostedt wrote:

> On Thu, 2005-08-11 at 13:46 -0400, linux-os (Dick Johnson) wrote:
> 
> > 
> > I was talking about the one who had the glibc support to use
> > the newer system-call entry (who's name can confuse).
> > 
> > You are looking at code that uses int 0x80. It's an interrupt,
> > therefore, in the kernel, once the stack is set up, interrupts
> > need to be (re)enabled.
> 
> int is a call to either an interrupt or exception procedure. 0x80 is
> setup in Linux to be a trap and not an interrupt vector. So it does
> _not_ turn off interrupts.

It's actually a vector, that's all you can install in the IDT. Also a trap 
doesn't advance the instruction pointer, so you resume at the trapping 
instruction (e.g. vector 14/page fault), 0x80 is an interrupt gate. One 
of the distinguishing differences is that 0x80 may be entered via int 
0x80 from all ring levels. The reason why int 0x80 doesn't disable 
interrupts is because issuing int 0x80 directly is similar to doing a far 
call and therefore doesn't have the same effect as a real interrupt being 
issued.
