Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285532AbRLGUwt>; Fri, 7 Dec 2001 15:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285533AbRLGUwj>; Fri, 7 Dec 2001 15:52:39 -0500
Received: from holomorphy.com ([216.36.33.161]:20355 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S285532AbRLGUwX>;
	Fri, 7 Dec 2001 15:52:23 -0500
Date: Fri, 7 Dec 2001 12:52:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] 2.4.16 kernel/printk.c (per processorinitializationcheck)
Message-ID: <20011207125220.B903@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	linux-kernel@vger.kernel.org
In-Reply-To: <3C103A1E.2524A7B7@zip.com.au> <Pine.LNX.4.21.0112071651360.22868-100000@freak.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
User-Agent: Mutt/1.3.17i
In-Reply-To: <Pine.LNX.4.21.0112071651360.22868-100000@freak.distro.conectiva>; from marcelo@conectiva.com.br on Fri, Dec 07, 2001 at 04:52:07PM -0200
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 07, 2001 at 04:52:07PM -0200, Marcelo Tosatti wrote:
> How hard would it be to fix that on ia64 code? 
> I'm really not willing to apply this kludge... 

It's possible, but the off-list discussion's consensus centered
around this being a bootstrap ordering issue, where drivers may
not be called from the application processors (at least not universally)
until they have been initialized to some degree. printk() is in the
unique position of performing such calls, and that is the idea around
which this patch is centered. Specifically, on those architectures
where some initialization of kernel virtual addressing is required to
access memory regions from which console (or any) I/O is done, the
driver calls may not be done from application processors until they
have been initialized (on IA64, this is initializing the uncached
region's region register and installing TLB fault handlers).

So this is actually a broader issue than IA64 alone, though
IA64 seems to be the first to have encountered it. The patch here
provides a hook for all affected architectures to protect themselves
against this issue, although there are perhaps other ways.


Cheers,
Bill
