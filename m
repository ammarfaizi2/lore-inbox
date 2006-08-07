Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbWHGPP3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbWHGPP3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 11:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWHGPP3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 11:15:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:25297 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932125AbWHGPP3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 11:15:29 -0400
Date: Mon, 7 Aug 2006 08:15:19 -0700
From: Andrew Morton <akpm@osdl.org>
To: Andy Whitcroft <apw@shadowen.org>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: x86_64 command line truncated
Message-Id: <20060807081519.945df808.akpm@osdl.org>
In-Reply-To: <44D75079.5080403@shadowen.org>
References: <20060806030809.2cfb0b1e.akpm@osdl.org>
	<44D742DD.6090004@shadowen.org>
	<p73wt9kprng.fsf@verdi.suse.de>
	<44D75079.5080403@shadowen.org>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 07 Aug 2006 15:38:49 +0100
Andy Whitcroft <apw@shadowen.org> wrote:

> Andi Kleen wrote:
> > Andy Whitcroft <apw@shadowen.org> writes:
> > 
> >> It seems that the command line on x86_64 is being truncated during boot:
> > 
> > in mm right?
> >> Will try and track it down.
> > 
> > Don't bother, it is likely "early-param" (the patch from
> > hell). I'll investigate.
> > 
> > -Andi
> 
> Well I've narroed it down to the following patch from Andrew:
> 
> x86_64-mm-early-param.patch

Not me.  My only contribution to that patch was to scrog the changelog ;)
I'll be fixing that sometime.

I think that patch doesn't have a future, although Andi hasn't yet dropped it.

> Basically, that leads setup_arch to return saved_command_line as _the_ 
> command_line.  We then run parse_args() against it which assumes it may 
> irrevocabaly change command_line.  Previous to this patch 
> saved_command_line and command_line were separate and this was not an issue.
> 
> It feels like we should be following the model in the newly added 
> parse_early_parms() and taking a local copy of the command_line here.
> 

