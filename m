Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUBZW3k (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Feb 2004 17:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261213AbUBZW3k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Feb 2004 17:29:40 -0500
Received: from 168.imtp.Ilyichevsk.Odessa.UA ([195.66.192.168]:40201 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S261210AbUBZW3e (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Feb 2004 17:29:34 -0500
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
To: Rusty Russell <rusty@rustcorp.com.au>, akpm@osdl.org, torvalds@osdl.org
Subject: Re: [PATCH] __cacheline_aligned always in own section
Date: Fri, 27 Feb 2004 00:09:26 +0200
User-Agent: KMail/1.5.4
Cc: viro@parcelfarce.linux.theplanet.co.uk, linux-kernel@vger.kernel.org
References: <20040226064551.1E44B2C57E@lists.samba.org>
In-Reply-To: <20040226064551.1E44B2C57E@lists.samba.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200402270009.26768.vda@port.imtp.ilyichevsk.odessa.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 26 February 2004 08:44, Rusty Russell wrote:
> Name: Always Put Cache Aligned Code in Own Section: Even Modules
> Status: Tested on 2.6.3-bk7
>
> We put ____cacheline_aligned things in their own section, simply
> because we waste less space that way.  Otherwise we end up padding
> innocent variables to the next cacheline to get the required
> alignment.
>
> There's no reason not to do this in modules, too.

On a related matter,

I compile my kernels for 486 but buils system aligns
functions and labels to 16 bytes, with results like this:

00000730 <islpci_eth_tx_timeout>:
     730:       55                      push   %ebp
     731:       89 e5                   mov    %esp,%ebp
     733:       8b 45 08                mov    0x8(%ebp),%eax
     736:       8b 40 64                mov    0x64(%eax),%eax
     739:       05 14 03 00 00          add    $0x314,%eax
     73e:       ff 40 14                incl   0x14(%eax)
     741:       5d                      pop    %ebp
     742:       c3                      ret
     743:       90                      nop
     744:       90                      nop
     745:       90                      nop
     746:       90                      nop
     747:       90                      nop
     748:       90                      nop
     749:       90                      nop
     74a:       90                      nop
     74b:       90                      nop
     74c:       90                      nop
     74d:       90                      nop
     74e:       90                      nop
     74f:       90                      nop

Losing on average 15/2 bytes to alignment, my kernel lose
# echo $((`cat System.map | grep '0 ' | wc -l`*15/2))
149632
bytes only due to function alignment, not counting jump target
alighment.

Is there any way to prevent this?
--
vda

