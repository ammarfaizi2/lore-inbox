Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314295AbSDRKsx>; Thu, 18 Apr 2002 06:48:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314296AbSDRKsw>; Thu, 18 Apr 2002 06:48:52 -0400
Received: from www.deepbluesolutions.co.uk ([212.18.232.186]:7177 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id <S314295AbSDRKsw>; Thu, 18 Apr 2002 06:48:52 -0400
Date: Thu, 18 Apr 2002 11:48:44 +0100
From: Russell King <rmk@arm.linux.org.uk>
To: Martin Dalecki <dalecki@evision-ventures.com>
Cc: Linus Torvalds <torvalds@transmeta.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] 2.5.8 IDE 38
Message-ID: <20020418114844.A15930@flint.arm.linux.org.uk>
In-Reply-To: <Pine.LNX.4.33.0204051657270.16281-100000@penguin.transmeta.com> <3CBBED42.50003@evision-ventures.com> <3CBE8E61.6070702@evision-ventures.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 18, 2002 at 11:14:09AM +0200, Martin Dalecki wrote:
> @@ -523,6 +513,12 @@
>  	unsigned	autodma    : 1;	/* automatically try to enable DMA at boot */
>  	unsigned	udma_four  : 1;	/* 1=ATA-66 capable, 0=default */
>  	unsigned	highmem	   : 1; /* can do full 32-bit dma */
> +	byte		slow;		/* flag: slow data port */
> +	unsigned no_io_32bit	   : 1;	/* disallow enabling 32bit I/O */
> +	byte		io_32bit;	/* 0=16-bit, 1=32-bit, 2/3=32bit+sync */
> +	unsigned no_unmask	   : 1;	/* disallow setting unmask bit */
> +	byte		unmask;		/* flag: okay to unmask other irqs */
> +

Just cosmetic... This causes the layout to be:

	1 bit
	1 bit
	1 bit
	align to word
	1 byte
	align to word
	1 bit
	align to word
	1 byte
	align to word
	1 bit
	align to word
	1 byte
	align to word

which is rather wasteful.  Any chance you can group the bits together
and the bytes together?

-- 
Russell King (rmk@arm.linux.org.uk)                The developer of ARM Linux
             http://www.arm.linux.org.uk/personal/aboutme.html

