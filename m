Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271147AbTG1XJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jul 2003 19:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271163AbTG1XJ5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jul 2003 19:09:57 -0400
Received: from kweetal.tue.nl ([131.155.3.6]:51473 "EHLO kweetal.tue.nl")
	by vger.kernel.org with ESMTP id S271147AbTG1XJx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jul 2003 19:09:53 -0400
Date: Tue, 29 Jul 2003 01:09:51 +0200
From: Andries Brouwer <aebr@win.tue.nl>
To: "Ghozlane Toumi" <gtoumi@laposte.net>
Cc: <Andries.Brouwer@cwi.nl>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sgi partitionning fix (Was: 2.6.0-test1 on alpha : disk label numbering trouble)
Message-ID: <20030728230951.GC1845@win.tue.nl>
References: <UTC200307281315.h6SDFOY08368.aeb@smtp.cwi.nl> <030201c3550f$dec61620$0a00a8c0@toumi> <041201c35551$8af611c0$0a00a8c0@toumi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <041201c35551$8af611c0$0a00a8c0@toumi>
User-Agent: Mutt/1.3.25i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 28, 2003 at 11:45:12PM +0200, Ghozlane Toumi wrote:

> However, I found out that sgi partitionning had this "renumbering"
> issue even before viro's patch.
> I don't know if this is correct, in any case this is an untested patch
> that changes this behaviour for sgi partitions.
> patch is attached because of dumb mailer.
> --------------------
>         for(i = 0; i < 16; i++, p++) {
>                 blocks = be32_to_cpu(p->num_blocks);
>                 start  = be32_to_cpu(p->first_block);
>                 if (blocks)
> -                       put_partition(state, slot++, start, blocks);
> +                       put_partition(state, i+1, start, blocks);
>         }
> --------------------

Hmm. The previous change was not because there is something
intrinsically good with some way of numbering partitions,
but because it is very inconvenient when partition numbering
changes.

Thus, the previous patch made OSF in 2.6 do as it did in 2.4.

But here the 2.6 behaviour is already that of 2.4.21, and you
change away from that. Not a good idea.

Andries

