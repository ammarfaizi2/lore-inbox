Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129614AbQL2LOp>; Fri, 29 Dec 2000 06:14:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129781AbQL2LOg>; Fri, 29 Dec 2000 06:14:36 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32782 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S129614AbQL2LO2>;
	Fri, 29 Dec 2000 06:14:28 -0500
From: Russell King <rmk@arm.linux.org.uk>
Message-Id: <200012291031.eBTAVO301699@flint.arm.linux.org.uk>
Subject: Re: [PATCH] remove __mark_buffer_dirty and related changes
To: marcelo@conectiva.com.br (Marcelo Tosatti)
Date: Fri, 29 Dec 2000 10:31:23 +0000 (GMT)
Cc: torvalds@transmeta.com (Linus Torvalds),
        quintela@fi.udc.es (Juan Quintela),
        riel@conectiva.com.br (Rik van Riel), linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0012281627060.12364-100000@freak.distro.conectiva> from "Marcelo Tosatti" at Dec 28, 2000 04:35:21 PM
X-Location: london.england.earth.mulky-way.universe
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti writes:
> +int mark_buffer_dirty(struct buffer_head *bh)
>  {
> +	if (!atomic_set_buffer_dirty(bh)) {
> +		return 1;
> +	}
> +	return 0;
>  }

Any particular reason why you don't to:

	return !atomic_set_buffer_dirty(bh);

which generates better code on some systems?
   _____
  |_____| ------------------------------------------------- ---+---+-
  |   |         Russell King        rmk@arm.linux.org.uk      --- ---
  | | | | http://www.arm.linux.org.uk/personal/aboutme.html   /  /  |
  | +-+-+                                                     --- -+-
  /   |               THE developer of ARM Linux              |+| /|\
 /  | | |                                                     ---  |
    +-+-+ -------------------------------------------------  /\\\  |
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
