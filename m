Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264985AbTGHQej (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Jul 2003 12:34:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbTGHQej
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Jul 2003 12:34:39 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:23048 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S264985AbTGHQeb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Jul 2003 12:34:31 -0400
Date: Tue, 8 Jul 2003 17:49:07 +0100
From: Christoph Hellwig <hch@infradead.org>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] AES for CryptoAPI - i586-optimized
Message-ID: <20030708174907.A18997@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	linux-kernel@vger.kernel.org
References: <20030708152755.GA24331@ghanima.endorphin.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030708152755.GA24331@ghanima.endorphin.org>; from clemens@endorphin.org on Tue, Jul 08, 2003 at 05:27:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 08, 2003 at 05:27:55PM +0200, Fruhwirth Clemens wrote:
> 
> Due to the recent discussion about the asm-optimized version of AES which is
> included in loop-AES, I'd like to point out that I've ported this
> implementation - Dr. Brian Gladman's btw. - to CryptoAPI a long time ago.

Cool, that means we just need to hash out the framework for optimized
implementations now..

A few more comments:

> diff -r --new-file -u crypto/Kconfig ../linux-2.5.58/crypto/Kconfig
> --- crypto/Kconfig	Thu Feb  6 13:53:47 2003
> +++ ../linux-2.5.58/crypto/Kconfig	Tue Feb  4 00:54:18 2003
> @@ -119,6 +119,26 @@
>  
>  	  See http://csrc.nist.gov/encryption/aes/ for more information.
>  
> +config CRYPTO_AES_586
> +	tristate "AES cipher algorithms (586)"
> +	depends on CRYPTO

Should also depend on CONFIG_X86 && !CONFIG_X86_64

> +$(obj)/aes-i586.o: $(obj)/aes-i586-asm.o crypto/aes-i586-glue.o
> +	$(LD) -r $(obj)/aes-i586-asm.o $(obj)/aes-i586-glue.o -o $(obj)/aes-i586.o

That's not how kernel makesfile work.  It should be something like

aes-i586-y		:= aes-i586-asm.o aes-i586-glue.o

> +// THE CIPHER INTERFACE

Please use C-style comments.

> +	if(key_length != 16 && key_length != 24 && key_length != 32)
> +	{

Should be

	if (key_length != 16 && key_length != 24 && key_length != 32) {

> +MODULE_DESCRIPTION("Rijndael (AES) Cipher Algorithm");
> +MODULE_LICENSE("Dual BSD/GPL");

MODULE_AUTHOR is missing.  Also the description should mention that
this is an optimized assembly version.
