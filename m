Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbTI0MQA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 08:16:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262432AbTI0MQA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 08:16:00 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:5573 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261703AbTI0MP7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 08:15:59 -0400
Date: Sat, 27 Sep 2003 14:15:56 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] helper for device list traversal
In-Reply-To: <20030927123933.A21629@infradead.org>
Message-ID: <Pine.GSO.4.21.0309271348560.6768-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 27 Sep 2003, Christoph Hellwig wrote:
> On Sat, Sep 27, 2003 at 01:34:15PM +0200, Geert Uytterhoeven wrote:
> > Is this what we should use to fix the currently broken list traversal[*] in
> > drivers/scsi/{a2091,gvp11,53c7xx}.c?
> 
> where does that [*] refere to?

To the part below. Sorry, I changed the structure of the mail but forgot to
remove the [*].

> > Currently ut uses
> > 
> >     struct Scsi_Host *instance;
> >     for (instance = first_instance; instance &&
> > 	 instance->hostt == xxx_template; instance = instance->next)
> > 
> > bust Scsi_Host.next was removed a while ago...
> 
> Most users of that construct want to use scsi_lookup_host (if they
> looked for a specific host struct).

The A2091 and GVP-II drivers want to traverse the list of SCSI host adapters in
their interrupt handler, to find their Scsi_Host instances and check whether
the (shared) interrupt was meant for one of them.

An alternative would be to register the interrupt handler multiple times and
use the Scsi_Host instance pointer as the interrupt handler data pointer.

For 53c7xx it's a bit more complex, I don't know anything about its internals.

In all 3 cases, I don't have the hardware...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

