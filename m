Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265576AbTFRW31 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 18:29:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265580AbTFRW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 18:29:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52459 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265576AbTFRW30
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 18:29:26 -0400
Date: Wed, 18 Jun 2003 23:43:23 +0100
From: viro@parcelfarce.linux.theplanet.co.uk
To: John Stoffel <stoffel@lucent.com>
Cc: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org,
       Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH CYCLADES 1/2] fix cli()/sti() for ISA Cyclom-Y boards
Message-ID: <20030618224323.GE6754@parcelfarce.linux.theplanet.co.uk>
References: <16112.56865.325452.254827@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16112.56865.325452.254827@gargle.gargle.HOWL>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 18, 2003 at 05:48:17PM -0400, John Stoffel wrote:
  
> -    save_flags(flags); cli();
> +    spin_lock_irqsave(&isa_card_lock, flags);
>  
>      if ((e1 = tty_unregister_driver(cy_serial_driver)))
>              printk("cyc: failed to unregister Cyclades serial driver(%d)\n",
>  		e1);
>  
> -    restore_flags(flags);
> +    spin_unlock_irqrestore(&isa_card_lock,flags);

It doesn't fix the problem and only makes the compile trouble go away.
Not to mention anything else, you are relying on a lot of code being
non-blocking.

Could you explain what is protected by disabling interrupts and taking
a spinlock here?

