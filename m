Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932523AbWGaU6j@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932523AbWGaU6j (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 16:58:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932458AbWGaU6i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 16:58:38 -0400
Received: from waste.org ([66.93.16.53]:58310 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932523AbWGaU6h (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 16:58:37 -0400
Date: Mon, 31 Jul 2006 15:57:25 -0500
From: Matt Mackall <mpm@selenic.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@osdl.org>,
       ak@suse.de
Subject: Re: [PATCH] x86 built-in command line (resend)
Message-ID: <20060731205725.GL6908@waste.org>
References: <20060731171259.GH6908@waste.org> <44CE54D6.4040309@zytor.com> <20060731192844.GK6908@waste.org> <44CE5B74.4060409@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44CE5B74.4060409@zytor.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 31, 2006 at 12:35:16PM -0700, H. Peter Anvin wrote:
> Matt Mackall wrote:
> >On Mon, Jul 31, 2006 at 12:07:02PM -0700, H. Peter Anvin wrote:
> >>Matt Mackall wrote:
> >>>I'm resending this as-is because the earlier thread petered out
> >>>without any strong arguments against this approach. x86_64 patch to
> >>>follow.
> >>"No strong arguments?"
> >>
> >>I still maintain that this patch has the wrong priority in case more 
> >>than one set of arguments are provided.
> >
> >But you still haven't answered how that lets you work around firmware
> >that passes parameters you don't like.
> >
> 
> That a fairly unique problem, and is most likely in a minority 
> application.  For that case a CONFIG option to ignore the 
> firmware-provided command line would make sense.  I do not believe it 
> should be the only option or even the default.

It's not the default. The default is all args come from the
bootloader.

At the risk of repeating myself, here are all possible features and
behaviors carefully enumerated again:

Possible features:
a) allow dealing with bootloaders that don't pass arguments
b) allow dealing with bootloaders that pass bogus arguments
c) allow dealing with bootloaders that run up against length limits
d) allow dealing with bootloaders where changing arguments dynamically
   is difficult
e) provide friendly defaults

Possible behaviors:
1) command line overrides built-in (won't work with b, works with the
rest)
2) built-in overrides command line (not so great for e, works with the
rest)
3) command line appends to built-in (generally broken as our command
parser can't arbitrarily override earlier arguments in most cases)
4) built-in appends to command line (same story)

Now I basically think behavior (e) is worthless. Embedded folks don't
care if the kernel's friendly and it's a solved problem for distros
too. Anyone else is building a kernel for themselves and don't need
defaults.

By comparison, the value of (b) is that you can control things you
otherwise can't. 

> It would be particularly good if this could be standardized across 
> architectures, which is another reason to do it right.

Yes. They should all clearly do (2).

-- 
Mathematics is the supreme nostalgia of our time.
