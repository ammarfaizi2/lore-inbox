Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261442AbUBYVDS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 16:03:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261444AbUBYVDR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 16:03:17 -0500
Received: from 104.engsoc.carleton.ca ([134.117.69.104]:46740 "EHLO
	quickman.certainkey.com") by vger.kernel.org with ESMTP
	id S261442AbUBYU46 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 15:56:58 -0500
Date: Wed, 25 Feb 2004 15:46:51 -0500
From: Jean-Luc Cooke <jlcooke@certainkey.com>
To: Christophe Saout <christophe@saout.de>
Cc: Andrew Morton <akpm@osdl.org>, jmorris@intercode.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: cryptoapi highmem bug
Message-ID: <20040225204651.GA7140@certainkey.com>
References: <20040224223425.GA32286@certainkey.com> <1077663682.6493.1.camel@leto.cs.pocnet.net> <20040225043209.GA1179@certainkey.com> <20040224220030.13160197.akpm@osdl.org> <20040225153126.GA7395@leto.cs.pocnet.net> <20040225155121.GA7148@leto.cs.pocnet.net> <20040225154453.GB4218@certainkey.com> <20040225181540.GB8983@leto.cs.pocnet.net> <20040225201216.GA6799@certainkey.com> <20040225203920.GA1816@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040225203920.GA1816@leto.cs.pocnet.net>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 25, 2004 at 09:39:32PM +0100, Christophe Saout wrote:
> >  I didn't get a response back when suggesting we store IV and MAC info for
> >  each block.
> 
> Yes, sorry, it's on my todo list (but I kept pushing it back because
> explaining the problems in detail would have taken a lot of time). ;)

:)  That's cool.

> >  Can we do this?
> 
> It's very non-trivial. Think about journalling filesystems, write
> ordering and atomicity. If the system crashes between two write
> operations we must be able to still correctly read the data. And
> write to these "crypto info blocks" should be done in a ways that
> doesn't kill performance. Do you have a proposal?

I see.  From a security point of view, no.  OMACs need to be updated after
the data is updated to keep integrity checks passing.  IVs need to be updated
before the data is updated or plaintext is leaked. (IV + data + OMAC can be
written to device at once).

I assume then that IVs and OMACs will not be stored in the same read-chunk as
the data then?  Bummer if this is the case.

> It would make dm-crypt *a lot more* complicated. We need caches
> for the info blocks, etc...

Yes I see how that would be nasty.  But I've never written for things this
low to the device so you are likly better off without me.

> >  Can I do this?  Where's the source, in
> >  2.3.6-main?
> 
> Which source? dm-crypt? In 2.6.3-bk and 2.6.3-mm*. Andrew's latest
> tree also has my first "more secure IV proposal" patch in it and I
> posted a (broken, racy) hmac IV patch in the other thread.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

-- 
http://www.certainkey.com
Suite 4560 CTTC
1125 Colonel By Dr.
Ottawa ON, K1S 5B6
