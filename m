Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265650AbUFSAJO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265650AbUFSAJO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Jun 2004 20:09:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265390AbUFSAIB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Jun 2004 20:08:01 -0400
Received: from [81.187.239.184] ([81.187.239.184]:710 "EHLO
	mail.newtoncomputing.co.uk") by vger.kernel.org with ESMTP
	id S265785AbUFSADk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Jun 2004 20:03:40 -0400
Date: Sat, 19 Jun 2004 01:03:30 +0100
From: matthew-lkml@newtoncomputing.co.uk
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Stop printk printing non-printable chars
Message-ID: <20040619000330.GC5286@newtoncomputing.co.uk>
References: <20040618205355.GA5286@newtoncomputing.co.uk> <20040618213252.GS20632@lug-owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040618213252.GS20632@lug-owl.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 18, 2004 at 11:32:52PM +0200, Jan-Benedict Glaw wrote:
> On Fri, 2004-06-18 21:53:55 +0100, matthew-lkml@newtoncomputing.co.uk <matthew-lkml@newtoncomputing.co.uk>
> wrote in message <20040618205355.GA5286@newtoncomputing.co.uk>:
> > printk to even consider printing _any_ non-printable characters at all.
> 
> It's dandy if you pump out some data via serial link.

Is printk ever used to send anything out via a serial link? I assumed it
was only kernel log messages (that should really be fairly sane). Log
messages sent to serial printer, etc, don't want dodgy chars in them
that may mess up the printer, do they?

> 
> > It makes all characters out of the range 32..126 (except for newline)
> > print as a '?'.
> 
> I don't see why that's needed. I'd say let's better fix ACPI to put
> those strings as a hexdump or something like that.

Looking at the ACPI code (and not understanding it too well) it looks
like this data is retrieved from the BIOS, but is only printed here for
info and not actually used anywhere. In this case, I'd think there isn't
a lot of point checking for data correctness in the ACPI code. As
someone else pointed out, though, other things can cause the kernel log
to print nasty chars that are unwanted, so there should really be a
check here anyway.

> > +		if (p[0] != '\n' && (p[0] < 32 || p[0] > 126)) {
> 
> So you're ripping off something that could be a nice feature and place
> some slow path. By the way, why do you use 'p[0]' instead of '*p'?

The string has just been through the equivalent of sprintf, so I guess
this is hardly going to slow it down much more. Used p[0] to look
tidier, matching another "if" statement 5 lines up. In new patch used
*p, as it doesn't really matter.

Thanks,

-- 
Matthew
