Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262730AbSKMVOY>; Wed, 13 Nov 2002 16:14:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262464AbSKMVNU>; Wed, 13 Nov 2002 16:13:20 -0500
Received: from mailgw.cvut.cz ([147.32.3.235]:45471 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id <S264639AbSKMVMF>;
	Wed, 13 Nov 2002 16:12:05 -0500
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Date: Wed, 13 Nov 2002 22:18:32 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: RE: FW: i386 Linux kernel DoS (clarification)
Cc: Christoph Hellwig <hch@infradead.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-mailer: Pegasus Mail v3.50
Message-ID: <76D1FF66BB6@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 13 Nov 02 at 21:36, Alan Cox wrote:

> Try this
> 
> (In the Linus Torvalds tradition its not tested)

I'll test it, but before kernel compiles...
 
> --- arch/i386/kernel/entry.S~   2002-11-13 21:30:37.000000000 +0000
> +++ arch/i386/kernel/entry.S    2002-11-13 21:29:47.000000000 +0000
> @@ -126,6 +126,7 @@
>  ENTRY(lcall7)
>     pushfl          # We get a different stack layout with call
>                 # gates, which has to be cleaned up later..
> +   andl $~0x4500, (%esp)   # Clear NT since we are doing an iret

this will clear 'D' and 'T' in caller after we do
iret (if lcall7 returns, of course). I'm not sure that callers
expect that.

> @@ -390,6 +392,9 @@
>     pushl $do_divide_error
>     ALIGN
>  error_code:
> +   pushfl
> +   andl $~0x4500, (%esp)       # NT must be clear, do a cld for free
> +   popfl

I believe that NT should be automagically cleared by int.
                                                Best regards,
                                                      Petr Vandrovec
                                                      vandrove@vc.cvut.cz
                                                      
