Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263886AbTEGQQQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263970AbTEGQQP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:16:15 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:10244 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263886AbTEGQQO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:16:14 -0400
Date: Wed, 7 May 2003 09:28:30 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Jens Axboe <axboe@suse.de>
cc: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5 ide 48-bit usage
In-Reply-To: <20030507084920.GA823@suse.de>
Message-ID: <Pine.LNX.4.44.0305070915470.2726-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Jens Axboe wrote:
> 
> I did a patch for 2.4 some weeks ago that added (what I consider) proper
> 48-bit lba usage to ide-disk.

Ok, let me disagree a bit.

At least if I read the patch correctly, theer's no way for upper layers to
say "I want 48-bit addressing" - it's just turned on automatically for
high sectors (or big transfers).

Well, you can mark the drive itself as wanting 48-bit transfers, but you 
can't do it on a per-request basis.

And I think this is 100% equivalent to the 6 vs 10 vs 16-byte SCSI command 
issue, and I really think it should b esolved the same way. Namely, you 
should be able to (on a "struct request" level) explicitly say that you 
want the big requests, and then the default prep_fn() would do roughly 
what you do now by default.

That way something like a SG_IO interface could force one mode or the 
other on a per-request basis.

Comments?

			Linus

