Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266499AbUFUWq7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266499AbUFUWq7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 18:46:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266492AbUFUWq7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 18:46:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:62848 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266506AbUFUWqz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 18:46:55 -0400
X-Authenticated: #12437197
Date: Tue, 22 Jun 2004 01:48:29 +0300
From: Dan Aloni <da-x@gmx.net>
To: Andrew Morton <akpm@osdl.org>
Cc: Paul Fulghum <paulkf@microgate.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] missing NULL check in drivers/char/n_tty.c
Message-ID: <20040621224829.GA26607@callisto.yi.org>
Reply-To: Dan Aloni <da-x@colinux.org>
References: <20040621063845.GA6379@callisto.yi.org> <20040620235824.5407bc4c.akpm@osdl.org> <20040621073644.GA10781@callisto.yi.org> <20040621003944.48f4b4be.akpm@osdl.org> <20040621082430.GA11566@callisto.yi.org> <40D6F986.3010904@microgate.com> <20040621114605.4df2c05e.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040621114605.4df2c05e.akpm@osdl.org>
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 21, 2004 at 11:46:05AM -0700, Andrew Morton wrote:
> Paul Fulghum <paulkf@microgate.com> wrote:
> >
> > 13 other drivers call ldisc.chars_in_buffer without checking
> >  for ldisc.chars_in_buffer == NULL, but only inside conditional
> >  compilation for debug output. The value is not used, only logged.
> >  These conditional debug items look like cut and paste from
> >  one serial driver to another, and I doubt
> >  they have been recently used (or used at all).
> > 
> >  Which would be better?
> >  1. Ignore this
> >  2. Fix conditional debug output to check
> >      for ldisc.chars_in_buffer==NULL
> >  3. Remove conditional debug output
> 
> Option 1 is quite valid.  There are no bugs here, yes?
> 
> If someone for some reason wants to clean all this up, the best way would
> be to require that ->chars_in_buffer always be valid, hence remove all
> those checks.

Apropos cleanups in the tty subsystem, what is the purpose of all 
the *_paranoia_check() calls that almost every driver duplicates for 
itself? Perhaps this can be removed.

-- 
Dan Aloni
da-x@colinux.org
