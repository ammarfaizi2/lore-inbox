Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S273019AbTHFXvL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Aug 2003 19:51:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275017AbTHFXs2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Aug 2003 19:48:28 -0400
Received: from b.smtp-out.sonic.net ([208.201.224.39]:42932 "HELO
	b.smtp-out.sonic.net") by vger.kernel.org with SMTP id S275016AbTHFXsA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Aug 2003 19:48:00 -0400
X-envelope-info: <dhinds@sonic.net>
Date: Wed, 6 Aug 2003 16:35:27 -0700
From: David Hinds <dhinds@sonic.net>
To: "Hmamouche, Youssef" <youssef@ece.utexas.edu>
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
       Jeff Garzik <jgarzik@pobox.com>, linux-kernel@vger.kernel.org
Subject: Re: [PROBLEM] xircom CBE2-100(faulty) hangs kernel 2.4.{21, 22-pre8} (fwd)
Message-ID: <20030806163527.A27113@sonic.net>
References: <20030806124759.C30485@sonic.net> <Pine.LNX.4.21.0308061514470.2297-100000@linux08.ece.utexas.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0308061514470.2297-100000@linux08.ece.utexas.edu>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 06, 2003 at 03:55:02PM -0500, Hmamouche, Youssef wrote:
> 
> I'm a user. When I insert a card "into my laptop" I'd like it to
> work as advertised. If it doesn't work as advertised(because of some
> hardware failure in this case), I'd like the kernel to more or less
> let me know that something went wrong so I can return it. I wouldn't
> expect the kernel to freeze.

I accept this...

> Faulty hardware is very common in the PC era. I agree that it is
> hard to pin down hardware malfunctions when you don't know what to
> check for. However, There should be concern when it takes your whole
> system down.

I'd agree, that drivers should be made to not screw up when an
unexpected condition arises, where that's possible.  Like, not
crashing the OS if a device returns an unexpected value.

This particular problem (what seems to be an unacknowledged interrupt,
but that could be a symptom of something else) is troublesome and
likely impossible for the driver to detect and handle sanely.  Because
PCI interrupts are shared, and a driver cannot assume that its device
was responsible for any particular interrupt.

I believe that the 2.6 kernel provides a general central mechanism for
detecting and throttling unacknowledged interrupts, if that really is
the problem.  That's where this particular fix belongs, not in the
driver (and every other driver).

-- Dave

