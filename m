Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131942AbRDTT1c>; Fri, 20 Apr 2001 15:27:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131974AbRDTT1W>; Fri, 20 Apr 2001 15:27:22 -0400
Received: from cs.columbia.edu ([128.59.16.20]:47799 "EHLO cs.columbia.edu")
	by vger.kernel.org with ESMTP id <S131942AbRDTT1N>;
	Fri, 20 Apr 2001 15:27:13 -0400
Date: Fri, 20 Apr 2001 12:27:05 -0700 (PDT)
From: Ion Badulescu <ionut@cs.columbia.edu>
To: Roberto Nibali <ratz@tac.ch>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, <linux-kernel@vger.kernel.org>,
        Donald Becker <becker@scyld.com>, Andrew Morton <andrewm@uow.edu.au>
Subject: Re: Fix for Donald Becker's DP83815 network driver (v1.07)
In-Reply-To: <3AE068E7.72116BFB@tac.ch>
Message-ID: <Pine.LNX.4.33.0104201220450.5165-100000@age.cs.columbia.edu>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Apr 2001, Roberto Nibali wrote:

> No, it's not a bug but thank you for this tip. It's just a put-on limitation
> in the driver itself:
> 
> --- starfire.c~	Fri Apr 20 18:48:05 2001
> +++ starfire.c	Fri Apr 20 18:27:20 2001
> @@ -308,7 +308,7 @@
>  	void (*resume)(struct pci_dev *dev);	/* Device woken up */
>  };
>  
> -#define PCI_MAX_MAPPINGS 16
> +#define PCI_MAX_MAPPINGS 32

Ehh.. yes, I forgot about this. It's a limitation in the 2.2 compatibility 
code, 2.4 is not affected.

> This cures my problem. I've checked this and it seems as if Ion copied
> this from the sound/emu10k1/emu_wrapper.c code, where I understand that
> nobody will have more then 16 times the same soundcard. Ion, do I break
> something with this? If not, could you please adjust your driver?

Well, normally nobody will have more than 16 eth ports, either, because
net_init.c won't let them. So I'm not sure this is something *I* should fix.

I guess I'll send a patch to Alan that changes both the driver and 
net_init.c, once 2.2.20pre is started. If he takes it, great, otherwise 
you'll have to continue making this change for yourself.

> Thanks to all of you for your help. I learned a lot today.

You're welcome. :-)

Ion

-- 
  It is better to keep your mouth shut and be thought a fool,
            than to open it and remove all doubt.

