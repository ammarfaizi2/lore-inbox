Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314277AbSFXPzP>; Mon, 24 Jun 2002 11:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314325AbSFXPzO>; Mon, 24 Jun 2002 11:55:14 -0400
Received: from [62.70.58.70] ([62.70.58.70]:47232 "EHLO mail.pronto.tv")
	by vger.kernel.org with ESMTP id <S314277AbSFXPzO> convert rfc822-to-8bit;
	Mon, 24 Jun 2002 11:55:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Jes Sorensen <jes@trained-monkey.org>, Dave Hansen <haveblue@us.ibm.com>
Subject: Re: acenic >4gig sendfile problem
Date: Mon, 24 Jun 2002 17:54:59 +0200
User-Agent: KMail/1.4.1
Cc: linux-kernel@vger.kernel.org
References: <3D05204B.4010103@us.ibm.com> <m3r8iwvgl8.fsf@trained-monkey.org>
In-Reply-To: <m3r8iwvgl8.fsf@trained-monkey.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200206241755.00082.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

But...

sendfile() doesn't support >4gig anyway - does it?
that's the (yet unimplemented) sendfile64()

roy

-- 
Roy Sigurd Karlsbakk, Datavaktmester

Computers are like air conditioners.
They stop working when you open Windows.

On Monday 24 June 2002 17:31, Jes Sorensen wrote:
> >>>>> "Dave" == Dave Hansen <haveblue@us.ibm.com> writes:
>
> Dave> When doing sendfile with my acenic card on my 8xPIII-700 and PAE
> Dave> running 2.4.18, I'm getting all zeros in the files being
> Dave> transmitted.  Running the Redhat 2.4.18-4 kernel fixes the
> Dave> problem.  I saw this entry in the rpm's changelog: * Sat Aug 25
> Dave> 2001 Ingo Molnar <mingo@redhat.com> - fix the acenic driver bug
> Dave> that caused random kernel memory being sent out on the wire, on
> Dave> x86 systems with more than 4 GB RAM.
>
> Actually I think you're hitting a bug in pci_map_page() rather than in
> the acenic.driver.
>
> Try the patch from Ben LaHaise included below.
>
> Jes
>
>
> ------- Start of forwarded message -------
> Resent-Message-Id: <200206102358.g5ANwbx23959@toomuch.toronto.redhat.com>
> Date: Mon, 10 Jun 2002 19:56:44 -0400
> From: Benjamin LaHaise <bcrl@redhat.com>
> To: Marcelo Tosatti <marcelo@conectiva.com.br>,
>    Linux Kernel <linux-kernel@vger.kernel.org>
> Subject: highmem pci dma mapping does not work, missing cast in
> asm-i386/pci.h Message-ID: <20020610195644.C13225@redhat.com>
> Mime-Version: 1.0
> Content-Type: text/plain; charset=us-ascii
> Resent-From: bcrl@redhat.com
> Resent-Date: Mon, 10 Jun 2002 19:58:37 -0400
> Resent-To: jes@wildopensource.com
>
> Hello all,
>
> There's a missing cast in pci_map_page that causes 64 bit capable
> drivers to access the wrong memory for highmem pages.  Please
> include the patch below to fix it.
>
> 		-ben

