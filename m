Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261301AbUBZX1q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 18:27:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbUBZXWT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 18:22:19 -0500
Received: from fw.osdl.org ([65.172.181.6]:62164 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261234AbUBZXUl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 18:20:41 -0500
Date: Thu, 26 Feb 2004 15:21:39 -0800
From: Andrew Morton <akpm@osdl.org>
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org,
       viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] __cacheline_aligned always in own section
Message-Id: <20040226152139.5b881a12.akpm@osdl.org>
In-Reply-To: <200402270009.26768.vda@port.imtp.ilyichevsk.odessa.ua>
References: <20040226064551.1E44B2C57E@lists.samba.org>
	<200402270009.26768.vda@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua> wrote:
>
> I compile my kernels for 486 but buils system aligns
> functions and labels to 16 bytes, with results like this:
> 
> 00000730 <islpci_eth_tx_timeout>:
>      730:       55                      push   %ebp
>      731:       89 e5                   mov    %esp,%ebp
>      733:       8b 45 08                mov    0x8(%ebp),%eax
>      736:       8b 40 64                mov    0x64(%eax),%eax
>      739:       05 14 03 00 00          add    $0x314,%eax
>      73e:       ff 40 14                incl   0x14(%eax)
>      741:       5d                      pop    %ebp
>      742:       c3                      ret
>      743:       90                      nop
>      744:       90                      nop
>      745:       90                      nop
>      746:       90                      nop
>      747:       90                      nop
>      748:       90                      nop
>      749:       90                      nop
>      74a:       90                      nop
>      74b:       90                      nop
>      74c:       90                      nop
>      74d:       90                      nop
>      74e:       90                      nop
>      74f:       90                      nop
> 
> Losing on average 15/2 bytes to alignment, my kernel lose
> # echo $((`cat System.map | grep '0 ' | wc -l`*15/2))
> 149632
> bytes only due to function alignment, not counting jump target
> alighment.
> 
> Is there any way to prevent this?

Yes, there are ways of turning off a lot of this alignment padding and it
makes a significant different in code size.  You need to dig around in the
gcc documentation for the several -*align* options.

IIRC, not all of the padding could be turned off (the gcc options were not
complete) but it's a couple of years since I investigated this.

