Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261677AbTI0LfI (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Sep 2003 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261703AbTI0LfI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Sep 2003 07:35:08 -0400
Received: from mail2.sonytel.be ([195.0.45.172]:46772 "EHLO witte.sonytel.be")
	by vger.kernel.org with ESMTP id S261677AbTI0LfD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Sep 2003 07:35:03 -0400
Date: Sat, 27 Sep 2003 13:34:15 +0200 (MEST)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Christoph Hellwig <hch@infradead.org>
cc: Linux Kernel Development <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] helper for device list traversal
In-Reply-To: <200309270508.h8R58tHE015032@hera.kernel.org>
Message-ID: <Pine.GSO.4.21.0309271330460.6768-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Sep 2003, Linux Kernel Mailing List wrote:
> ChangeSet 1.1217.10.16, 2003/09/25 12:10:17-05:00, hch@lst.de
> 
> 	[PATCH] helper for device list traversal
> 	
> 	This patch adds shost_for_each_device().  It's used to abstract out
> 	scsi_host.my_devices traversal.  The next step will be to replace
> 	the current simple implementation with one that's fully locked down
> 	an reference counted.

Is this what we should use to fix the currently broken list traversal[*] in
drivers/scsi/{a2091,gvp11,53c7xx}.c?

Currently ut uses

    struct Scsi_Host *instance;
    for (instance = first_instance; instance &&
	 instance->hostt == xxx_template; instance = instance->next)

bust Scsi_Host.next was removed a while ago...

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

