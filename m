Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263082AbUBRElv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Feb 2004 23:41:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263513AbUBRElu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Feb 2004 23:41:50 -0500
Received: from fw.osdl.org ([65.172.181.6]:31657 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S263082AbUBRElt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Feb 2004 23:41:49 -0500
Date: Tue, 17 Feb 2004 20:42:47 -0800
From: Andrew Morton <akpm@osdl.org>
To: Keith Owens <kaos@ocs.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6] IBM PowerPC Virtual Ethernet Driver
Message-Id: <20040217204247.13cc035a.akpm@osdl.org>
In-Reply-To: <7789.1077077976@kao2.melbourne.sgi.com>
References: <1077065118.1082.83.camel@gaston>
	<7789.1077077976@kao2.melbourne.sgi.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Keith Owens <kaos@ocs.com.au> wrote:
>
> On Wed, 18 Feb 2004 11:45:20 +1100, 
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> >BITFIELDS ARE EVIL !!!
> >The compiler is perfectly free, afaik, to re-order them
> 
> Not it is not.  C standard (ISO/IEC 9899:1999 (E)), section 6.7.2.1.
> 
> 10 ...  If enough space remains, a bit-field that immediately follows
>    another bit-field in a structure shall be packed into adjacent bits
>    of the same unit. ...
> 
> 13 Within a structure object, the non-bit-field members and the units
>    in which bit-fields reside have addresses that increase in the order
>    in which they are declared. ...
> 
> There is no scope for a compiler to reorder the members or the bit
> fields of a structure.

Problem is portability between different architectures, especially little
endian versus big endian.  The 3c59x driver used to use a bitfield to
represent hardware registers and had some lovely ifdeffery to make it work
on ppc hardware.

It's safe enough in arch-specific code but one may as well use the same
idioms as are used in generic code.

